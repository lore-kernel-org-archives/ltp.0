Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MODmJ-000094-P7
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 16:44:23 +0000
Received: from an-out-0708.google.com ([209.85.132.246])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MODm7-0003iV-TZ
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 16:44:15 +0000
Received: by an-out-0708.google.com with SMTP id c38so1981478ana.37
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Jul 2009 09:44:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810907070452u62c1c4c6l3f3ed8f1f169f209@mail.gmail.com>
References: <f5a7b3810907030846x35249218u1fe574ba70f796fd@mail.gmail.com>
	<1246895458.4887.53.camel@subratamodak.linux.ibm.com>
	<f5a7b3810907070452u62c1c4c6l3f3ed8f1f169f209@mail.gmail.com>
Date: Tue, 7 Jul 2009 09:44:11 -0700
Message-ID: <364299f40907070944k7b7b0ce5xb6ace62849c94552@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [FIX PATCHE] rt_sigaction
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>

On Tue, Jul 7, 2009 at 4:52 AM, naresh kamboju<naresh.kernel@gmail.com> wro=
te:
> Hi Garrett Cooper,
>
> Thanks for your info.
>
>>Oops... looks like someone forgot __amd64__ / >__ia64__:
>
> yes.
> i forgot to add these ARCH.
> Because I am not having this Architecture at my end :-(
>
>>gcc -g -O2 -I../../include -g -Wall -I../../../../include >-Wall -O2 -W
>>rt_sigaction01.c -L../../../../lib -lltp -o rt_sigaction01
>>rt_sigaction01.c: In function 'set_handler':
>>rt_sigaction01.c:147: error: 'SIGSETSIZE' >undeclared .(first use in
>>this function)
>>rt_sigaction01.c:147: error: (Each undeclared >identifier is reported onl=
y once
>>rt_sigaction01.c:147: error: for each function it >appears in.)
>>make[4]: *** [rt_sigaction01] Error 1
>
>>I tried using sizeof(sigaction_t), but unfortunately the >results for
>>the testcase(s) on my system were always EINVAL. >This issue wasn't
>>present a few days ago...
>
>>Any ideas?
>
>
> I have made a patch to fix this issue please review the this temporary fi=
x.
>
> In my previous mail I have stated that sigset size (size_t sigsetsize)
> will be different for Different ARCH. It is depending on
> _COMPAT_NSIG_WORDS Macro.
>
> We have to conform how its different with respect to ARCH and need to
> have a generic solution to fix this issue.
>
> I think its going to be an issue othere than __arm__ || __i386__ ||
> __powerpc__ || __amd64__ || __ia64__ and __mips__
>
> There are different ARCH are being used by our LTP developers.
>
> I=92ll investigate this issue and come back with generic Solution to
> support most of the ARCH.
>
>
> please refer this =A0linux-2.6.30/include/linux/compat.h
>
> http://lxr.linux.no/linux+v2.6.30/include/linux/compat.h#L75
>
> #define _COMPAT_NSIG_WORDS =A0 =A0 =A0(_COMPAT_NSIG / _COMPAT_NSIG_BPW)
>
> =A0typedef struct {
> =A0 =A0 =A0 =A0 =A0compat_sigset_word =A0 =A0 =A0sig[_COMPAT_NSIG_WORDS];
> =A0} compat_sigset_t;
>
> Your suggestions are welcome ... :)

Naresh -- that looks good. Please see the other patch I submitted to
the list for another possible solution for all archs (I did that after
inspecting the headers you sent me :)..). It gets the app to compile
and run properly (minus a mysterious segfault in the first testcase,
associated with the realtime signal, 34).

