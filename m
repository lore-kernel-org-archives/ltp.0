Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NjREo-0002pK-OS
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 05:53:46 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NjREk-0000Xz-DC
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 05:53:46 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000701caa62c$4971b140$dc5513c0$@co.jp>	
	<364299f41002050819q7676973k47867cbf9ecf488a@mail.gmail.com>	
	<364299f41002050822u19c38db1xe898805fb80582ea@mail.gmail.com>
	<364299f41002121119y5650305bm37b1b305f1c984a1@mail.gmail.com>
In-Reply-To: <364299f41002121119y5650305bm37b1b305f1c984a1@mail.gmail.com>
Date: Mon, 22 Feb 2010 14:53:31 +0900
Message-ID: <001201cab383$5d479360$17d6ba20$@co.jp>
MIME-Version: 1.0
Content-Language: ja
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Saturday, February 13, 2010 4:19 AM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] "stime01" problem
> =

> On Fri, Feb 5, 2010 at 8:22 AM, Garrett Cooper <yanegomi@gmail.com>
> wrote:
> > On Fri, Feb 5, 2010 at 8:19 AM, Garrett Cooper <yanegomi@gmail.com>
> wrote:
> >> On Thu, Feb 4, 2010 at 10:27 PM, Mitani <mitani@ryobi.co.jp> wrote:
> >>> Hi,
> >>>
> >>> I noticed that "stime01" test let system-clock be faster than right
> time.
> >>>
> >>> "stime01.c" is going to set system-clock by calling "stime()"
> function
> >>> with "new_time" variable.
> >>> It gets "curr_time" by "time()" function, and sets "curr_time +
> 10sec"
> >>> in "new_time".
> >>> But after the test, It doesn't restore system-clock.
> >>>
> >>> Therefore, system-clock is set faster than right time about 10
> seconds
> >>> after "stime01" test.
> >>> If this test is repeated many times, the system-clock advances for
> the
> >>> number of test times.
> >>> And, if system is rebooted, hardware-clock will be wrong.
> >>>
> >>> How about following patch?
> >>
> >> =A0 =A0The patch looks good, but I assume (and hope) that cleanup gets
> >> executed every time before the program exits?
> >
> > Err... two other problems with the above code now that I look at it
> a
> > bit closer...
> >
> > 1. tst_brkm in cleanup shouldn't have cleanup as the second arg; I'm
> > not sure whether or not tst_brkm handles infinite recursion properly;
> > NULL should be the second arg (if you don't want to exit) or tst_exit
> > (if you do want to exit).
> > 2. What happens if you try to restore the time and it failed to get
> > the original time (shouldn't happen, but it can happen if the RTC
> > driver is busted, like it was on the cavium image that I was using
> at
> > my previous job)?
> =

>     Could you please submit a modified patch?
> Thanks!
> -Garrett



I am sorry for the delay in my response.


---
>    The patch looks good, but I assume (and hope) that cleanup gets
>executed every time before the program exits?

I added process for restore system-time in "cleanup()" function.
As you say, in this measure, it is a premise that cleanup() is called
when a program exits.
"cleanup()" should be called when the program exits after system-time =

was changed by "stime()".
When the error occurred after "stime()" called, the program calls =

"tst_brkm()" or "txt_resm()".

(1) There is one "tst_brkm()", and it calls "cleanup()" by its second
    argument.

(2) There are several "tst_resm()", and they don't call exit(). =

    Therefore, cleanup() is called at the last of "main()" function.

Due to the above, I think that "cleanup()" will be called in all cases
and it isn't neccessary to revise them.


---
>1. tst_brkm in cleanup shouldn't have cleanup as the second arg; I'm
>not sure whether or not tst_brkm handles infinite recursion properly;
>NULL should be the second arg (if you don't want to exit) or tst_exit
>(if you do want to exit).

You are right. I think my previous revision is obviously mistake.
I judge that "tst_brkm()" function doesn't have to exit because =

"cleanup()" function calls "tst_exit()".
I think "NULL" should be the second argument of "tst_brkm()".


---
>2. What happens if you try to restore the time and it failed to get
>the original time (shouldn't happen, but it can happen if the RTC
>driver is busted, like it was on the cavium image that I was using at
>my previous job)?

I couldn't understand meanings of the sentence "it failed to get the
original time" well. Do you mean "gettimeofday()" which I added in =

"setup()" function?
If you mean "gettimeofday()", this test will failed or abnormal time =

will be set when "gettimeofday()" got abnormal time.

(1) The case of test failure:
    In my first revision, the test will exit by "tst_brkm()" function.
    But, if cleanup() is called in this "tst_brkm()", "settimeofday()"
    will be called with the abnormal time. =

    Therefore, calling "cleanup()" is wrong.
    I set "NULL" to the second argument of "tst_brkm()", and call =

    "tst_exit()" instead of it.
    "time()" just above is same case. I apply the same measures to =

    the case of "time()" failure.

(2) The case of abnormal time setting:
    "time()" which called by "setup()" function also calls =

    "gettimeofday()" internally.
    "stime()" -- which is this test's purpose -- sets the time (added 10
    seconds at the result of "time()") in system-time.
    Therefore, this test itself will set abnormal time to system-time
    if "gettimeofday()" performed abnormally.
    The risk with gettimeofday() is the same as the risk which this test
    itself has, I think.

    By another way of thinking, if system-time was set 10 seconds faster,
    it is a range of tolerance and there isn't the troubled person so =

    much.
    If The risk of revision is big, I think that there isn't so the =

    meaning to correct daringly. =

    The judgment whether or not I revise it entrusts you.


---
>    Could you please submit a modified patch?

Here the fixed patch.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ./testcases/kernel/syscalls/stime/stime01.c 2009-03-23
22:36:07.000000000 +0900
+++ ./testcases/kernel/syscalls/stime/stime01.c.new     2010-02-22
13:22:25.000000000 +0900
@@ -70,6 +70,7 @@
 #include <sys/types.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <sys/time.h>
 #include <time.h>
 #include <string.h>
 #include <sys/stat.h>
@@ -83,6 +84,7 @@
 char *TCID =3D "stime01";                /* Test program identifier.    */
 int TST_TOTAL =3D 1;             /* Total number of test cases. */
 extern int Tst_count;          /* Test Case counter for tst_* routines */
+struct timeval first_tv;       /* system's current time in micro-seconds */
 time_t curr_time;              /* system's current time in seconds */
 time_t new_time;               /* system's new time */
 time_t tloc;                   /* argument var. for time() */
@@ -187,12 +189,20 @@

        /* Get the current time */
        if ((curr_time =3D time(&tloc)) < 0) {
-               tst_brkm(TBROK, cleanup,
+               tst_brkm(TBROK, NULL,
                         "time() failed to get current time, errno=3D%d",
errno);
+               tst_exit();
         /*NOTREACHED*/}

        /* Get the system's new time */
        new_time =3D curr_time + INCR_TIME;
+
+       /* Get the current time in microsecond */
+       if (gettimeofday(&first_tv, NULL) !=3D 0) {
+               tst_brkm(TBROK, NULL,
+                       "gettimeofday() failed to get current time,
errno=3D%d", errno);
+               tst_exit();
+       }
 }                              /* End setup() */

 /*
@@ -202,6 +212,10 @@
  */
 void cleanup()
 {
+       /* restore current time */
+       if (settimeofday(&first_tv, NULL) !=3D 0)
+               tst_brkm(TBROK, NULL,
+                       "settimeofday() failed to restore current time,
errno=3D%d", errno);
        /*
         * print timing stats if that option was specified.
         * print errno log if that option was specified.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Thank you,

-Tomonori Mitani




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
