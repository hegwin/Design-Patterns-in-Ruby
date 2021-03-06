# 生成器模式

生成器模式的意义在于当你的对象很难创建时，即如果你不得不编写很多代码来设置每个对象的话，那么你需要使用一个独立的类来重构这些创建代码，这个类就是生成器。

生成器模式建议你提供一个对象（即 Builder ），用于接受新对象的多部分设定并处理创建对象的所有复杂步骤。正因为这些对象控制了你的对象的配置，所以他们被称为生成器。生成器还可以避免你创建出不合法的对象，生成器可能会说：“不，我觉得没有必要给一辆车安装第五个轮子……”

当你创建一个生成器。你需要注意它的重用能力。问你自己是否能够使用一个生成器实例来创建多个产品实例。相对于创建复杂的可重用生成器来说，编写一个简单的生成器并通过充值方法来重用它要相对简单得多。关键问题在于：你要创建和使用哪种生成器？

使用`method_missing`可以让客户代码在一个方法调用中指定一组配置选项，从而大大简化对象的构造。
