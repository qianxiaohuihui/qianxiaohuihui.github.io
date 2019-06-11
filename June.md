# 六月的雨
+ MySQL存储过程，可以取字符串的hashcode,实际可以应用到将varchar字段转为bigint字段上。

```SQL
DELIMITER $$
 
CREATE
    PROCEDURE `test`.`HashValue`(IN str CHAR(32))
    BEGIN
     
    SET @pos = 1;
    SET @hashValue = 0;
    SET @szHex = HEX(str);
    SET @size = LENGTH(@szHex);
    WHILE @pos<@size+1 DO
        SET @cCh = SUBSTRING(@szHex,@pos,2);
        SET @nCh =CAST(ASCII(UNHEX(@cCh)) AS UNSIGNED);
        SET @hashValue = @hashValue + @nCh;
        SET @pos = @pos + 2;
    END WHILE;
 
    SELECT @hashValue;
    END$$
 
DELIMITER ;
```

+ layer.open 中右上角关闭按钮触发的回调用 `cancel `
   + 调.Net系统的页面，当数据发生变化时，希望可以点右上角的叉在关闭当前页面时刷新父级的列表页面数据。 

```javascript
 function openWinFullBzhjc(url, title, w, h) {
    var index = layer.open({
        type: 2,
        title: title,
        shade: 0.5,
        maxmin: false,
        area: ['300px', '150px'],
        content: url,
        cancel: function (index, layero) {
            closeLayerWindow();
            window.location.href="/sop?pindex=bzhjcList";
        }
    });
    layer.full(index);
}
```
+ C语言实现学生信息管理系统
   + `Sleep();` S需要大写，并引入 `#include <windows.h>`
   + `#include <unistd.h>`找不到头文件可以替换为这两个：`#include <io.h>` `#include <process.h>`
   + 不要定义用不到的变量，且变量要在函数前定义。
