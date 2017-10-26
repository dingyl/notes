<?php
//程序运行出错后将不报任何错误的停止

//controller的定义
use Phalcon\Mvc\Controller;

class IndexController extends Controller
{
    public function indexAction()
    {

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