I really wish there was a way to determine the value of the constants
without asm/compat.h and linux/compat.h :(...

-Garrett

gcooper@orangebox /scratch/ltp-vanilla/ltp $
/scratch/ltp-vanilla/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigactio=
n01
rt_sigaction01    0  INFO  :  signal: 34
rt_sigaction01    1  PASS  :  rt_sigaction call succeeded: result =3D 0
rt_sigaction01    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
Segmentation fault
gcooper@orangebox /scratch/ltp-vanilla/ltp $
/scratch/ltp-vanilla/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigactio=
n02
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02    1  PASS  :  rt_sigaction02 failure with sig: 34 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02    2  PASS  :  rt_sigaction02 failure with sig: 34 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02    3  PASS  :  rt_sigaction02 failure with sig: 34 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02    4  PASS  :  rt_sigaction02 failure with sig: 34 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02    5  PASS  :  rt_sigaction02 failure with sig: 34 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02    6  PASS  :  rt_sigaction02 failure with sig: 35 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02    7  PASS  :  rt_sigaction02 failure with sig: 35 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02    8  PASS  :  rt_sigaction02 failure with sig: 35 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02    9  PASS  :  rt_sigaction02 failure with sig: 35 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   10  PASS  :  rt_sigaction02 failure with sig: 35 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   11  PASS  :  rt_sigaction02 failure with sig: 36 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   12  PASS  :  rt_sigaction02 failure with sig: 36 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   13  PASS  :  rt_sigaction02 failure with sig: 36 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   14  PASS  :  rt_sigaction02 failure with sig: 36 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   15  PASS  :  rt_sigaction02 failure with sig: 36 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   16  PASS  :  rt_sigaction02 failure with sig: 37 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   17  PASS  :  rt_sigaction02 failure with sig: 37 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   18  PASS  :  rt_sigaction02 failure with sig: 37 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   19  PASS  :  rt_sigaction02 failure with sig: 37 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   20  PASS  :  rt_sigaction02 failure with sig: 37 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   21  PASS  :  rt_sigaction02 failure with sig: 38 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   22  PASS  :  rt_sigaction02 failure with sig: 38 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   23  PASS  :  rt_sigaction02 failure with sig: 38 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   24  PASS  :  rt_sigaction02 failure with sig: 38 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   25  PASS  :  rt_sigaction02 failure with sig: 38 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   26  PASS  :  rt_sigaction02 failure with sig: 39 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   27  PASS  :  rt_sigaction02 failure with sig: 39 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   28  PASS  :  rt_sigaction02 failure with sig: 39 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   29  PASS  :  rt_sigaction02 failure with sig: 39 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   30  PASS  :  rt_sigaction02 failure with sig: 39 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   31  PASS  :  rt_sigaction02 failure with sig: 40 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   32  PASS  :  rt_sigaction02 failure with sig: 40 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   33  PASS  :  rt_sigaction02 failure with sig: 40 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   34  PASS  :  rt_sigaction02 failure with sig: 40 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   35  PASS  :  rt_sigaction02 failure with sig: 40 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   36  PASS  :  rt_sigaction02 failure with sig: 41 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   37  PASS  :  rt_sigaction02 failure with sig: 41 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   38  PASS  :  rt_sigaction02 failure with sig: 41 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   39  PASS  :  rt_sigaction02 failure with sig: 41 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   40  PASS  :  rt_sigaction02 failure with sig: 41 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   41  PASS  :  rt_sigaction02 failure with sig: 42 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   42  PASS  :  rt_sigaction02 failure with sig: 42 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   43  PASS  :  rt_sigaction02 failure with sig: 42 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   44  PASS  :  rt_sigaction02 failure with sig: 42 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   45  PASS  :  rt_sigaction02 failure with sig: 42 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   46  PASS  :  rt_sigaction02 failure with sig: 43 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   47  PASS  :  rt_sigaction02 failure with sig: 43 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   48  PASS  :  rt_sigaction02 failure with sig: 43 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   49  PASS  :  rt_sigaction02 failure with sig: 43 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   50  PASS  :  rt_sigaction02 failure with sig: 43 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   51  PASS  :  rt_sigaction02 failure with sig: 44 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   52  PASS  :  rt_sigaction02 failure with sig: 44 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   53  PASS  :  rt_sigaction02 failure with sig: 44 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   54  PASS  :  rt_sigaction02 failure with sig: 44 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   55  PASS  :  rt_sigaction02 failure with sig: 44 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   56  PASS  :  rt_sigaction02 failure with sig: 45 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   57  PASS  :  rt_sigaction02 failure with sig: 45 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   58  PASS  :  rt_sigaction02 failure with sig: 45 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   59  PASS  :  rt_sigaction02 failure with sig: 45 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   60  PASS  :  rt_sigaction02 failure with sig: 45 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   61  PASS  :  rt_sigaction02 failure with sig: 46 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   62  PASS  :  rt_sigaction02 failure with sig: 46 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   63  PASS  :  rt_sigaction02 failure with sig: 46 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   64  PASS  :  rt_sigaction02 failure with sig: 46 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   65  PASS  :  rt_sigaction02 failure with sig: 46 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   66  PASS  :  rt_sigaction02 failure with sig: 47 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   67  PASS  :  rt_sigaction02 failure with sig: 47 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   68  PASS  :  rt_sigaction02 failure with sig: 47 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   69  PASS  :  rt_sigaction02 failure with sig: 47 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   70  PASS  :  rt_sigaction02 failure with sig: 47 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   71  PASS  :  rt_sigaction02 failure with sig: 48 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   72  PASS  :  rt_sigaction02 failure with sig: 48 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   73  PASS  :  rt_sigaction02 failure with sig: 48 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   74  PASS  :  rt_sigaction02 failure with sig: 48 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   75  PASS  :  rt_sigaction02 failure with sig: 48 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   76  PASS  :  rt_sigaction02 failure with sig: 49 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   77  PASS  :  rt_sigaction02 failure with sig: 49 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   78  PASS  :  rt_sigaction02 failure with sig: 49 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   79  PASS  :  rt_sigaction02 failure with sig: 49 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   80  PASS  :  rt_sigaction02 failure with sig: 49 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   81  PASS  :  rt_sigaction02 failure with sig: 50 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   82  PASS  :  rt_sigaction02 failure with sig: 50 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   83  PASS  :  rt_sigaction02 failure with sig: 50 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   84  PASS  :  rt_sigaction02 failure with sig: 50 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   85  PASS  :  rt_sigaction02 failure with sig: 50 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   86  PASS  :  rt_sigaction02 failure with sig: 51 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   87  PASS  :  rt_sigaction02 failure with sig: 51 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   88  PASS  :  rt_sigaction02 failure with sig: 51 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   89  PASS  :  rt_sigaction02 failure with sig: 51 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   90  PASS  :  rt_sigaction02 failure with sig: 51 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   91  PASS  :  rt_sigaction02 failure with sig: 52 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   92  PASS  :  rt_sigaction02 failure with sig: 52 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   93  PASS  :  rt_sigaction02 failure with sig: 52 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   94  PASS  :  rt_sigaction02 failure with sig: 52 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02   95  PASS  :  rt_sigaction02 failure with sig: 52 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   96  PASS  :  rt_sigaction02 failure with sig: 53 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02   97  PASS  :  rt_sigaction02 failure with sig: 53 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   98  PASS  :  rt_sigaction02 failure with sig: 53 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02   99  PASS  :  rt_sigaction02 failure with sig: 53 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02  100  PASS  :  rt_sigaction02 failure with sig: 53 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  101  PASS  :  rt_sigaction02 failure with sig: 54 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02  102  PASS  :  rt_sigaction02 failure with sig: 54 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  103  PASS  :  rt_sigaction02 failure with sig: 54 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  104  PASS  :  rt_sigaction02 failure with sig: 54 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02  105  PASS  :  rt_sigaction02 failure with sig: 54 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  106  PASS  :  rt_sigaction02 failure with sig: 55 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02  107  PASS  :  rt_sigaction02 failure with sig: 55 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  108  PASS  :  rt_sigaction02 failure with sig: 55 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  109  PASS  :  rt_sigaction02 failure with sig: 55 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02  110  PASS  :  rt_sigaction02 failure with sig: 55 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  111  PASS  :  rt_sigaction02 failure with sig: 56 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02  112  PASS  :  rt_sigaction02 failure with sig: 56 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  113  PASS  :  rt_sigaction02 failure with sig: 56 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  114  PASS  :  rt_sigaction02 failure with sig: 56 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02  115  PASS  :  rt_sigaction02 failure with sig: 56 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  116  PASS  :  rt_sigaction02 failure with sig: 57 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02  117  PASS  :  rt_sigaction02 failure with sig: 57 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  118  PASS  :  rt_sigaction02 failure with sig: 57 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  119  PASS  :  rt_sigaction02 failure with sig: 57 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02  120  PASS  :  rt_sigaction02 failure with sig: 57 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  121  PASS  :  rt_sigaction02 failure with sig: 58 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02  122  PASS  :  rt_sigaction02 failure with sig: 58 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  123  PASS  :  rt_sigaction02 failure with sig: 58 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  124  PASS  :  rt_sigaction02 failure with sig: 58 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02  125  PASS  :  rt_sigaction02 failure with sig: 58 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  126  PASS  :  rt_sigaction02 failure with sig: 59 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02  127  PASS  :  rt_sigaction02 failure with sig: 59 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  128  PASS  :  rt_sigaction02 failure with sig: 59 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  129  PASS  :  rt_sigaction02 failure with sig: 59 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02  130  PASS  :  rt_sigaction02 failure with sig: 59 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  131  PASS  :  rt_sigaction02 failure with sig: 60 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02  132  PASS  :  rt_sigaction02 failure with sig: 60 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  133  PASS  :  rt_sigaction02 failure with sig: 60 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  134  PASS  :  rt_sigaction02 failure with sig: 60 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02  135  PASS  :  rt_sigaction02 failure with sig: 60 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  136  PASS  :  rt_sigaction02 failure with sig: 61 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02  137  PASS  :  rt_sigaction02 failure with sig: 61 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  138  PASS  :  rt_sigaction02 failure with sig: 61 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  139  PASS  :  rt_sigaction02 failure with sig: 61 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02  140  PASS  :  rt_sigaction02 failure with sig: 61 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  141  PASS  :  rt_sigaction02 failure with sig: 62 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02  142  PASS  :  rt_sigaction02 failure with sig: 62 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  143  PASS  :  rt_sigaction02 failure with sig: 62 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  144  PASS  :  rt_sigaction02 failure with sig: 62 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_NOMASK
rt_sigaction02  145  PASS  :  rt_sigaction02 failure with sig: 62 as
expected errno  =3D EFAULT : Bad address

rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO
rt_sigaction02  146  PASS  :  rt_sigaction02 failure with sig: 63 as
expected errno  =3D EFAULT : Bad address
rt_sigaction02    0  INFO  :  sa.sa_flags =3D SA_RESETHAND
rt_sigaction02  147  PASS  :  rt_sigaction02 failure with sig: 63 as
expected errno  =3D EFAULT : Bad address
gcooper@orangebox /scratch/ltp-vanilla/ltp $ gdb
testcases/kernel/syscalls/rt_sigaction/rt_sigaction01
GNU gdb 6.8
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.htm=
l>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu"...
(gdb) r
Starting program:
/scratch/ltp-vanilla/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigactio=
n01
rt_sigaction01    0  INFO  :  signal: 34
rt_sigaction01    1  PASS  :  rt_sigaction call succeeded: result =3D 0
rt_sigaction01    0  INFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO

Program received signal SIG34, Real-time event 34.
0x00007f770ba0b4f7 in kill () from /lib/libc.so.6
(gdb) where
#0  0x00007f770ba0b4f7 in kill () from /lib/libc.so.6
#1  0x0000000000401c3e in main ()
(gdb)

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have =

the opportunity to enter the BlackBerry Developer Challenge. See full prize =

details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
