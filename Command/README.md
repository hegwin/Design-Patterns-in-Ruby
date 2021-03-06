# 命令模式

通过使用命令模式，我们构建知道如何执行特定任务的对象。这里的”特定“是关键词。

当你的程序需要执行一连串任务的时候，或者需要记住已经做过什么的时候，命令模式特别有用。你可以逆向运行命令来撤销程序已经做过的事情。根据程序的复杂情况，你可以选择使用完整的命令模式或者简单的代码块。

命令模式和观察器模式有一些共同之处。这两个模式都定义了一个被模式中的其他参与者所调用的对象，即命令对象和观察器模式中的观察器对象。那么，我是应该给一个GUI按钮传入一个命令对象，用来处理click事件呢？还是应当在按钮上注册一个观察器监听click事件呢？答案应该视具体情况而定。一个命令对象确切地知道如何做一些事情，但是对执行它的那个对象的状态丝毫不感兴趣。相反，一个观察器却对调用它的那个对象的主题状态特别感兴趣。这两种设计模式的根本区别就在这里。
