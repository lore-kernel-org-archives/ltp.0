From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 9 Oct 2019 09:48:53 +0200
Subject: [LTP] [PATCH 1/2] tst_test.sh: Add TST_USES_MODULE
In-Reply-To: <20191009073609.GB27854@dell5510>
References: <20191009061619.48677-1-lkml@jv-coder.de>
 <20191009061619.48677-2-lkml@jv-coder.de> <20191009073609.GB27854@dell5510>
Message-ID: <c34e4432-ffe1-47a9-e93e-bce6b256072e@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
>> Adds a new library variable TST_USES_MODULE, that can be used, when a
>> test may need a module, but should not fail, if the module is not available.
> I wonder if TST_USES_MODULE is descriptive enough. But it looks to me better
> than TST_GET_MODPATH (which Cyril suggested in v3).
>
> We should think twice as _USES_ keyword should be used consistently for the same
> approach in different functionality (i.e. TST_USES_FOO is the same as
> TST_NEEDS_FOO, but not TCONF/TBROK if it fails).
>
> But whole concept of TST_USES_FOO looks to me a bit complicated, if needed only
> for modules. Cannot we just call _tst_find_module directly in this case and not
> introduce variable?
I was thinking about adding a function to search for a module, but 
struggled with
returning the name of the found found module.
I had something like
MODPATH=$(tst_find_module "$MODULE_NAME")
but this cannot use tst_res or tst_brk, which I don't like. I also don't 
like just calling
_tst_find_module and getting the result in some "magic" variable. That 
is the reason
why I went with Cyril's Idea of a variable
> ...
>> +_tst_find_module()
>> +{
>> +	local _tst_module=$1
>> +	local _tst_is_required=${2:-0}
>> +
>> +	for tst_module in "$_tst_module" \
>> +						"$LTPROOT/testcases/bin/$_tst_module" \
>> +						"$TST_STARTWD/$_tst_module"; do
> nit: (can be fixed by person who merges it): It's not visible, but uses more
> tags than it should be, so it looks like:
> +       for tst_module in "$_tst_module" \
> +                                               "$LTPROOT/testcases/bin/$_tst_module" \
> +                                               "$TST_STARTWD/$_tst_module"; do
> +
> +                       if [ -f "$tst_module" ]; then
> +                               TST_MODPATH="$tst_module"
> +                               break
> +                       fi
> I actually like the original alignment created by Alexey:
>          for tst_module in "$TST_NEEDS_MODULE" \
>                            "$LTPROOT/testcases/bin/$TST_NEEDS_MODULE" \
>                            "$TST_STARTWD/$TST_NEEDS_MODULE"; do
Just an accident by my editor, I'll fix it for v2
>
>> +
>> +			if [ -f "$tst_module" ]; then
>> +				TST_MODPATH="$tst_module"
>> +				break
>> +			fi
>> +	done
>> +
>> +	if [ -z "$TST_MODPATH" ]; then
>> +		if [ $_tst_is_required -eq 1 ]; then
>> +			tst_brk TCONF "Failed to find module '$_tst_module'"
>> +		else
>> +			tst_res TINFO "Module '$_tst_module' not found."
> nit: please drop dot at the end (can be fixed by person who merges it).
Fixed for v2
>> +		fi
>> +	else
>> +		tst_res TINFO "Found module at '$TST_MODPATH'"
>> +	fi
>
> nit: this is IMHO more readable
> 	if [ -n "$TST_MODPATH" ]; then
> 		tst_res TINFO "Found module at '$TST_MODPATH'"
> 		return
> 	fi
>
> 	if [ $_tst_is_required -eq 1 ]; then
> 		tst_brk TCONF "Failed to find module '$_tst_module'"
> 	else
> 		tst_res TINFO "Module '$_tst_module' not found"
> 	fi
It would still keep the else and not use a return. Indentation clearly 
shows what's going on.
But I agree to invert the logic, first testing the good case, than the bad.
>
> Kind regards,
> Petr

J?rg
