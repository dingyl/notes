<?php
//controller的定义
use Phalcon\Mvc\Controller;

class IndexController extends Controller
{
    public function indexAction()
    {
        echo '<h1>Hello!</h1>';
    }
}

?>

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
