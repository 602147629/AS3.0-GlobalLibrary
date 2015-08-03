package zUtils.caching
{
    import com.demonsters.debugger.MonsterDebugger;

    /**
	 * Trace any params in trace and MonsterDebugger
	 * className:String='Class' - name of Class wich contains request trace
	 * methodName:String='function' - name of function wich contains request trace
	 *
	 */
	public function tracePath(className:String='Class', methodName:String='function', ...params) : void
	{

		var path:String  = className + ' / ' + methodName;
		var noParams:String = 'No params';
		var badParams:String = 'Bad params';

		if(params.length==0)
		{
			MonsterDebugger.trace(path, noParams);
			tracing(noParams, path);
		}
		else
		{

			if(params.length == 1 )
			{
//				if(params[0])MonsterDebugger.trace(path, params[0]);
//				else MonsterDebugger.trace(path, badParams);

				if(params[0])tracing(params[0], path);
				else tracing(badParams, path);
			}

			if(params.length > 1 )
			{
//				MonsterDebugger.trace(path, params);
				tracing(params, path);
			}

		}




		function tracing(obj:*, path : String, shift : String = '->', rec:Boolean=false) : void
		{
			if(!obj)obj = noParams;

			if(!rec)trace('\n', '--- PARSING START :: ', path, ' : ', obj, '--->', '\n' );

			for (var prop : String in obj)
			{

				if(obj[prop] || obj[prop] == 0 || obj[prop] == null || obj[prop] == undefined)
				{
					if(obj[prop] is Array)
					{
						trace(shift,  prop , ' = Array');
					}
					else
					{
						if(obj[prop] as String)trace(shift,  prop , ' = ', "'" +  obj[prop] + "'");
						else trace(shift,  prop , ' = ', obj[prop]);
					}

					if(obj[prop] as Array || obj[prop] as Object )tracing(obj[prop], path, '   ' + shift, true);
				}
			}

			if(!rec)trace('\n', '--- PARSING END.',  '\n' );
		}


	}

}