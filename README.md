# GesturePassword
# 手势密码
# 实现思路以及算法分析
# （1）用三个for循环创建9个btn，并且添加到_amoutArrs中
# （2）在touchesBegan代理中判断触摸的是哪个btn，把触摸的btn添加到_selectArrs中，此btn设置高亮，并且将描线的起点设置为此btn.center
#  (3) 在touchesMoved代理中获取相对btn图层的触摸坐标，并判断触摸点到了哪个btn，添加入_selectArrs中（需作重复添加判断）。
# （4）在touchesMoved代理中实时调用自定义函数-(UIImage *)drawLine; 在_selection.count == 0时 返回nil
# （5）设置画布，起点为(2)中取的self.startPoint。便利_selectArr依次CGContextAddLineToPoint到各btn的center，然后再CGContextMoveToPoint 把新的起点设为此btn的center。
# （6）完成（5）的步骤后，CGContextAddLineToPoint 描线到触摸点的实时位置，但是不改变描线的起点。最后渲染到画布上。