```C

#include <stdio.h>
#include <Windows.h>
#include <conio.h>
#include <stdlib.h>
//#include <unistd.h>
#include <io.h>
#include <process.h>
#include <windows.h>
#include <tchar.h>
#define   NR(x)   (sizeof(x)/sizeof(x[0]+0))
#define  TITLE  "学生信息管理系统"
#define  AUTHOR "作者:辉上天"
#define  DATE   "日期:2019年06月06日"
#define  SIZE   100
//在终端上打印信息
#define Print_Info_To_console(str,hOut,pos,x,y,color_type) \
	SetConsoleTextAttribute(hOut, color_type); 	\
	pos.X = x;									\
	pos.Y = y ;									\
	SetConsoleCursorPosition(hOut,pos);    		\
	printf("%s",str);							
 
//清屏
#define ClearScreen() \
	    system("cls");
 
	
//定义枚举Keyboard的键值数据 
enum 
{
	UP = 72,
	DOWN = 80 ,
	LEFT = 75 ,
	RIGHT = 77 ,
	ENTER = 13 ,
	ESC = 27 ,
};
 
//存储学生信息的结构体
struct student
{
	char name[20] ; //名字
	int  id ; 	    //学生ID
	float score ;   //分数
};
 
 
 
//定义要显示的菜单 
char *menu[] = 
{
	"＊学生信息添加＊",
	"＊学生信息查找＊",
	"＊学生信息打印＊",
	"＊学生信息修改＊",
	"＊学生信息删除＊",
	"＊学生信息保存＊",
	"＊学生信息导入＊",
	"＊    退出    ＊",
};
 
 
//窗口初始化
void HANDLE_init(HANDLE hOut);
//显示菜单 
void showmenu(HANDLE hOut ,char **menu , int size , int index) ;
//获取用户输入 
int  get_userinput(int *index , int size) ;
//学生信息添加
void stu_add(HANDLE hOut);
//学生信息打印
void stu_show(HANDLE hOut);
//学生信息查找
void stu_search(HANDLE hOut);
//学生信息保存
void stu_save(HANDLE hOut);
//学生信息导入
void stu_load(HANDLE hOut);
//学生信息修改
void stu_modefi(HANDLE hOut);
//学生信息删除
void stu_delete(HANDLE hOut);
 
 
//学生的个数
int stucount ; 
//定义一个数组，用于存储学生信息  
struct student array[SIZE] = {0}; 
//定义设置光标结构体变量
CONSOLE_CURSOR_INFO cci; 
//定义默认的坐标位置  	
COORD pos = {0,0};
 
 
int main()
{
    //int i;
    int ret ;
    int index = 0 ;
    HANDLE hOut;
	hOut = GetStdHandle(STD_OUTPUT_HANDLE);
	HANDLE_init(hOut);
    while(1)
    {
    	showmenu(hOut , menu , NR(menu) , index);
		ret = get_userinput(&index , NR(menu));
		if(ret == ESC)
			break ;
		if(ret == ENTER)
		{
			switch(index)
			{
				case 0:  stu_add(hOut) ; break ;  	//学生信息添加
				case 1:  stu_search(hOut);break ;   //学生信息查找
				case 2:  stu_show(hOut); break ;  	//学生信息打印
				case 3:  stu_modefi(hOut); break ;  //学生信息修改
				case 4:  stu_delete(hOut); break ;  //学生信息删除
				case 5:  stu_save(hOut); break ; 	//学生信息保存
				case 6:  stu_load(hOut); break ;    //学生信息导入
				case 7:  ClearScreen();return 0 ;   //退出学生信息管理系统
			}
		}
	}
	//关闭窗口句柄
	CloseHandle(hOut);
    return 0;
}
 
//窗口初始化
void HANDLE_init(HANDLE hOut)
{
	SetConsoleTitleA(TITLE);
	//获取当前的句柄---设置为标准输出句柄 
    //获取光标信息
    GetConsoleCursorInfo(hOut, &cci); 
	//设置光标大小   
    cci.dwSize = 1; 
	//设置光标不可见 FALSE   
    cci.bVisible =  0; 
    //设置(应用)光标信息
    SetConsoleCursorInfo(hOut, &cci); 
}
 
//菜单初始化
void showmenu(HANDLE hOut ,char **menu , int size , int index)
{
	int i ; 
	ClearScreen();	
	Print_Info_To_console(TITLE,hOut,pos,30,0,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console(AUTHOR,hOut,pos,32,1,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console(DATE,hOut,pos,25,2,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console("请按↑↓←→按键选择，并用Enter按键确认",hOut,pos,20,20,FOREGROUND_GREEN | 0x8);
	for(i = 0 ; i < size ; i++)
	{
		//如果i==index表示在当前选项的位置，默认初始化显示是第一项，显示为红色，
		//当按下上下按键选择的时候，光标会移动，也就看到了列表选择的现象 
		if(i == index){
			Print_Info_To_console(menu[i],hOut,pos,30,i+5,FOREGROUND_RED | 0x8);
		}
		else{
			Print_Info_To_console(menu[i],hOut,pos,30,i+5,FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | 

0x8);			
		}
	}
	//刷新标准输出缓冲区 
	fflush(stdout);
}
 
//获取用户输入的接口 
int  get_userinput(int *index , int size)
{
	int ch ;
	fflush(stdin);
	ch = getch();
	switch(ch)
	{
		//上 
		//如果选择上，那么光标向上移动 
		case UP : if(*index > 0)  *index -= 1 ;  break; 
		//下 
		//如果选择下，那么光标向下移动 
		case DOWN :if(*index < size -1)  *index += 1 ;  break;
		//左 
		case LEFT: 
		case 97:return 0 ;
		//右 
		case RIGHT:return 0 ;
		//回车 
		case ENTER: return ENTER ;
		//ESC
		case ESC: return ESC ;
	}
	return 0 ;
}
 
//学生信息添加
void stu_add(HANDLE hOut)
{
	ClearScreen();	
	if(stucount >= SIZE){
		Print_Info_To_console("学生信息已经满了\n",hOut,pos,30,0,FOREGROUND_RED | 0x8);
	}
	Print_Info_To_console("学生信息添加\n",hOut,pos,30,0,FOREGROUND_GREEN | 0x8);
	printf("学生姓名:");
	scanf("%s" , array[stucount].name);
	printf("\n学生ID:");
	scanf("%d" , &(array[stucount].id));
	printf("\n学生成绩:");
	scanf("%f" , &(array[stucount].score));
	stucount++ ; 
	 //清掉输入缓冲区中的\n
	getchar();  
	fflush(NULL);
}
 
//学生信息打印
void stu_show(HANDLE hOut)
{
	int i ; 
	ClearScreen();	
	fflush(stdin);
	fflush(stdout);
	Print_Info_To_console("学生信息打印\n",hOut,pos,30,0,FOREGROUND_GREEN | 0x8);
	for(i = 0 ; i < stucount ; i++)
	{
		SetConsoleTextAttribute(hOut, FOREGROUND_RED| 0x8); 
		pos.X = 1;
		pos.Y = i+4 ;
		SetConsoleCursorPosition(hOut,pos); 
		printf("ID：%2d ",array[i].id);
		printf("姓名:%s ",array[i].name);
		printf("分数:%4.1f ",array[i].score);
	}
	fflush(stdout);
	Print_Info_To_console("Please press any key to continue ... \n",hOut,pos,0,20,FOREGROUND_GREEN | 0x8);
	getchar(); 
}
//查找ID
static void search_id(HANDLE hOut,int id)
{
	ClearScreen();	
	Print_Info_To_console("查找到学生的信息\n",hOut,pos,30,0,FOREGROUND_GREEN | 0x8);
	fflush(stdout);
	int i ,j ,flag = 0; 
	for(i = 0 , j = 0 ; i < stucount ; i++)
	{
		if(array[i].id == id)
		{
			flag = 1 ;
			SetConsoleTextAttribute(hOut, FOREGROUND_RED| 0x8); 
			pos.X = 1;
			pos.Y = j+4 ;
			SetConsoleCursorPosition(hOut,pos); 
			printf("ID：%2d ",array[i].id);
			printf("姓名:%s ",array[i].name);
			printf("分数:%f ",array[i].score);
			j++ ; 
		}
	}
	if(flag == 0)
	{
		Print_Info_To_console("找不到该学生的ID，请按任意按键返回主菜单!\n",hOut,pos,0,20,FOREGROUND_RED | 0x8);
		getchar();
	}
	if(flag == 1)
	{
		fflush(stdout);
		Print_Info_To_console("Please press any key to continue ... \n",hOut,pos,0,20,FOREGROUND_GREEN | 0x8);
		getchar(); 
	}
}
//查找姓名
static void search_name(HANDLE hOut,const char *name)
{
	ClearScreen();	
	Print_Info_To_console("查找到学生的信息\n",hOut,pos,30,0,FOREGROUND_GREEN | 0x8);
	fflush(stdout);
	int i , j , flag = 0; 
	for(i = 0 , j = 0; i < stucount ; i++)
	{
		if(strcmp(array[i].name , name) == 0)
		{
			flag = 1 ;
			SetConsoleTextAttribute(hOut, FOREGROUND_RED| 0x8); 
			pos.X = 1;
			pos.Y = j+4 ;
			SetConsoleCursorPosition(hOut,pos); 
			printf("ID：%2d ",array[i].id);
			printf("姓名:%s ",array[i].name);
			printf("分数:%f ",array[i].score);
			j++ ; 
		}
	}
	if(flag == 0)
	{
		Print_Info_To_console("找不到该学生的姓名，请按任意按键返回主菜单!\n",hOut,pos,0,20,FOREGROUND_RED | 0x8);
		getchar();
	}
	if(flag == 1)
	{
		fflush(stdout);
		Print_Info_To_console("Please press any key to continue ... \n",hOut,pos,0,20,FOREGROUND_GREEN | 0x8);
		getchar();
	}
}
 
//学生信息查找
void stu_search(HANDLE hOut)
{
	char ch ; 
	int id ; 
	char name[30] ; 
repeat:
	ClearScreen();	
	Print_Info_To_console("学生信息查找\n",hOut,pos,30,0,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console("请选择按什么方式查找学生信息 :\n",hOut,pos,20,0,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console("			1.ID \n",hOut,pos,10,1,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console("			2.NAME \n",hOut,pos,10,2,FOREGROUND_GREEN | 0x8);
	fflush(stdout);
	//获取要输入的信息
	ch = getch();  
	if(ch == '1')
	{
		ClearScreen();	
		Print_Info_To_console("请输入学生ID: ",hOut,pos,0,1,FOREGROUND_GREEN | 0x8);
		fflush(stdout);
		scanf("%d" , &id);
		getchar();
		if(id < 0)
		{
			getchar();
			Print_Info_To_console("请入ID有误,请按任意键重新选择输入\n",hOut,pos,0,20,FOREGROUND_RED | 0x8);
			getchar();  
			goto repeat;
		}
		search_id(hOut,id);
	}
	if(ch == '2')
	{
		printf("请输入学生NAME: ");
		fflush(stdout);
		scanf("%s" , name);
		getchar();
		search_name(hOut,name);
	}
	if(ch != '1' && ch != '2')
	{
		goto repeat;
	}
}
 
//学生信息保存
void stu_save(HANDLE hOut)
{
	FILE *filp = NULL ; 
	char ch ; 
	char Path[30] ; 
repeat1:
	ClearScreen();	
	Print_Info_To_console("学生信息保存\n",hOut,pos,30,0,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console("请选择按什么方式保存学生信息 :\n",hOut,pos,20,0,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console("			1.追加 \n",hOut,pos,10,1,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console("			2.覆盖 \n",hOut,pos,10,2,FOREGROUND_GREEN | 0x8);
	fflush(stdout);
	ch = getch();  
	ClearScreen();	
	Print_Info_To_console("请输入保存文件名:\n",hOut,pos,0,1,FOREGROUND_GREEN | 0x8);
	scanf("%s" , Path);
	getchar();
	if(ch == '1')
	{
		filp = fopen(Path , "a+");
		if(NULL == filp)
		{
			Print_Info_To_console("文件打开失败 \n",hOut,pos,0,20,FOREGROUND_RED | 0x8);
			Print_Info_To_console("请按任意键重新选择输入 \n",hOut,pos,0,21,FOREGROUND_RED | 0x8);
			getchar(); 
			goto  repeat1;
		}
	}
	if(ch == '2')
	{
		filp = fopen(Path , "w+");
		if(NULL == filp)
		{
			Print_Info_To_console("文件打开失败 \n",hOut,pos,0,20,FOREGROUND_RED | 0x8);
			SetConsoleTextAttribute(hOut, FOREGROUND_RED | 0x8); 
			Print_Info_To_console("请按任意键重新选择输入 \n",hOut,pos,0,21,FOREGROUND_RED | 0x8);
			getchar(); 
			goto  repeat1;
		}
	}
	if(ch != '1' && ch != '2')
	{
		goto repeat1;
	}
 
	int i ; 
	for(i = 0 ; i < stucount ; i++)
	{
		fwrite(&(array[i]) , sizeof(struct student) , 1 , filp);
	}
	fclose(filp);
	Print_Info_To_console("学生信息保存完毕\n",hOut,pos,0,20,FOREGROUND_GREEN | 0x8);
	Sleep(1000) ; 
}
//学生信息装载
void stu_load(HANDLE hOut)
{
	//int i ; 
	FILE *filp = NULL ; 
	char Path[30] ; 
	ClearScreen();	
	Print_Info_To_console("学生信息加载\n",hOut,pos,30,0,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console("请输入导入文件名 :\n",hOut,pos,0,1,FOREGROUND_GREEN | 0x8);
	scanf("%s" , Path);
	filp = fopen(Path , "r");
	if(NULL == filp)
	{
		Print_Info_To_console("文件打开失败 \n",hOut,pos,0,20,FOREGROUND_RED | 0x8);
		SetConsoleTextAttribute(hOut, FOREGROUND_RED | 0x8); 
		Print_Info_To_console("请按任意键退出 \n",hOut,pos,0,21,FOREGROUND_RED | 0x8);
		fflush(stdin);
		fflush(stdout); 
		getchar();
		return ;
	}
	//char buffer[1024] ; 
	char *p = NULL ; 
	int ret ; 
	while(1)
	{
		ret = fread(&(array[stucount]) , sizeof(struct student) , 1 , filp);
		if(ret != 1)
			break;
		stucount++ ; 
	}
	fclose(filp);
	ClearScreen();	
	Print_Info_To_console("学生信息导入完毕\n",hOut,pos,0,20,FOREGROUND_GREEN | 0x8);
	Sleep(1000);
}
//学生信息修改
void stu_modefi(HANDLE hOut)
{
	int id ; 
	int flag = 0 ;
	int location ;
	char ch ;
	replay:
	ClearScreen();	
	Print_Info_To_console(" 学生信息修改\n",hOut,pos,30,0,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console("请输入学生ID: ",hOut,pos,0,1,FOREGROUND_GREEN | 0x8);
	fflush(stdout);
	scanf("%d" , &id);
	int i ; 
	for(i = 0 ; i < stucount ; i++)
	{
		//如果ID匹配，也就是查找到这个学生的信息了
		if(array[i].id == id)
		{
			flag = 1 ;
			//保存当前数组的位置
			location = i ;
			break ;
		}
	}
	//判断是否匹配成功的标志
	if(flag == 1){
		flag = 0 ;
		//打印该学生的信息
		ClearScreen();	
		Print_Info_To_console("找到该学生的信息如下:\n",hOut,pos,15,0,FOREGROUND_GREEN | 0x8);
		SetConsoleTextAttribute(hOut, FOREGROUND_GREEN| 0x8); 
		pos.X = 0;
		pos.Y = 1 ;
		SetConsoleCursorPosition(hOut,pos); 
		printf("ID：%2d ",array[i].id);
		SetConsoleTextAttribute(hOut, FOREGROUND_GREEN| 0x8); 
		pos.X = 0;
		pos.Y = 2 ;
		SetConsoleCursorPosition(hOut,pos); 
		printf("姓名:%s ",array[i].name);
		SetConsoleTextAttribute(hOut, FOREGROUND_GREEN| 0x8); 
		pos.X = 0;
		pos.Y = 3 ;
		SetConsoleCursorPosition(hOut,pos); 
		printf("分数:%f ",array[i].score);
	}
	else
	{
		Print_Info_To_console("请入ID有误,请按任意键重新选择输入\n",hOut,pos,0,1,FOREGROUND_RED | 0x8);
		fflush(stdin);
		getchar();
		goto replay ;
	}
	//询问是否需要修改
	Print_Info_To_console("请问是否需要修改该学生的信息？按1确定，按2退回到主菜单\n",hOut,pos,0,4,FOREGROUND_GREEN | 

0x8);
	//刷新输出缓冲区
	fflush(stdout);
	//刷新输入缓冲区
	fflush(stdin);
	ch = getch();
	ClearScreen();	
	if(ch == '1')
	{
		//是否需要修改学生的ID？
		Print_Info_To_console("是否需要修改学生的ID？按1确定，按2不需要\n",hOut,pos,0,1,FOREGROUND_GREEN | 0x8);
		fflush(stdout);
		fflush(stdin);
		ch = getch();
		if(ch == '1')
		{
			ClearScreen();	
			Print_Info_To_console("修改学生ID为:",hOut,pos,0,1,FOREGROUND_GREEN | 0x8);
			scanf("%d" , &(array[location].id));
			Print_Info_To_console("修改学生ID成功，请按任意键返回主菜单\n",hOut,pos,0,2,FOREGROUND_GREEN | 0x8);
			Sleep(1500);
			fflush(stdin);
			getchar();
			return ;
		}
		if(ch == '2')
		{
			//是否需要修改学生的姓名
			ClearScreen();	
			Print_Info_To_console("是否需要修改学生的姓名？按1确定，按2不需要\n",hOut,pos,0,1,FOREGROUND_GREEN | 

0x8);
			fflush(stdout);
			fflush(stdin);
			ch = getch();
			if(ch == '1')
			{
				ClearScreen();	
				Print_Info_To_console("修改学生姓名为:",hOut,pos,0,1,FOREGROUND_GREEN | 0x8);
				scanf("%s" , array[location].name);
				Print_Info_To_console("修改学生姓名成功，请按任意键返回主菜单

\n",hOut,pos,0,2,FOREGROUND_GREEN | 0x8);
				Sleep(1000);
				fflush(stdin);
				getchar();
				return ;
			}
			if(ch == '2')
			{
				//是否需要修改学生的成绩
				ClearScreen();	
				Print_Info_To_console("是否需要修改学生的成绩？按1确定，按2不需要

\n",hOut,pos,0,1,FOREGROUND_GREEN | 0x8);
				fflush(stdout);
				fflush(stdin);
				ch = getch();
				if(ch == '1')
				{
					ClearScreen();	
					Print_Info_To_console("修改学生成绩为:",hOut,pos,0,1,FOREGROUND_GREEN | 0x8);
					scanf("%f" , &(array[location].score));
					Print_Info_To_console("修改学生成绩成功，请按任意键返回主菜单

\n",hOut,pos,0,2,FOREGROUND_GREEN | 0x8);
					Sleep(1000);
					fflush(stdin);
					getchar();
					return ;
				}
				if(ch == '2')
				{
					return ;
				}
			}
		}
	}
	if(ch == '2')
	{
		Print_Info_To_console("请按任意键返回主菜单\n",hOut,pos,0,2,FOREGROUND_GREEN | 0x8);
		fflush(stdin);
		getchar();
		return ;
	}
}
//学生信息删除
void stu_delete(HANDLE hOut)
{
	char ch ; 
	int id ; 
	char name[30] ; 
repeat3:
	ClearScreen();	
	Print_Info_To_console(" 学生信息删除\n",hOut,pos,30,0,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console(" 请选择按什么方式删除学生信息 :\n",hOut,pos,20,0,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console("			1.ID",hOut,pos,10,1,FOREGROUND_GREEN | 0x8);
	Print_Info_To_console("			2.NAME\n",hOut,pos,10,2,FOREGROUND_GREEN | 0x8);
	fflush(stdout);
	ch = getch(); 
	ClearScreen();	
	int i , j ; 
	if(ch == '1')
	{
		Print_Info_To_console("请输入ID:\n",hOut,pos,0,1,FOREGROUND_GREEN | 0x8);
		scanf("%d" , &id);
		getchar();
		for(i = 0 ; i < stucount ; i++)
		{
			if(array[i].id == id)
			{
				SetConsoleTextAttribute(hOut, FOREGROUND_RED| 0x8); 
				printf("删除 : ID:%d  NAME:%s  score:%f\n" , array[i].id , array[i].name , array[i].score);
				for(j = i ; j < stucount -1 ; j++)
					array[j] = array[j+1] ;
				stucount-- ;
				break ;
			}
		}
	}
	if(ch == '2')
	{
		Print_Info_To_console("请输入NAME:\n",hOut,pos,0,1,FOREGROUND_GREEN | 0x8);
		scanf("%s" , name);
		getchar();
		for(i = 0 ; i < stucount ; i++)
		{
			if(strcmp(array[i].name , name) == 0)
			{
				SetConsoleTextAttribute(hOut, FOREGROUND_RED| 0x8); 
				printf("删除 : ID:%d  NAME:%s  score:%f\n" , array[i].id , array[i].name , array[i].score);
				for(j = i ; j < stucount -1 ; j++)
					array[j] = array[j+1] ;
				stucount-- ;
				break ;
			}
		}
	}
	if(ch != '1' && ch != '2')
	{
		goto repeat3;
	}
	Sleep(1000);
}
```
