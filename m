Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NjSZy-00076t-4D
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:19:42 +0000
Received: from mail-px0-f171.google.com ([209.85.216.171])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NjSZx-0000gZ-6p
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:19:42 +0000
Received: by pxi1 with SMTP id 1so1361980pxi.23
	for <ltp-list@lists.sourceforge.net>;
	Sun, 21 Feb 2010 23:19:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001201cab383$5d479360$17d6ba20$@co.jp>
References: <000701caa62c$4971b140$dc5513c0$@co.jp>
	<364299f41002050819q7676973k47867cbf9ecf488a@mail.gmail.com>
	<364299f41002050822u19c38db1xe898805fb80582ea@mail.gmail.com>
	<364299f41002121119y5650305bm37b1b305f1c984a1@mail.gmail.com>
	<001201cab383$5d479360$17d6ba20$@co.jp>
Date: Sun, 21 Feb 2010 23:19:34 -0800
Message-ID: <364299f41002212319q516a21aq456538ce010a3d6f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] "stime01" problem
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

Here are my two concerns...

On Sun, Feb 21, 2010 at 9:53 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> -----Original Message-----
>> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> Sent: Saturday, February 13, 2010 4:19 AM
>> To: Mitani
>> Cc: ltp-list@lists.sourceforge.net
>> Subject: Re: [LTP] "stime01" problem
>>
>> On Fri, Feb 5, 2010 at 8:22 AM, Garrett Cooper <yanegomi@gmail.com>
>> wrote:
>> > On Fri, Feb 5, 2010 at 8:19 AM, Garrett Cooper <yanegomi@gmail.com>
>> wrote:
>> >> On Thu, Feb 4, 2010 at 10:27 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> >>> Hi,
>> >>>
>> >>> I noticed that "stime01" test let system-clock be faster than right
>> time.
>> >>>
>> >>> "stime01.c" is going to set system-clock by calling "stime()"
>> function
>> >>> with "new_time" variable.
>> >>> It gets "curr_time" by "time()" function, and sets "curr_time +
>> 10sec"
>> >>> in "new_time".
>> >>> But after the test, It doesn't restore system-clock.
>> >>>
>> >>> Therefore, system-clock is set faster than right time about 10
>> seconds
>> >>> after "stime01" test.
>> >>> If this test is repeated many times, the system-clock advances for
>> the
>> >>> number of test times.
>> >>> And, if system is rebooted, hardware-clock will be wrong.
>> >>>
>> >>> How about following patch?
>> >>
>> >> =A0 =A0The patch looks good, but I assume (and hope) that cleanup gets
>> >> executed every time before the program exits?
>> >
>> > Err... two other problems with the above code now that I look at it
>> a
>> > bit closer...
>> >
>> > 1. tst_brkm in cleanup shouldn't have cleanup as the second arg; I'm
>> > not sure whether or not tst_brkm handles infinite recursion properly;
>> > NULL should be the second arg (if you don't want to exit) or tst_exit
>> > (if you do want to exit).
>> > 2. What happens if you try to restore the time and it failed to get
>> > the original time (shouldn't happen, but it can happen if the RTC
>> > driver is busted, like it was on the cavium image that I was using
>> at
>> > my previous job)?
>>
>> =A0 =A0 Could you please submit a modified patch?
>> Thanks!
>> -Garrett
>
>
>
> I am sorry for the delay in my response.
>
>
> ---
>> =A0 =A0The patch looks good, but I assume (and hope) that cleanup gets
>>executed every time before the program exits?
>
> I added process for restore system-time in "cleanup()" function.
> As you say, in this measure, it is a premise that cleanup() is called
> when a program exits.
> "cleanup()" should be called when the program exits after system-time
> was changed by "stime()".
> When the error occurred after "stime()" called, the program calls
> "tst_brkm()" or "txt_resm()".
>
> (1) There is one "tst_brkm()", and it calls "cleanup()" by its second
> =A0 =A0argument.
>
> (2) There are several "tst_resm()", and they don't call exit().
> =A0 =A0Therefore, cleanup() is called at the last of "main()" function.
>
> Due to the above, I think that "cleanup()" will be called in all cases
> and it isn't neccessary to revise them.

You're making an assumption that the program will execute to
completion. What if the program is interrupted, or for all intensive
purposes doesn't get to cleanup? The problem that you originally
described still exists, as a horse of a different color, and needs to
be fixed.

> ---
>>1. tst_brkm in cleanup shouldn't have cleanup as the second arg; I'm
>>not sure whether or not tst_brkm handles infinite recursion properly;
>>NULL should be the second arg (if you don't want to exit) or tst_exit
>>(if you do want to exit).
>
> You are right. I think my previous revision is obviously mistake.
> I judge that "tst_brkm()" function doesn't have to exit because
> "cleanup()" function calls "tst_exit()".
> I think "NULL" should be the second argument of "tst_brkm()".

If NULL is used, then the tests will be marked broken, but the
application will continue executing; probably not what you want...

> ---
>>2. What happens if you try to restore the time and it failed to get
>>the original time (shouldn't happen, but it can happen if the RTC
>>driver is busted, like it was on the cavium image that I was using at
>>my previous job)?
>
> I couldn't understand meanings of the sentence "it failed to get the
> original time" well. Do you mean "gettimeofday()" which I added in
> "setup()" function?
> If you mean "gettimeofday()", this test will failed or abnormal time
> will be set when "gettimeofday()" got abnormal time.

gettimeofday can and will fail under certain conditions; from gettimeofday(=
2):

RETURN VALUE
       gettimeofday() and settimeofday() return 0 for success, or -1
for failure (in which case errno is set appropriately).

ERRORS
       EFAULT One of tv or tz pointed outside the accessible address space.

       EINVAL Timezone (or something else) is invalid.

       EPERM  The calling process has insufficient privilege to call
settimeofday(); under Linux the CAP_SYS_TIME capability is required.

Assuming that a function call will always pass when it can distinguish
pass from failure is a common mistake that gets made in software
engineering in general, and it's something that we (I am by no means
exempt from this) need to avoid.

> (1) The case of test failure:
> =A0 =A0In my first revision, the test will exit by "tst_brkm()" function.
> =A0 =A0But, if cleanup() is called in this "tst_brkm()", "settimeofday()"
> =A0 =A0will be called with the abnormal time.
> =A0 =A0Therefore, calling "cleanup()" is wrong.
> =A0 =A0I set "NULL" to the second argument of "tst_brkm()", and call
> =A0 =A0"tst_exit()" instead of it.
> =A0 =A0"time()" just above is same case. I apply the same measures to
> =A0 =A0the case of "time()" failure.
>
> (2) The case of abnormal time setting:
> =A0 =A0"time()" which called by "setup()" function also calls
> =A0 =A0"gettimeofday()" internally.
> =A0 =A0"stime()" -- which is this test's purpose -- sets the time (added =
10
> =A0 =A0seconds at the result of "time()") in system-time.
> =A0 =A0Therefore, this test itself will set abnormal time to system-time
> =A0 =A0if "gettimeofday()" performed abnormally.
> =A0 =A0The risk with gettimeofday() is the same as the risk which this te=
st
> =A0 =A0itself has, I think.
>
> =A0 =A0By another way of thinking, if system-time was set 10 seconds fast=
er,
> =A0 =A0it is a range of tolerance and there isn't the troubled person so
> =A0 =A0much.
> =A0 =A0If The risk of revision is big, I think that there isn't so the
> =A0 =A0meaning to correct daringly.
> =A0 =A0The judgment whether or not I revise it entrusts you.

Cheers,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
