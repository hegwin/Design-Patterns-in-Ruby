# 约定优于配置

约定优于配置模式建议定义一个普通工程师可能会应用的惯例（Convention），然后就一直遵守这个约定（例如，将所有的适配器放到这个目录，或者以这种方式来命名所有的用户认证方法）。设计一个好的约定/惯例就像试着一个好的用户界面一样，需要你换位到用户的角度去思考。努力设想你的用户会如何行动，他们会怎样给文件或者方法命名，他们通常会将文件放在什么地方等。然后基于这些设想来设计你的约定，并尽可能扩大约定的覆盖面。通过将类命名为这样或者那样，以及将文件保存在什么位置，工程师用户都在告诉你他们的需求。倾听这些需求，不要再他们重复。

另一个你可以做的事情是，为你的用户提供一个用于开始的模型、模板或者可参照的示例。

约定优于配置模式和DSL及元编程一样，采用了Ruby语言的灵活性功能。约定优于配置和DSL一样，在很大程度上依赖于运行时的代码计算。它同元编程一样，要求相当高层名的程序自省。这三个设计模式还有另一个共同点：都是解决编程问题的方法。他们共同的宗旨是，你不应该局限于所看到的编程语言，而是应当将它塑造成更直接地帮助你解决问题的工具。
