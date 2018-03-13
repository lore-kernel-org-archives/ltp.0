From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 13 Mar 2018 14:01:54 +0100
Subject: [LTP] [RFC] [PATCH] shell: ROD_SILENT: Print std{out,
	err} on failure
In-Reply-To: <20180313124647.GA28772@rei>
References: <20180212150302.23347-1-chrubis@suse.cz>
 <87efle670i.fsf@rpws.prws.suse.cz> <20180313124647.GA28772@rei>
Message-ID: <876060w2m5.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

> Hi!
>> > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
>> > index d6b638549..48afb9cc4 100644
>> > --- a/testcases/lib/tst_test.sh
>> > +++ b/testcases/lib/tst_test.sh
>> > @@ -118,8 +118,9 @@ tst_brk()
>> >
>> >  ROD_SILENT()
>> >  {
>> > -	tst_rod $@ > /dev/null 2>&1
>> > +	local tst_out=$(tst_rod $@ 2>&1)
>> >  	if [ $? -ne 0 ]; then
>> > +		echo "$tst_out"
>> >  		tst_brk TBROK "$@ failed"
>> >  	fi
>> >  }
>> > --
>> > 2.13.6
>>
>> LGTM except that you could maybe use ${ } instead of $( ) as a small
>> optimisation.
>
> I do not get it either. Where should I put the ${} insetad of $()?

Sorry I was probably wrong, unless you can somehow change from variable
substitution to redirecting from a group (that is {} > $var not
var=${}).

--
Thank you,
Richard.
