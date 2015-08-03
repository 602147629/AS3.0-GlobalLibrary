package zUtils.draw
{
    import flash.display.CapsStyle;
    import flash.display.Graphics;
    import flash.display.JointStyle;
    import flash.display.LineScaleMode;

    import zUtils.draw.ZDraw;

    /**
     * Date: 07.05.12
     * Time: 22:57
     * @author zaidite
     * @description
     */

    public class LineStile
    {
        /**
         * Целое число, определяющее толщину линии в точках; допустимыми являются значения от 0 до 255.
         * Если число не указано или параметр не определен, то линия не будет проведена.
         * Если передается значение меньше 0, по умолчанию задается 0.
         * Значение 0 обозначает толщину одного волоса, максимальная толщина составляет 255.
         * Если передается значение больше 255, по умолчанию задается 255.
         * */
        public const THICKNESS : Number = 0;

        /**
         * Шестнадцатеричное значение цвета линии; например красный — 0xFF0000, синий — 0x0000FF и т.д.
         * Если значение на задано, по умолчанию используется 0x000000 (черный). Необязательно.
         */
        public const COLOR : uint = 0x000000;


        /**
         * Число, указывающее значение альфа-канала цвета линии, допустимые значения находятся в диапазоне 0-1.
         * Если значение на задано, по умолчанию используется 1(сплошной).
         * Если значение меньше 0, по умолчанию задается 0.
         * Если значение больше 1, по умолчанию задается 1.
         */
        public const ALPHA : Number = 1;

        /**
         *  Логическое значение, определяющее, следует ли выполнять хинтинг штрихов до полных пикселов.
         * Оно влияет на позицию привязок кривой и на размер штриха линии как таковой.
         * Если для pixelHinting задано значение true, проигрыватель Flash Player выполняет хинтинг ширины линии до полного пиксела.
         * Если для pixelHinting задано значение false, в кривых и прямых линиях могут возникать разрывы.
         *
         */
        public const PIXEL_HINTING : Boolean = false;


        /**
         * Значение класса LineScaleMode, задающее режим масштабирования:
         LineScaleMode.NORMAL — Всегда масштабировать толщину линии при масштабировании объекта (по умолчанию).
         LineScaleMode.NONE — Никогда не масштабировать толщину линии.
         LineScaleMode.VERTICAL — Не масштабировать толщину линии, если объект масштабируется только по вертикали.
         */
        public const SCALE_MODE : String = LineScaleMode.NORMAL;


        /**
         * Значение класса CapsStyle, задающее тип концов линии.
         * Допустимые значения: CapsStyle.NONE, CapsStyle.ROUND и CapsStyle.SQUARE.
         * Если значение не указано, Flash Player использует круглые концы.
         */
        public const CAPS : String = CapsStyle.NONE;

        /**
         * Значение класса JointStyle, задающее тип стыка на углах.
         * Допустимые значения: JointStyle.BEVEL, JointStyle.MITER и JointStyle.ROUND.
         * Если значение не указано, Flash Player использует круглые стыки.
         */
        public const JOINTS : String = JointStyle.ROUND;

        /**
         * Число, указывающее предел усечения уголка. Допустимыми являются значения в диапазоне 1-255 (остальные значения округляются до 1 или 255).
         * Это значение используется, только если для jointStyle выбран тип "miter".
         * Значение miterLimit — это длина, до которой может продлеваться уголок после точки стыка. Значение выражает фактор толщины линии.
         * Например, при факторе miterLimit, равном 2,5, и толщине в 10 пикселов, длина уголка достигает 25 пикселов.
         */
        public const MITERLIMIT : Number = 3;

        //*********************** CONSTRUCTOR ***********************
        public function LineStile()
        {

        }

        //***********************************************************

        /**
         * Параметры линии по умолчанию.
         * @param thickness - ширина
         * @param color - цвет
         * @param alpha - прозрачность
         * @param pixelHinting - следует ли выполнять хинтинг штрихов до полных пикселов
         * @param scaleMode - режим масштабирования : LineScaleMode.NORMAL / LineScaleMode.NONE / LineScaleMode.VERTICAL
         * @param caps -  тип концов линии : CapsStyle.NONE / CapsStyle.ROUND / CapsStyle.SQUARE
         * @param joints - тип стыка на углах: JointStyle.BEVEL / JointStyle.MITER / JointStyle.ROUND
         * @param miterLimit - Число, указывающее предел усечения уголка. (0 - 255)
         * @return
         */
        public function lineStileDefault(
                thickness:Number=0,
                color:uint = 0x848482,
                alpha:Number = 0,
                pixelHinting:Boolean = false,
                scaleMode:String = LineScaleMode.NORMAL,
                caps:String = CapsStyle.NONE,
                joints:String = JointStyle.ROUND,
                miterLimit:Number = 3
                ) : Object
        {
            return {thickness:thickness, alpha:alpha, color:color, pixelHinting:pixelHinting, scaleMode:scaleMode, caps:caps, joints:joints, miterLimit:miterLimit};
        }


        /**
         * Задаёт стиль линии для объекта Graphics фигуры Shape
         * @param graphics - объект класса Graphics
         * @param lineStile - объект с настройками стиля линии
         *
         */
        public function makeDefaultLine(graphics:Graphics, lineStile:Object=null) : void
        {
            if(!graphics)return;
            if(!lineStile)lineStile = lineStileDefault();

            if(lineStile)
            {
                graphics.lineStyle(lineStile['thickness'], lineStile['color'], lineStile['alpha'], lineStile['pixelHinting'],
                        lineStile['scaleMode'], lineStile['caps'], lineStile['joints'], lineStile['miterLimit']);
            }
        }


    } //end class
} // end package
