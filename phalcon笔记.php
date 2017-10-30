<?php
//程序运行出错后将不报任何错误的停止

//controller的定义
use Phalcon\Mvc\Controller;

class IndexController extends Controller
{
    public function indexAction()
    {
        //在控制器中的echo 不会输出任何内容

        if ($this->request->isPost()) {};

        //sql操作
        $user = Users::findFirst(
            array(
                "(email = :email: OR username = :email:) AND password = :password: AND active = 'Y'",
                'bind' => array(
                    'email'    => $email,
                    'password' => sha1($password)
                )
            )
        );

        //session
        $this->session->set(
            'auth',
            array(
                'id'   => $user->id,
                'name' => $user->name
            )
        );
        $this->session->get('auth');

        $this->flash->success('Welcome ' . $user->name);
        $this->flash->error('Wrong email/password');



        //控制器操作
        //request操作
        $value = $this->request->getPost('key');
        //获取所有的post提交数据
        $this->request->getPost();

        $user = new Users();
        $login    = $this->request->getPost('login');
        $password = $this->request->getPost('password');
        $user->login = $login;
        // Store the password hashed
        $user->password = $this->security->hash($password);
        $user->save();
        $this->security->checkHash($password, $user->password)


        

        //url跳转
        // Forward to the 'invoices' controller if the user is valid
        return $this->forward('invoices/index');
        return $this->dispatcher->forward(
            array(
                'controller' => 'invoices',
                'action'     => 'index'
            )
        );

        // Take the active controller/action from the dispatcher
        $controller = $this->dispatcher->getControllerName();
        $action = $this->dispatcher->getActionName();

        //有三个变量传递到视图中：title, menu 和 post ：
        $this->view->setVar("title", $post->title);
        $this->view->setVar("post", $post);
        $this->view->setVar("menu", Menu::find());
        $this->view->setVar("show_navigation", true);
    }
}


model定义
use Phalcon\Mvc\Model;
class Users extends Model
{
    public $id;
    public $name;
    public $email;
}

view中
变量可以使用过滤器格式化或修改，管道操作符 “|” 用于接收过滤器过滤变量：

{{ post.title|e }}
{{ post.content|striptags }}
{{ name|capitalize|trim }}
e   Applies Phalcon\Escaper->escapeHtml to the value
escape  Applies Phalcon\Escaper->escapeHtml to the value
trim    Applies the trim PHP function to the value. Removing extra spaces
striptags   Applies the striptags PHP function to the value. Removing HTML tags
slashes Applies the slashes PHP function to the value. Escaping values
stripslashes    Applies the stripslashes PHP function to the value. Removing escaped quotes
capitalize  Capitalizes a string by applying the ucwords PHP function to the value
lowercase   Change the case of a string to lowercase
uppercase   Change the case of a string to uppercase
length  Counts the string length or how many items are in an array or object
nl2br   Changes newlines \n by line breaks (<br />). Uses the PHP function nl2br
sort    Sorts an array using the PHP function asort
json_encode Converts a value into its JSON representation




<h1>Robots</h1>
<ul>
{% for robot in robots %}
  <li>{{ robot.name|e }}</li>
{% endfor %}
</ul>

<h1>Robots</h1>
{% for robot in robots %}
  {% for part in robot.parts %}
  Robot: {{ robot.name|e }} Part: {{ part.name|e }} <br/>
  {% endfor %}
{% endfor %}


<h1>Cyborg Robots</h1>
<ul>
{% for robot in robots %}
  {% if robot.type = "cyborg" %}
  <li>{{ robot.name|e }}</li>
  {% endif %}
{% endfor %}
</ul>

变量赋值
在模板文件中，可以使用 “set” 设置或改变变量的值：
{% set fruits = ['Apple', 'Banana', 'Orange'] %}
{% set name = robot.name %}



标签生成器
<?php echo $this->tag->form("signup/register"); ?>
<p>
    <label for="name">Name</label>
    <?php echo $this->tag->textField("name"); ?>
</p>

<p>
    <label for="email">E-Mail</label>
    <?php echo $this->tag->textField("email"); ?>
</p>

<p>
    <?php echo $this->tag->submitButton("Register"); ?>
</p>

</form>
<?php
echo $this->tag->linkTo(
    "signup",
    "Sign Up Here!"
);
?>
