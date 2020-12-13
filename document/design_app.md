## Flutter 设计逻辑

1. 每个应用都有独立的一个main方法作为主入口
2. Flutter每个页面是通过不同的Widget组合/嵌套构建的
3. Widget分为StatelessWidget和StatefulWidget，区别在于前者不需要**维护状态**
4. Flutter提供了一组功能丰富的自带组件
5. 页面之间的路由管理使用Navigator来进栈，退栈
6. 页面涉及到异步加载的情况下，使用FutureBuilder来异步构建
