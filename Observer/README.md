# 观察器模式

观察器模式使你可以创建一个对象，用于了解其他对象的活动，而无需将他们紧密耦合。通过在消息的来源（被观察的对象）和消息的消费者（观察器）之间设定清晰的接口，使得观察器可以在不绑定两者的情况下传输消息。

实现观察器模式的主要工作在于消息主题或者被观察的类中。在Ruby中，我们可以使用超类或者模块来实现。观察器和被观察对象之间的接口可以根据你的需求设计的非常复杂，不过如果只是创建简单的观察器，那么代码块也是个不错的选择。