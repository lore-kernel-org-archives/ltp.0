Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MNxEH-0005iD-RL
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 23:04:09 +0000
Received: from an-out-0708.google.com ([209.85.132.246])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNxEA-0005vv-LH
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 23:04:09 +0000
Received: by an-out-0708.google.com with SMTP id c38so1778752ana.37
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 16:04:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8368651DACC1964480F951191B94A078D01051@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078D0102F@svexch01.mvista.com>
	<364299f40907061452k598a0890kbac3ec9742b45ad8@mail.gmail.com>
	<8368651DACC1964480F951191B94A078D01051@svexch01.mvista.com>
Date: Mon, 6 Jul 2009 16:04:02 -0700
Message-ID: <364299f40907061604l44379a21s1470367f74fed979@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] controllers/cpuset tests: use CC variable isntead
	of hardcoded cc to fix cross compiling
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Jul 6, 2009 at 3:52 PM, Henry Yei<hyei@mvista.com> wrote:
> Garrett,
>
> This is definitely true from cpuset_memory_pressure_test and cpuset_memor=
y_spread_test make files, but cpuset_memory_test needs the -lpthread.
>
>
> Using implicit rules, I get the following error:
>
> [15:48:27][hyei@hyei2:/tmp/ltp-full-20090531/testcases/kernel/controllers=
/cpuset/cpuset_memory_test]$ make
> gcc =A0 cpuset_memory_test.o ../cpuset_lib/cpuinfo.o ../cpuset_lib/libbit=
mask.o ../cpuset_lib/libcpuset.o ../cpuset_lib/meminfo.o =A0 -o cpuset_memo=
ry_test
> cpuset_memory_test.o: In function `thread2_routine': /tmp/ltp-full-200905=
31/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_tes=
t.c:333: undefined reference to `pthread_sigmask'
> cpuset_memory_test.o: In function `main': /tmp/ltp-full-20090531/testcase=
s/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c:370: un=
defined reference to `pthread_create' /tmp/ltp-full-20090531/testcases/kern=
el/controllers/cpuset/cpuset_memory_test/cpuset_memory_test.c:372: undefine=
d reference to `pthread_sigmask' /tmp/ltp-full-20090531/testcases/kernel/co=
ntrollers/cpuset/cpuset_memory_test/cpuset_memory_test.c:380: undefined ref=
erence to `pthread_cancel' /tmp/ltp-full-20090531/testcases/kernel/controll=
ers/cpuset/cpuset_memory_test/cpuset_memory_test.c:381: undefined reference=
 to `pthread_join'
> collect2: ld returned 1 exit status
> make: *** [cpuset_memory_test] Error 1
>
> If there is something I'm missing, let me know and I'll re-submit the pri=
or patches.
>
> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Monday, July 06, 2009 2:53 PM
> To: Henry Yei
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] [PATCH] controllers/cpuset tests: use CC variable isnt=
ead of hardcoded cc to fix cross compiling
>
> On Mon, Jul 6, 2009 at 2:34 PM, Henry Yei<hyei@mvista.com> wrote:
>> I am submitting patches for the Makefiles of the following tests: cpuset=
_memory_pressure_test, cpuset_memory_spread_test , and cpuset_memory_test. =
Instead of using cc (host compiler), use $(CC) for provide for cross compil=
ing.
>
> Just delete:
>
> + =A0 =A0 =A0 $(CC) cpuset_memory_test.o $(LIBOBJECTS) -o cpuset_memory_t=
est
> +-lpthread
>
> implicit rules will take care of the rest.
>
> -Garrett

Well, you kind of have to do:

LDLIBS    +=3D -lpthread

somewhere in the Makefile. Sorry for not explicitly mentioning that point ;=
\...

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
