<?php
1.x

2.x
	安装basic
		浏览器访问web目录

		http://192.168.24.128/share/yii2/web/index.php?r=hello/index
		访问hello控制器的actionIndex方法

	config
		web.php 配置web应用
			'cookieValidationKey' => 'cookie',//用来给cookie数据进行加密
		db.php配置数据库
	controller定义
		namespace app\controllers;
		use yii\web\Controller;
		//引用数据模型
		use app\models\Article;
		class HelloController extends Controller{

			//指定模板文件
			public $layout = "common";

			//控制器方法命名
			public function actionIndex(){

				//数据查找
					单表查找
						//返回所有查询数据
						$results = Article::findBySql("select articleid from articl=:id",array(':id'=>1))->all();

						//返回一条数据对象
						$results = Article::findBySql("select articleid from articl=:id",array(':id'=>1))->one();

						//返回数组
						$results = Article::findBySql("select articleid from articl=:id",array(':id'=>1))->asArray()->one();

						Article::find()->where(['articleid'=>1])->all();
						Article::find()->where(['>','articleid',1])->all();
						Article::find()->where(['between','articleid',1,2	])->all();
						Article::find()->where(['like','title','like1'])->all();

						//批量返回num条数据
						$arr = Article::find()->where(['articleid'=>1])->batch(num);
						一般配合foreach语句
					关联查找
						//调用不存在的comment方法时,yii会去找__get方法调用getComment方法,并在返回值的后面,加上->all或者one方法,这要根据getComment方法中调用的时hasOne还是hasMany方法
						$model->comments();//这个方法是有缓存的,第二次取的值时缓存值,删除缓存可以用unset($model->comments());方法

						//在查询文章的时候就关联getComments方法
						Article::find()->with('comments')->all();


				//数据删除
					$results[0]->delete();
					Article::deleteAll();
				//添加数据
					$model = new Article;
					$model->prop = value;
					//验证是否匹配自定义的验证规则
					$model->validate();
					if($model->hasErrors()){
						echo "date is error";die;
					}
					$model->save();
				//修改数据
					$results = Article::findBySql("select articleid from articl=:id",array(':id'=>1))->one();
					$results->prop = value;
					$results->validate();
					$results->save();

				

				print_r($results);

				//url跳转,并返回状态码
				$this->redirect("http://www.baidu.com",status_code);

				//传递数据
				$data = array('name'=>"dongdong");

				//渲染文件
					继承模板文件
						return $this->render("index");
					不继承模板文件,并传递数据到视图
						return $this->renderPartial("index",$data);
			}
		}

	model模型

	ActiveRecord活动记录
		默认有三个数据模型

		namespace app\models;
		use yii\db\ActiveRecord;
		class Article extends ActiveRecord{

			//前置方法
			public function behaviors(){
				//获取控制起的url
				echo $this->id; // controller
				echo $this->action->id; // action

				//http缓存
				return [
					[
						'class'=>'yii\filter\HttpCache',
						'etagSeed'=>function(){//判断数据内容是否一样
							return md5(filecontent);
						},
						'lastModified'=>function(){//判断修改日期
							return stat(filename);
						}
					]
				];


				//页面缓存
				return [
					[
						'class'=>'yii\filter\PageCache',
						'duration'=>expiretime,
						'dependency'=>[
							'class'=>'yii\caching\FileDependency',
							'fileName'=>'filepath'
						]
					]
				];
			}

			//添加验证规则
			public function rules(){
				return [
					['name','required'],//单属性
					[['name','passwd'],'required']//多属性
				];
			}

			public function getComments(){
				return $this->hasMany(Comment::className(),['articleid'=>'id'])->asArray();
			}
		}
		?>


	views
		引用views/home/index.php文件
			绑定数据
			<?php
			use yii\helpers\Html;//过滤html 就够了
			use yii\helpers\HtmlPurifier;//过滤js 基本不用
			?>
			<div>
				this is hello world <?=Html::encode($name);?>
			</div>

			在view文件中引用其他的view文件
			<?php echo $this->render("about");?>

		数据过滤


		模板文件
			<!DOCTYPE html>
			<html>
			<head>
				<title></title>
			</head>
			<body>
				<?php if(isset($this->blocks['style'])){ ?>
					<?=$this->blocks['style']?>
				<?php } ?>
				<?=$content;?>
				<p>footer</p>
				<?=$this->blocks['script']?>
			</body>
			</html>
		普通文件
			<?php 
				use yii\helpers\Html;
			?>

			<?php $this->beginBlock('style');?>
				<p>this is style</p>
			<?php $this->endBlock('style');?>

			<?php $this->beginBlock('script');?>
				<p>this is script</p>
			<?php $this->endBlock('script');?>
	
	gii
		//入口index.php文件开启gii
			define('YII_ENV_DEV', true);
		web.php中添加
			'allowedIPs' => ['192.*.*.*'],


	request组件
		$request = \YII::$app->request;
		获取参数
			echo $request->get('id',default_value);
			echo $request->post('id',default_value);

		判断请求类型
			get请求
				if($request->isGet){

				}
			post请求
				if($request->isPost){

				}
		获取用户ip
			$request->userIp;

	response组件
		$response = \YII::$app->response;
		//返回给浏览器状态码302
			$response->statusCode = "302";
		//添加头信息
			$response->headers->add('pragma','no-cache');
		//修改头信息
			$response->headers->set('pragma','no-cache');
		//删除头信息
			$response->headers->set('remove');
		//跳转
			$response->headers->add('location','http://www.baidu.com');
		//文件下载,并指定文件名称
			当前访问文件下载
				$response->headers->add('content-disposition','attachment;filename="temp.name"');
			指定文件下载
				$response->sendFile("filepath");

	session组件
		$session = \YII::$app->session;
		判断是否开启session
			if($session->isActive){}
		打开sesion
			$session->open();
		编辑session
			sesion存储位置在php.ini文件中session.save_path有指定
			$session->set('key','value');
			$session['key']='value';//此种方式可以添加,但不可以修改
			$session->get('key');
			$session->remove('key');
			unset($session['key']);
			unset($_SESSION['key']);
		判断sesion是否存在
			if ($session->has('key')){}
		关闭sesion
			$session->close();
		销毁session
			$session->destroy();
		遍历
			foreach ($session as $name => $value){}
		flash数据
			$session->setFlash('postDeleted', 'You have successfully deleted your post.');
			$session->getFlash('postDeleted');
			$session->hasFlash('postDeleted');
	cookie组件
		$cookie = \YII::$app->response->cookies;
		编辑cookie
			//Cookie类需要引用文件
			use yii\web\Cookie;
			// 在要发送的响应中添加一个新的cookie
			$datas = array('name'=>'dfd','age'=>23);
			$cookies->add(new Cookie($datas));
			$cookies->getValue('key', 'default_value')
			$cookies->has('key')
			$cookies->remove('key');

	cache组件
		$cache = \YII::$app->cache;
		$cache->add('key','value');
		$cache->add('key','value',expires);
		$cache->set('key','value');
		$cache->delete('key');
		$cache->get('key');
		//清空缓存
		$cache->flush();

		缓存依赖 //博客详情页
			
			表达式依赖
				$dependency = new \yii\caching\ExpressionDependency(['expression'=>'\YII::$app->request->get("id")']);
			
			文件依赖
				$dependency = new \yii\caching\FileDependency(['fileName'=>'hw.txt']);

			db依赖
				$dependency = new \yii\caching\DbDependency(['sql'=>'select count(*) from article']);
				$cache->add('key','value',expires,$dependency);

		片段缓存//页面  可以做嵌套
			有效时间
				<?php if($this->beginCache('cachename',['duration'=>$expiretime])){ ?>
					<div class="content"></div>
				<?php };$this->endCache(); ?>
			依赖缓存
				<?php if($this->beginCache('cachename',['dependency'=>$dependency])){?>
					<div class="content"></div>
				<?php }$this->endCache(); ?>
			缓存开关
				<?php if($this->beginCache('cachename',['enabled'=>true])){?>
					<div class="content"></div>
				<?php }$this->endCache(); ?>
		页面缓存
			//前置方法
			public function behaviors(){
				//页面缓存
				return [
					['class'=>'yii\filter\PageCache']
				];
			}
		http缓存//看控制器

