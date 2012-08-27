package life.com.life
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	public interface CatListener
	{
		
		function changedPos(xPlayer:Number, yPlayer:Number):Boolean;
		function hunted(Type:uint):void;
	
	}
}