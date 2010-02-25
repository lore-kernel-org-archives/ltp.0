Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NkaOU-0004tx-Bn
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 09:52:30 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NkaOT-000616-Ff
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 09:52:30 +0000
Received: by pwi5 with SMTP id 5so4847903pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Feb 2010 01:52:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100225090027.GC3377@linux.vnet.ibm.com>
References: <4B728073.3070209@cn.fujitsu.com>
	<4B7B9EC2.1010004@linux.vnet.ibm.com>
	<364299f41002170914u3a0d0b02o936a81d1ee601ecc@mail.gmail.com>
	<4B823884.4000100@cn.fujitsu.com>
	<364299f41002241922h31f32a1em6f12a2999fd931f8@mail.gmail.com>
	<20100225090027.GC3377@linux.vnet.ibm.com>
Date: Thu, 25 Feb 2010 01:52:23 -0800
Message-ID: <364299f41002250152u78dfacc3mab2d355b1f50baa9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] timers: support clockid of
	CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE
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
To: Garrett Cooper <yanegomi@gmail.com>, Shi Weihua <shiwh@cn.fujitsu.com>, ltp-list <ltp-list@lists.sourceforge.net>

On Thu, Feb 25, 2010 at 1:00 AM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Wed, Feb 24, 2010 at 07:22:09PM -0800, Garrett Cooper wrote:
>> =A0 =A0 I've added the autoconf-conditionalized variables along with your
>> changes, and some other minor cleanups to git just moments ago.
> Hi Garret,
>
> Getting the build error on today's tree as:
>
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/root/temp/testcases/kernel/include -D_GNU_SOURCE
> -I/root/temp/testcases/kernel/timers/clock_gettime/../include
> -I../../../../include -I../../../../include =A0 -L../../../../lib
> clock_gettime02.c =A0 -lltp -lpthread -lrt -o clock_gettime02
> In file included from clock_gettime02.c:73:
> /root/temp/testcases/kernel/timers/clock_gettime/../include/common_timers=
.h:22:
> error: `CLOCK_MONOTONIC_RAW' undeclared here (not in a function)
> /root/temp/testcases/kernel/timers/clock_gettime/../include/common_timers=
.h:22:
> error: initializer element is not constant
> /root/temp/testcases/kernel/timers/clock_gettime/../include/common_timers=
.h:22:
> error: (near initialization for `clock_list[4]')
> make[4]: *** [clock_gettime02] Error 1
> make[4]: Leaving directory
> `/root/temp/testcases/kernel/timers/clock_gettime'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/root/temp/testcases/kernel/timers'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/temp/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/temp/testcases'
> make: *** [testcases-all] Error 2
> [root@elm17d44 temp]# vim
> /root/temp/testcases/kernel/timers/clock_gettime/../include/common_timers=
.h
>
>
> And this patch solves the problem, please Ack it if it is correct
> solution, so that i can merge to tree.
>
> =A0 =A0Signed-off-by: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
>
> diff --git a/testcases/kernel/timers/include/common_timers.h
> b/testcases/kernel/timers/include/common_timers.h
> index cae9626..1e103b1 100644
> --- a/testcases/kernel/timers/include/common_timers.h
> +++ b/testcases/kernel/timers/include/common_timers.h
> @@ -19,7 +19,6 @@ clock_t clock_list[] =3D {
> =A0 =A0 =A0 =A0CLOCK_MONOTONIC,
> =A0 =A0 =A0 =A0CLOCK_PROCESS_CPUTIME_ID,
> =A0 =A0 =A0 =A0CLOCK_THREAD_CPUTIME_ID,
> - =A0 =A0 =A0 CLOCK_MONOTONIC_RAW,
> =A0#if HAVE_CLOCK_REALTIME_COARSE
> =A0 =A0 =A0 =A0CLOCK_REALTIME_COARSE,
> =A0#endif
> @@ -40,7 +39,6 @@ const char *get_clock_str(const int clock_id)
> =A0 =A0 =A0 =A0CLOCK_TO_STR(CLOCK_MONOTONIC);
> =A0 =A0 =A0 =A0CLOCK_TO_STR(CLOCK_PROCESS_CPUTIME_ID);
> =A0 =A0 =A0 =A0CLOCK_TO_STR(CLOCK_THREAD_CPUTIME_ID);
> - =A0 =A0 =A0 CLOCK_TO_STR(CLOCK_MONOTONIC_RAW);
> =A0#if HAVE_CLOCK_REALTIME_COARSE
> =A0 =A0 =A0 =A0CLOCK_TO_STR(CLOCK_REALTIME_COARSE);
> =A0#endif

    What version of Linux is this? I specifically took out the #ifndef
... #define ... #endif blocks because I'm trying to avoid these ad hoc
#define's scattered around the tree.
Thanks,
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
