From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 15:42:33 +0200
Subject: [LTP] [RFC PATCH 1/2] lib/tst_test.sh: TST_TESTFUNC_DATA and
 TST_TESTFUNC_DATA_IFS
In-Reply-To: <20180516125008.GA544@rei>
References: <20180516123924.11047-1-pvorel@suse.cz>
 <20180516123924.11047-2-pvorel@suse.cz> <20180516125008.GA544@rei>
Message-ID: <20180516134233.x6cp2jjhc6v75zdh@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Thanks for your comments, they make sense, I'll send v2.

+ more comments bellow:

> I do not like redefing IFS, it's really ugly.

> What about something as:

> DATA="foo:bar:d dd"
> DELIM=":"
> i=1
> while true; do
>         param="$(echo "$DATA" | cut -d$DELIM -f$i)"
>         [ -z "$param" ] && break;
>         echo "$param"
>         i=$((i+1))
> done
Playing with IFS is ugly, but it doesn't require any external dependency.
But cut is common, let's make it.

> >  		else
> >  			local res=$(tst_resstr)
> >  			$TST_TESTFUNC
> > @@ -400,6 +412,10 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
> >  		tst_brk TBROK "TST_TESTFUNC is not defined"
> >  	fi

> > +	if [ -n "$TST_CNT" -a -n "$TST_TESTFUNC_DATA" ]; then
> > +		tst_brk TBROK "TST_CNT cannot be mixed with TST_TESTFUNC_DATA"
> > +	fi

> I'm not sure about this, why cannot each of the functions take
> TST_TESTFUNC_DATA parameters?

> I.e. we may have two test functions that take exaclty the same array of
> parameters, setting TST_CNT=2 and TST_TESTFUNC_DATA may make sense...

Well, I'll try to add meaningful support for TST_TESTFUNC_DATA :). Let's pass them as
whole for cases where $TST_CNT is set:
+++ testcases/lib/tst_test.sh
@@ -352,14 +352,14 @@ tst_run()
 			if type test1 > /dev/null 2>&1; then
 				for tst_i in $(seq $TST_CNT); do
 					local res=$(tst_resstr)
-					$TST_TESTFUNC$tst_i
+					$TST_TESTFUNC$tst_i $TST_TEST_DATA
 					tst_rescmp "$res"
 					TST_COUNT=$((TST_COUNT+1))
 				done
 			else
 				for tst_i in $(seq $TST_CNT); do
 					local res=$(tst_resstr)
-					$TST_TESTFUNC $tst_i
+					$TST_TESTFUNC $tst_i $TST_TEST_DATA
 					tst_rescmp "$res"
 					TST_COUNT=$((TST_COUNT+1))
 				done

> >  	if [ -n "$TST_CNT" ]; then
> >  		if ! tst_is_int "$TST_CNT"; then
> >  			tst_brk TBROK "TST_CNT must be integer"

And know tst_i (sequence number of a test) for test is needed for some tests which use
only one function - i.e. TST_TESTFUNC_DATA is passed (no TST_CNT). Let's keep $1 as
sequence number and $2 for data itself.
I wonder if $1 shouldn't always have tst_i, even for tests without $TST_CNT. Something
like:
+++ testcases/lib/tst_test.sh
@@ -352,14 +352,14 @@ tst_run()
 			if type test1 > /dev/null 2>&1; then
 				for tst_i in $(seq $TST_CNT); do
 					local res=$(tst_resstr)
-					$TST_TESTFUNC$tst_i
+					$TST_TESTFUNC$tst_i $tst_i $TST_TEST_DATA
 					tst_rescmp "$res"
 					TST_COUNT=$((TST_COUNT+1))
 				done
 			else
 				for tst_i in $(seq $TST_CNT); do
 					local res=$(tst_resstr)
-					$TST_TESTFUNC $tst_i
+					$TST_TESTFUNC $tst_i $TST_TEST_DATA
 					tst_rescmp "$res"
 					TST_COUNT=$((TST_COUNT+1))
 				done
@@ -378,7 +378,7 @@ tst_run()
 			done
 		else
 			local res=$(tst_resstr)
-			$TST_TESTFUNC
+			$TST_TESTFUNC 1
 			tst_rescmp "$res"
 			TST_COUNT=$((TST_COUNT+1))
 		fi


Kind regards,
Petr
