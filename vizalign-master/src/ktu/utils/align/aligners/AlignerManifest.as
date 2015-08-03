/* MIT License

Copyright (c) 2012 ktu <ktu@cataclysmicrewind.com>

Permission is hereby granted, free of charge, to any person obtaining a 
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation 
the rights to use, copy, modify, merge, publish, distribute, sublicense, 
and/or sell copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be 
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
THEAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
DEALINGS IN THE SOFTWARE.

*/
package ktu.utils.align.aligners {
	
	import ktu.utils.align.IRectangleAligner;

	/**
	 * AlignerManifest is a class that makes access to the standard built in aligners easy. 
	 * 
	 * there are public static getters for an instance of each aligner. you can use describe type to get a list of all of these
	 * or maybe i should add an array of all of the possibilities.
	 * 
	 * this will include all aligners in your projects. think about the added size of using this class. i only suggest
	 * using this if you have some sort of ui where the user is placing objects, and may want access to any these.
	 * 
	 * 
	 * @author ktu
	 */
	public class AlignerManifest {
		
		
		
		static public function get left ():IRectangleAligner { return new LeftAligner(); }
		static public function get horizontal ():IRectangleAligner { return new HorizontalAligner(); }
		static public function get right ():IRectangleAligner { return new RightAligner(); }
		
		static public function get top ():IRectangleAligner { return new TopAligner(); }
		static public function get vertical ():IRectangleAligner { return new VerticalAligner(); }
		static public function get bottom ():IRectangleAligner { return new BottomAligner(); }
		
		static public function get center ():IRectangleAligner { return new CenterAligner (); }
		
		static public function get topLeft ():IRectangleAligner { return new TopLeftAligner(); }
		static public function get topRight ():IRectangleAligner { return new TopRightAligner(); }
		static public function get bottomLeft ():IRectangleAligner { return new BottomLeftAligner(); }
		static public function get bottomRight ():IRectangleAligner { return new BottomRightAligner(); }
		
		
		
		static public function get adjacentLeft ():IRectangleAligner { return new AdjacentLeftAligner(); }
		static public function get adjacentHorizontalLeft ():IRectangleAligner { return new AdjacentHorizontalLeftAligner(); }
		static public function get adjacentHorizontalRight ():IRectangleAligner { return new AdjacentHorizontalRightAligner(); }
		static public function get adjacentRight ():IRectangleAligner { return new AdjacentRightAligner(); }
		
		static public function get adjacentTop ():IRectangleAligner { return new AdjacentTopAligner(); }
		static public function get adjacentVerticalTop ():IRectangleAligner { return new AdjacentVerticalTopAligner(); }
		static public function get adjacentVerticalBottom ():IRectangleAligner { return new AdjacentVerticalBottomAligner(); }
		static public function get adjacentBottom ():IRectangleAligner { return new AdjacentBottomAligner(); }
		
		static public function get adjacentTopLeft ():IRectangleAligner { return new AdjacentTopLeftAligner(); }
		static public function get adjacentTopRight ():IRectangleAligner { return new AdjacentTopRightAligner(); }
		static public function get adjacentBottomLeft ():IRectangleAligner { return new AdjacentBottomLeftAligner(); }
		static public function get adjacentBottomRight ():IRectangleAligner { return new AdjacentBottomRightAligner(); }
		
		
		
		static public function get distributeLeft ():IRectangleAligner { return new DistributeLeftAligner(); }
		static public function get distributeHorizontal ():IRectangleAligner { return new DistributeHorizontalAligner(); }
		static public function get distributeRight ():IRectangleAligner { return new DistributeRightAligner(); }
		
		static public function get distributeTop ():IRectangleAligner { return new DistributeTopAligner(); }
		static public function get distributeVertical ():IRectangleAligner { return new DistributeVerticalAligner(); }
		static public function get distributeBottom ():IRectangleAligner { return new DistributeBottomAligner(); }
		
		
		
		static public function get matchWidth ():IRectangleAligner { return new MatchWidthAligner(); }
		static public function get matchHeight ():IRectangleAligner { return new MatchHeightAligner(); }
		static public function get matchSize ():IRectangleAligner { return new MatchSizeAligner(); }
		
		static public function get scaleToFit ():IRectangleAligner { return new ScaleToFitAligner(); }
		static public function get scaleToFill ():IRectangleAligner { return new ScaleToFillAligner(); }
		
		
		
		static public function get spaceHorizontal ():IRectangleAligner { return new SpaceHorizontalAligner(); }
		static public function get spaceInsideHorizontal ():IRectangleAligner { return new SpaceInsideHorizontalAligner(); }
		static public function get spaceVertical ():IRectangleAligner { return new SpaceVerticalAligner(); }
		static public function get spaceInsideVertical ():IRectangleAligner { return new SpaceInsideVerticalAligner(); }
		
		
		
		static public function get stackHorizontal ():IRectangleAligner { return new StackHorizontalAligner(); }
		static public function get stackVertical ():IRectangleAligner { return new StackVerticalAligner(); }
	}
}