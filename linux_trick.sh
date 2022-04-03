# linux tricks

#清屏
ctrl + l  
reset # reset ur shell

#以super user执行上一行执行的命令
sudo !!
# 返回上次的目录
cd -
# 目录推入栈
pushd /etc  
# 进入目录推出栈
popd

# 使用vim中不关闭vim但回到shell
ctrl + z
# 回到vim
fg # foreground

# 补充
htop # 监控工具

# 搜索执行的命令
ctrl + r   enter to execute
#展示所有命令历史
histroy
#执行某条历史命令
!102 #!102
#展示命令行执行的时间
HISTTIMEFORMAT="%Y-%m-%d %T " # 可以将命令添加到 ~.bashsrc文件全局起作用
histroy

cmatrix # 用来显示颜色的矩阵 单纯为了好看 f11 全屏

#调整终端字体大小
ctrl + +

#删除当前正在输入的命令行
ctrl + u

#回到行首 行尾
ctrl + a , ctrl + e

#优雅展示输出 例如
mount # 显示磁盘分区 但是显示的内容是杂乱无章的  尽管你调整了字体大小
mout | column -t # 将结果格式化为表格







