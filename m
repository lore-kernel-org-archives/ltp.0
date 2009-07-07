Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MOEMj-0004a8-OA
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 17:22:01 +0000
Received: from mail-vw0-f202.google.com ([209.85.212.202])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOEMf-0002Kd-WD
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 17:22:01 +0000
Received: by vwj40 with SMTP id 40so3739926vwj.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Jul 2009 10:21:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40907070944k7b7b0ce5xb6ace62849c94552@mail.gmail.com>
References: <f5a7b3810907030846x35249218u1fe574ba70f796fd@mail.gmail.com>
	<1246895458.4887.53.camel@subratamodak.linux.ibm.com>
	<f5a7b3810907070452u62c1c4c6l3f3ed8f1f169f209@mail.gmail.com>
	<364299f40907070944k7b7b0ce5xb6ace62849c94552@mail.gmail.com>
Date: Tue, 7 Jul 2009 22:51:53 +0530
Message-ID: <f5a7b3810907071021j4434771dy107bf3540a94af8d@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=00151750ea58e34dae046e20db91
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>

--00151750ea58e34dae046e20db91
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Thanks for your Investigation Garrett :-)
For your information I am sharing the results logs of rt_sigaction01.c on X=
86.
I have attached and below.

Best regards,
Naresh Kamboju


On Tue, Jul 7, 2009 at 10:14 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> On Tue, Jul 7, 2009 at 4:52 AM, naresh kamboju<naresh.kernel@gmail.com> w=
rote:
>> Hi Garrett Cooper,
>>
>> Thanks for your info.
>>
>>>Oops... looks like someone forgot __amd64__ / >__ia64__:
>>
>> yes.
>> i forgot to add these ARCH.
>> Because I am not having this Architecture at my end :-(
>>
>>>gcc -g -O2 -I../../include -g -Wall -I../../../../include >-Wall -O2 -W
>>>rt_sigaction01.c -L../../../../lib -lltp -o rt_sigaction01
>>>rt_sigaction01.c: In function 'set_handler':
>>>rt_sigaction01.c:147: error: 'SIGSETSIZE' >undeclared .(first use in
>>>this function)
>>>rt_sigaction01.c:147: error: (Each undeclared >identifier is reported on=
ly once
>>>rt_sigaction01.c:147: error: for each function it >appears in.)
>>>make[4]: *** [rt_sigaction01] Error 1
>>
>>>I tried using sizeof(sigaction_t), but unfortunately the >results for
>>>the testcase(s) on my system were always EINVAL. >This issue wasn't
>>>present a few days ago...
>>
>>>Any ideas?
>>
>>
>> I have made a patch to fix this issue please review the this temporary f=
ix.
>>
>> In my previous mail I have stated that sigset size (size_t sigsetsize)
>> will be different for Different ARCH. It is depending on
>> _COMPAT_NSIG_WORDS Macro.
>>
>> We have to conform how its different with respect to ARCH and need to
>> have a generic solution to fix this issue.
>>
>> I think its going to be an issue othere than __arm__ || __i386__ ||
>> __powerpc__ || __amd64__ || __ia64__ and __mips__
>>
>> There are different ARCH are being used by our LTP developers.
>>
>> I=92ll investigate this issue and come back with generic Solution to
>> support most of the ARCH.
>>
>>
>> please refer this =A0linux-2.6.30/include/linux/compat.h
>>
>> http://lxr.linux.no/linux+v2.6.30/include/linux/compat.h#L75
>>
>> #define _COMPAT_NSIG_WORDS =A0 =A0 =A0(_COMPAT_NSIG / _COMPAT_NSIG_BPW)
>>
>> =A0typedef struct {
>> =A0 =A0 =A0 =A0 =A0compat_sigset_word =A0 =A0 =A0sig[_COMPAT_NSIG_WORDS]=
;
>> =A0} compat_sigset_t;
>>
>> Your suggestions are welcome ... :)
>
> Naresh -- that looks good. Please see the other patch I submitted to
> the list for another possible solution for all archs (I did that after
> inspecting the headers you sent me :)..). It gets the app to compile
> and run properly (minus a mysterious segfault in the first testcase,
> associated with the realtime signal, 34).
>
> I really wish there was a way to determine the value of the constants
> without asm/compat.h and linux/compat.h :(...
>
> -Garrett
>
> gcooper@orangebox /scratch/ltp-vanilla/ltp $
> /scratch/ltp-vanilla/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigact=
ion01
> rt_sigaction01 =A0 =A00 =A0INFO =A0: =A0signal: 34
> rt_sigaction01 =A0 =A01 =A0PASS =A0: =A0rt_sigaction call succeeded: resu=
lt =3D 0
> rt_sigaction01 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> Segmentation fault
> gcooper@orangebox /scratch/ltp-vanilla/ltp $
> /scratch/ltp-vanilla/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigact=
ion02
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 =A01 =A0PASS =A0: =A0rt_sigaction02 failure with sig: =
34 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 =A02 =A0PASS =A0: =A0rt_sigaction02 failure with sig: =
34 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 =A03 =A0PASS =A0: =A0rt_sigaction02 failure with sig: =
34 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 =A04 =A0PASS =A0: =A0rt_sigaction02 failure with sig: =
34 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 =A05 =A0PASS =A0: =A0rt_sigaction02 failure with sig: =
34 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 =A06 =A0PASS =A0: =A0rt_sigaction02 failure with sig: =
35 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 =A07 =A0PASS =A0: =A0rt_sigaction02 failure with sig: =
35 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 =A08 =A0PASS =A0: =A0rt_sigaction02 failure with sig: =
35 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 =A09 =A0PASS =A0: =A0rt_sigaction02 failure with sig: =
35 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 10 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 35=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 11 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 36=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 12 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 36=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 13 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 36=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 14 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 36=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 15 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 36=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 16 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 37=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 17 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 37=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 18 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 37=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 19 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 37=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 20 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 37=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 21 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 38=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 22 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 38=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 23 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 38=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 24 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 38=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 25 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 38=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 26 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 39=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 27 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 39=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 28 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 39=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 29 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 39=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 30 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 39=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 31 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 40=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 32 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 40=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 33 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 40=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 34 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 40=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 35 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 40=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 36 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 41=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 37 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 41=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 38 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 41=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 39 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 41=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 40 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 41=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 41 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 42=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 42 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 42=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 43 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 42=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 44 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 42=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 45 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 42=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 46 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 43=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 47 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 43=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 48 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 43=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 49 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 43=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 50 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 43=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 51 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 44=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 52 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 44=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 53 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 44=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 54 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 44=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 55 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 44=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 56 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 45=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 57 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 45=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 58 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 45=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 59 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 45=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 60 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 45=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 61 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 46=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 62 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 46=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 63 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 46=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 64 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 46=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 65 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 46=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 66 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 47=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 67 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 47=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 68 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 47=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 69 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 47=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 70 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 47=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 71 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 48=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 72 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 48=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 73 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 48=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 74 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 48=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 75 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 48=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 76 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 49=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 77 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 49=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 78 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 49=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 79 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 49=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 80 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 49=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 81 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 50=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 82 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 50=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 83 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 50=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 84 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 50=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 85 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 50=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 86 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 51=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 87 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 51=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 88 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 51=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 89 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 51=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 90 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 51=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 91 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 52=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 92 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 52=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 93 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 52=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 94 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 52=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0 95 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 52=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 96 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 53=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0 97 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 53=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 98 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 53=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0 99 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 53=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0100 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 53=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0101 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 54=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0102 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 54=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0103 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 54=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0104 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 54=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0105 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 54=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0106 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 55=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0107 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 55=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0108 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 55=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0109 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 55=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0110 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 55=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0111 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 56=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0112 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 56=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0113 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 56=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0114 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 56=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0115 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 56=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0116 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 57=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0117 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 57=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0118 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 57=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0119 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 57=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0120 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 57=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0121 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 58=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0122 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 58=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0123 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 58=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0124 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 58=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0125 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 58=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0126 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 59=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0127 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 59=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0128 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 59=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0129 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 59=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0130 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 59=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0131 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 60=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0132 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 60=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0133 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 60=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0134 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 60=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0135 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 60=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0136 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 61=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0137 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 61=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0138 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 61=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0139 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 61=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0140 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 61=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0141 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 62=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0142 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 62=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0143 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 62=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0144 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 62=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_NOMASK
> rt_sigaction02 =A0145 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 62=
 as
> expected errno =A0=3D EFAULT : Bad address
>
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
> rt_sigaction02 =A0146 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 63=
 as
> expected errno =A0=3D EFAULT : Bad address
> rt_sigaction02 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND
> rt_sigaction02 =A0147 =A0PASS =A0: =A0rt_sigaction02 failure with sig: 63=
 as
> expected errno =A0=3D EFAULT : Bad address
> gcooper@orangebox /scratch/ltp-vanilla/ltp $ gdb
> testcases/kernel/syscalls/rt_sigaction/rt_sigaction01
> GNU gdb 6.8
> Copyright (C) 2008 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.h=
tml>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law. =A0Type "show copyi=
ng"
> and "show warranty" for details.
> This GDB was configured as "x86_64-pc-linux-gnu"...
> (gdb) r
> Starting program:
> /scratch/ltp-vanilla/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigact=
ion01
> rt_sigaction01 =A0 =A00 =A0INFO =A0: =A0signal: 34
> rt_sigaction01 =A0 =A01 =A0PASS =A0: =A0rt_sigaction call succeeded: resu=
lt =3D 0
> rt_sigaction01 =A0 =A00 =A0INFO =A0: =A0sa.sa_flags =3D SA_RESETHAND|SA_S=
IGINFO
>
> Program received signal SIG34, Real-time event 34.
> 0x00007f770ba0b4f7 in kill () from /lib/libc.so.6
> (gdb) where
> #0 =A00x00007f770ba0b4f7 in kill () from /lib/libc.so.6
> #1 =A00x0000000000401c3e in main ()
> (gdb)
>

--00151750ea58e34dae046e20db91
Content-Type: application/octet-stream; name="rt_sigaction01_results.log"
Content-Disposition: attachment; filename="rt_sigaction01_results.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwuw13dk0

cnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiAzNCAKcnRfc2lnYWN0aW9uMDEg
ICAgMSAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApy
dF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxT
QV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBD
YWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDM0CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6
ICBzaWduYWw6IDM0IApydF9zaWdhY3Rpb24wMSAgICAyICBQQVNTICA6ICBydF9zaWdhY3Rpb24g
Y2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDog
IHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6
ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDM0CgpydF9zaWdhY3Rp
b24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDM0IApydF9zaWdhY3Rpb24wMSAgICAzICBQQVNT
ICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlv
bjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8g
CnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRo
IHNpZ25hbCBudW1iZXIgMzQKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDog
MzQgCnJ0X3NpZ2FjdGlvbjAxICAgIDQgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2Nl
ZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxh
Z3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAg
OiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciAzNAoKcnRfc2lnYWN0
aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiAzNCAKcnRfc2lnYWN0aW9uMDEgICAgNSAgUEFT
UyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rp
b24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX05PTUFTSyAKcnRfc2lnYWN0aW9u
MDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJl
ciAzNAoKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogMzUgCnJ0X3NpZ2Fj
dGlvbjAxICAgIDYgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0
ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNF
VEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhh
bmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciAzNQoKcnRfc2lnYWN0aW9uMDEgICAgMCAg
SU5GTyAgOiAgc2lnbmFsOiAzNSAKcnRfc2lnYWN0aW9uMDEgICAgNyAgUEFTUyAgOiAgcnRfc2ln
YWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJ
TkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORCAKcnRfc2lnYWN0aW9uMDEgICAgMCAg
SU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciAzNQoKcnRf
c2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiAzNSAKcnRfc2lnYWN0aW9uMDEgICAg
OCAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9z
aWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9T
SUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxs
ZWQgd2l0aCBzaWduYWwgbnVtYmVyIDM1CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBz
aWduYWw6IDM1IApydF9zaWdhY3Rpb24wMSAgICA5ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2Fs
bCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNh
LnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAg
IElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgMzUKCnJ0
X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogMzUgCnJ0X3NpZ2FjdGlvbjAxICAg
MTAgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRf
c2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9OT01BU0sgCnJ0X3Np
Z2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25h
bCBudW1iZXIgMzUKCgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDM2IApy
dF9zaWdhY3Rpb24wMSAgIDExICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6
IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0g
U0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNp
Z25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgMzYKCnJ0X3NpZ2FjdGlvbjAx
ICAgIDAgIElORk8gIDogIHNpZ25hbDogMzYgCnJ0X3NpZ2FjdGlvbjAxICAgMTIgIFBBU1MgIDog
IHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEg
ICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkQgCnJ0X3NpZ2FjdGlvbjAx
ICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIg
MzYKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogMzYgCnJ0X3NpZ2FjdGlv
bjAxICAgMTMgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0g
MCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhB
TkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRs
ZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciAzNgoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5G
TyAgOiAgc2lnbmFsOiAzNiAKcnRfc2lnYWN0aW9uMDEgICAxNCAgUEFTUyAgOiAgcnRfc2lnYWN0
aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZP
ICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24w
MSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVy
IDM2CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDM2IApydF9zaWdhY3Rp
b24wMSAgIDE1ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9
IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfTk9NQVNL
IApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0
aCBzaWduYWwgbnVtYmVyIDM2CgoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFs
OiAzNyAKcnRfc2lnYWN0aW9uMDEgICAxNiAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3Vj
Y2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9m
bGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZP
ICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDM3CgpydF9zaWdh
Y3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDM3IApydF9zaWdhY3Rpb24wMSAgIDE3ICBQ
QVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2Fj
dGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EIApydF9zaWdh
Y3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwg
bnVtYmVyIDM3CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDM3IApydF9z
aWdhY3Rpb24wMSAgIDE4ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJl
c3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0Ff
UkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25h
bCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgMzcKCnJ0X3NpZ2FjdGlvbjAxICAg
IDAgIElORk8gIDogIHNpZ25hbDogMzcgCnJ0X3NpZ2FjdGlvbjAxICAgMTkgIFBBU1MgIDogIHJ0
X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAg
MCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2ln
YWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFs
IG51bWJlciAzNwoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiAzNyAKcnRf
c2lnYWN0aW9uMDEgICAyMCAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiBy
ZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNB
X05PTUFTSyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2Fs
bGVkIHdpdGggc2lnbmFsIG51bWJlciAzNwoKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDog
IHNpZ25hbDogMzggCnJ0X3NpZ2FjdGlvbjAxICAgMjEgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBj
YWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAg
c2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAg
MCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciAzOAoK
cnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiAzOCAKcnRfc2lnYWN0aW9uMDEg
ICAyMiAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApy
dF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORCAK
cnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGgg
c2lnbmFsIG51bWJlciAzOAoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiAz
OCAKcnRfc2lnYWN0aW9uMDEgICAyMyAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2Vl
ZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFn
cyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6
ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDM4CgpydF9zaWdhY3Rp
b24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDM4IApydF9zaWdhY3Rpb24wMSAgIDI0ICBQQVNT
ICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlv
bjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8g
CnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRo
IHNpZ25hbCBudW1iZXIgMzgKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDog
MzggCnJ0X3NpZ2FjdGlvbjAxICAgMjUgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2Nl
ZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxh
Z3MgPSBTQV9OT01BU0sgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5k
bGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgMzgKCgpydF9zaWdhY3Rpb24wMSAgICAwICBJ
TkZPICA6ICBzaWduYWw6IDM5IApydF9zaWdhY3Rpb24wMSAgIDI2ICBQQVNTICA6ICBydF9zaWdh
Y3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElO
Rk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlv
bjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1i
ZXIgMzkKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogMzkgCnJ0X3NpZ2Fj
dGlvbjAxICAgMjcgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0
ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNF
VEhBTkQgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxl
ZCB3aXRoIHNpZ25hbCBudW1iZXIgMzkKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNp
Z25hbDogMzkgCnJ0X3NpZ2FjdGlvbjAxICAgMjggIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxs
IHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Eu
c2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAg
SU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciAzOQoKcnRf
c2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiAzOSAKcnRfc2lnYWN0aW9uMDEgICAy
OSAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9z
aWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9T
SUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxs
ZWQgd2l0aCBzaWduYWwgbnVtYmVyIDM5CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBz
aWduYWw6IDM5IApydF9zaWdhY3Rpb24wMSAgIDMwICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2Fs
bCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNh
LnNhX2ZsYWdzID0gU0FfTk9NQVNLIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWdu
YWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDM5CgoKcnRfc2lnYWN0aW9uMDEg
ICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA0MCAKcnRfc2lnYWN0aW9uMDEgICAzMSAgUEFTUyAgOiAg
cnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAg
ICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9z
aWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWdu
YWwgbnVtYmVyIDQwCgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDQwIApy
dF9zaWdhY3Rpb24wMSAgIDMyICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6
IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0g
U0FfUkVTRVRIQU5EIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxl
ciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDQwCgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZP
ICA6ICBzaWduYWw6IDQwIApydF9zaWdhY3Rpb24wMSAgIDMzICBQQVNTICA6ICBydF9zaWdhY3Rp
b24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8g
IDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAx
ICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIg
NDAKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNDAgCnJ0X3NpZ2FjdGlv
bjAxICAgMzQgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0g
MCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhB
TkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRs
ZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA0MAoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5G
TyAgOiAgc2lnbmFsOiA0MCAKcnRfc2lnYWN0aW9uMDEgICAzNSAgUEFTUyAgOiAgcnRfc2lnYWN0
aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZP
ICA6ICBzYS5zYV9mbGFncyA9IFNBX05PTUFTSyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAg
OiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA0MAoKCnJ0X3NpZ2Fj
dGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNDEgCnJ0X3NpZ2FjdGlvbjAxICAgMzYgIFBB
U1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0
aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5G
TyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdp
dGggc2lnbmFsIG51bWJlciA0MQoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFs
OiA0MSAKcnRfc2lnYWN0aW9uMDEgICAzNyAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3Vj
Y2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9m
bGFncyA9IFNBX1JFU0VUSEFORCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFs
IEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA0MQoKcnRfc2lnYWN0aW9uMDEgICAg
MCAgSU5GTyAgOiAgc2lnbmFsOiA0MSAKcnRfc2lnYWN0aW9uMDEgICAzOCAgUEFTUyAgOiAgcnRf
c2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAw
ICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdh
Y3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwg
bnVtYmVyIDQxCgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDQxIApydF9z
aWdhY3Rpb24wMSAgIDM5ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJl
c3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0Ff
UkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25h
bCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNDEKCnJ0X3NpZ2FjdGlvbjAxICAg
IDAgIElORk8gIDogIHNpZ25hbDogNDEgCnJ0X3NpZ2FjdGlvbjAxICAgNDAgIFBBU1MgIDogIHJ0
X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAg
MCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9OT01BU0sgCnJ0X3NpZ2FjdGlvbjAxICAgIDAg
IElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNDEKCgpy
dF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDQyIApydF9zaWdhY3Rpb24wMSAg
IDQxICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0
X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNB
X1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENh
bGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNDIKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDog
IHNpZ25hbDogNDIgCnJ0X3NpZ2FjdGlvbjAxICAgNDIgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBj
YWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAg
c2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkQgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDog
IFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNDIKCnJ0X3NpZ2FjdGlv
bjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNDIgCnJ0X3NpZ2FjdGlvbjAxICAgNDMgIFBBU1Mg
IDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9u
MDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAK
cnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGgg
c2lnbmFsIG51bWJlciA0MgoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA0
MiAKcnRfc2lnYWN0aW9uMDEgICA0NCAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2Vl
ZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFn
cyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6
ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDQyCgpydF9zaWdhY3Rp
b24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDQyIApydF9zaWdhY3Rpb24wMSAgIDQ1ICBQQVNT
ICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlv
bjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfTk9NQVNLIApydF9zaWdhY3Rpb24w
MSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVy
IDQyCgoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA0MyAKcnRfc2lnYWN0
aW9uMDEgICA0NiAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQg
PSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VU
SEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFu
ZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDQzCgpydF9zaWdhY3Rpb24wMSAgICAwICBJ
TkZPICA6ICBzaWduYWw6IDQzIApydF9zaWdhY3Rpb24wMSAgIDQ3ICBQQVNTICA6ICBydF9zaWdh
Y3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElO
Rk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EIApydF9zaWdhY3Rpb24wMSAgICAwICBJ
TkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDQzCgpydF9z
aWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDQzIApydF9zaWdhY3Rpb24wMSAgIDQ4
ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3Np
Z2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJ
R0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxl
ZCB3aXRoIHNpZ25hbCBudW1iZXIgNDMKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNp
Z25hbDogNDMgCnJ0X3NpZ2FjdGlvbjAxICAgNDkgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxs
IHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Eu
c2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAg
SU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA0MwoKcnRf
c2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA0MyAKcnRfc2lnYWN0aW9uMDEgICA1
MCAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9z
aWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX05PTUFTSyAKcnRfc2ln
YWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFs
IG51bWJlciA0MwoKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNDQgCnJ0
X3NpZ2FjdGlvbjAxICAgNTEgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDog
cmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBT
QV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2ln
bmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA0NAoKcnRfc2lnYWN0aW9uMDEg
ICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA0NCAKcnRfc2lnYWN0aW9uMDEgICA1MiAgUEFTUyAgOiAg
cnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAg
ICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORCAKcnRfc2lnYWN0aW9uMDEg
ICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA0
NAoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA0NCAKcnRfc2lnYWN0aW9u
MDEgICA1MyAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAw
IApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFO
RHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxl
ciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDQ0CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZP
ICA6ICBzaWduYWw6IDQ0IApydF9zaWdhY3Rpb24wMSAgIDU0ICBQQVNTICA6ICBydF9zaWdhY3Rp
b24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8g
IDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAx
ICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIg
NDQKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNDQgCnJ0X3NpZ2FjdGlv
bjAxICAgNTUgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0g
MCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9OT01BU0sg
CnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRo
IHNpZ25hbCBudW1iZXIgNDQKCgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6
IDQ1IApydF9zaWdhY3Rpb24wMSAgIDU2ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNj
ZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2Zs
YWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8g
IDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNDUKCnJ0X3NpZ2Fj
dGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNDUgCnJ0X3NpZ2FjdGlvbjAxICAgNTcgIFBB
U1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0
aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkQgCnJ0X3NpZ2Fj
dGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBu
dW1iZXIgNDUKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNDUgCnJ0X3Np
Z2FjdGlvbjAxICAgNTggIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVz
dWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9S
RVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFs
IEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA0NQoKcnRfc2lnYWN0aW9uMDEgICAg
MCAgSU5GTyAgOiAgc2lnbmFsOiA0NSAKcnRfc2lnYWN0aW9uMDEgICA1OSAgUEFTUyAgOiAgcnRf
c2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAw
ICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdh
Y3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwg
bnVtYmVyIDQ1CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDQ1IApydF9z
aWdhY3Rpb24wMSAgIDYwICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJl
c3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0Ff
Tk9NQVNLIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxs
ZWQgd2l0aCBzaWduYWwgbnVtYmVyIDQ1CgoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAg
c2lnbmFsOiA0NiAKcnRfc2lnYWN0aW9uMDEgICA2MSAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNh
bGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBz
YS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAw
ICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDQ2Cgpy
dF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDQ2IApydF9zaWdhY3Rpb24wMSAg
IDYyICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0
X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EIApy
dF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBz
aWduYWwgbnVtYmVyIDQ2CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDQ2
IApydF9zaWdhY3Rpb24wMSAgIDYzICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVk
ZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdz
ID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDog
IFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNDYKCnJ0X3NpZ2FjdGlv
bjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNDYgCnJ0X3NpZ2FjdGlvbjAxICAgNjQgIFBBU1Mg
IDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9u
MDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAK
cnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGgg
c2lnbmFsIG51bWJlciA0NgoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA0
NiAKcnRfc2lnYWN0aW9uMDEgICA2NSAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2Vl
ZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFn
cyA9IFNBX05PTUFTSyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRs
ZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA0NgoKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElO
Rk8gIDogIHNpZ25hbDogNDcgCnJ0X3NpZ2FjdGlvbjAxICAgNjYgIFBBU1MgIDogIHJ0X3NpZ2Fj
dGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5G
TyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9u
MDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJl
ciA0NwoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA0NyAKcnRfc2lnYWN0
aW9uMDEgICA2NyAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQg
PSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VU
SEFORCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVk
IHdpdGggc2lnbmFsIG51bWJlciA0NwoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2ln
bmFsOiA0NyAKcnRfc2lnYWN0aW9uMDEgICA2OCAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwg
c3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5z
YV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJ
TkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDQ3CgpydF9z
aWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDQ3IApydF9zaWdhY3Rpb24wMSAgIDY5
ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3Np
Z2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJ
R0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxl
ZCB3aXRoIHNpZ25hbCBudW1iZXIgNDcKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNp
Z25hbDogNDcgCnJ0X3NpZ2FjdGlvbjAxICAgNzAgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxs
IHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Eu
c2FfZmxhZ3MgPSBTQV9OT01BU0sgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25h
bCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNDcKCgpydF9zaWdhY3Rpb24wMSAg
ICAwICBJTkZPICA6ICBzaWduYWw6IDQ4IApydF9zaWdhY3Rpb24wMSAgIDcxICBQQVNTICA6ICBy
dF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAg
IDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3Np
Z2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25h
bCBudW1iZXIgNDgKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNDggCnJ0
X3NpZ2FjdGlvbjAxICAgNzIgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDog
cmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBT
QV9SRVNFVEhBTkQgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVy
IENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNDgKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8g
IDogIHNpZ25hbDogNDggCnJ0X3NpZ2FjdGlvbjAxICAgNzMgIFBBU1MgIDogIHJ0X3NpZ2FjdGlv
biBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAg
OiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEg
ICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA0
OAoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA0OCAKcnRfc2lnYWN0aW9u
MDEgICA3NCAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAw
IApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFO
RHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxl
ciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDQ4CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZP
ICA6ICBzaWduYWw6IDQ4IApydF9zaWdhY3Rpb24wMSAgIDc1ICBQQVNTICA6ICBydF9zaWdhY3Rp
b24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8g
IDogIHNhLnNhX2ZsYWdzID0gU0FfTk9NQVNLIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6
ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDQ4CgoKcnRfc2lnYWN0
aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA0OSAKcnRfc2lnYWN0aW9uMDEgICA3NiAgUEFT
UyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rp
b24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZP
IApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0
aCBzaWduYWwgbnVtYmVyIDQ5CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6
IDQ5IApydF9zaWdhY3Rpb24wMSAgIDc3ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNj
ZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2Zs
YWdzID0gU0FfUkVTRVRIQU5EIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwg
SGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDQ5CgpydF9zaWdhY3Rpb24wMSAgICAw
ICBJTkZPICA6ICBzaWduYWw6IDQ5IApydF9zaWdhY3Rpb24wMSAgIDc4ICBQQVNTICA6ICBydF9z
aWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAg
IElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2Fj
dGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBu
dW1iZXIgNDkKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNDkgCnJ0X3Np
Z2FjdGlvbjAxICAgNzkgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVz
dWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9S
RVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFs
IEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA0OQoKcnRfc2lnYWN0aW9uMDEgICAg
MCAgSU5GTyAgOiAgc2lnbmFsOiA0OSAKcnRfc2lnYWN0aW9uMDEgICA4MCAgUEFTUyAgOiAgcnRf
c2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAw
ICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX05PTUFTSyAKcnRfc2lnYWN0aW9uMDEgICAgMCAg
SU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA0OQoKCnJ0
X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNTAgCnJ0X3NpZ2FjdGlvbjAxICAg
ODEgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRf
c2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0Ff
U0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2Fs
bGVkIHdpdGggc2lnbmFsIG51bWJlciA1MAoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAg
c2lnbmFsOiA1MCAKcnRfc2lnYWN0aW9uMDEgICA4MiAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNh
bGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBz
YS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAg
U2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA1MAoKcnRfc2lnYWN0aW9u
MDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA1MCAKcnRfc2lnYWN0aW9uMDEgICA4MyAgUEFTUyAg
OiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24w
MSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApy
dF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBz
aWduYWwgbnVtYmVyIDUwCgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDUw
IApydF9zaWdhY3Rpb24wMSAgIDg0ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVk
ZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdz
ID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDog
IFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNTAKCnJ0X3NpZ2FjdGlv
bjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNTAgCnJ0X3NpZ2FjdGlvbjAxICAgODUgIFBBU1Mg
IDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9u
MDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9OT01BU0sgCnJ0X3NpZ2FjdGlvbjAx
ICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIg
NTAKCgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDUxIApydF9zaWdhY3Rp
b24wMSAgIDg2ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9
IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRI
QU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5k
bGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNTEKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElO
Rk8gIDogIHNpZ25hbDogNTEgCnJ0X3NpZ2FjdGlvbjAxICAgODcgIFBBU1MgIDogIHJ0X3NpZ2Fj
dGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5G
TyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkQgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElO
Rk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNTEKCnJ0X3Np
Z2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNTEgCnJ0X3NpZ2FjdGlvbjAxICAgODgg
IFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2ln
YWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lH
SU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVk
IHdpdGggc2lnbmFsIG51bWJlciA1MQoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2ln
bmFsOiA1MSAKcnRfc2lnYWN0aW9uMDEgICA4OSAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwg
c3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5z
YV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJ
TkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDUxCgpydF9z
aWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDUxIApydF9zaWdhY3Rpb24wMSAgIDkw
ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3Np
Z2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfTk9NQVNLIApydF9zaWdh
Y3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwg
bnVtYmVyIDUxCgoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA1MiAKcnRf
c2lnYWN0aW9uMDEgICA5MSAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiBy
ZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNB
X1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWdu
YWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDUyCgpydF9zaWdhY3Rpb24wMSAg
ICAwICBJTkZPICA6ICBzaWduYWw6IDUyIApydF9zaWdhY3Rpb24wMSAgIDkyICBQQVNTICA6ICBy
dF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAg
IDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EIApydF9zaWdhY3Rpb24wMSAg
ICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDUy
CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDUyIApydF9zaWdhY3Rpb24w
MSAgIDkzICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAg
CnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5E
fFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVy
IENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNTIKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8g
IDogIHNpZ25hbDogNTIgCnJ0X3NpZ2FjdGlvbjAxICAgOTQgIFBBU1MgIDogIHJ0X3NpZ2FjdGlv
biBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAg
OiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEg
ICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA1
MgoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA1MiAKcnRfc2lnYWN0aW9u
MDEgICA5NSAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAw
IApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX05PTUFTSyAK
cnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGgg
c2lnbmFsIG51bWJlciA1MgoKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDog
NTMgCnJ0X3NpZ2FjdGlvbjAxICAgOTYgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2Nl
ZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxh
Z3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAg
OiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA1MwoKcnRfc2lnYWN0
aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA1MyAKcnRfc2lnYWN0aW9uMDEgICA5NyAgUEFT
UyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rp
b24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORCAKcnRfc2lnYWN0
aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51
bWJlciA1MwoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA1MyAKcnRfc2ln
YWN0aW9uMDEgICA5OCAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1
bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JF
U0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwg
SGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDUzCgpydF9zaWdhY3Rpb24wMSAgICAw
ICBJTkZPICA6ICBzaWduYWw6IDUzIApydF9zaWdhY3Rpb24wMSAgIDk5ICBQQVNTICA6ICBydF9z
aWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAg
IElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2Fj
dGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBu
dW1iZXIgNTMKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNTMgCnJ0X3Np
Z2FjdGlvbjAxICAxMDAgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVz
dWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9O
T01BU0sgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxl
ZCB3aXRoIHNpZ25hbCBudW1iZXIgNTMKCgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBz
aWduYWw6IDU0IApydF9zaWdhY3Rpb24wMSAgMTAxICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2Fs
bCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNh
LnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAg
IElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNTQKCnJ0
X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNTQgCnJ0X3NpZ2FjdGlvbjAxICAx
MDIgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRf
c2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkQgCnJ0
X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNp
Z25hbCBudW1iZXIgNTQKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNTQg
CnJ0X3NpZ2FjdGlvbjAxICAxMDMgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRl
ZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3Mg
PSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAg
U2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA1NAoKcnRfc2lnYWN0aW9u
MDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA1NCAKcnRfc2lnYWN0aW9uMDEgIDEwNCAgUEFTUyAg
OiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24w
MSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApy
dF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBz
aWduYWwgbnVtYmVyIDU0CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDU0
IApydF9zaWdhY3Rpb24wMSAgMTA1ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVk
ZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdz
ID0gU0FfTk9NQVNLIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxl
ciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDU0CgoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5G
TyAgOiAgc2lnbmFsOiA1NSAKcnRfc2lnYWN0aW9uMDEgIDEwNiAgUEFTUyAgOiAgcnRfc2lnYWN0
aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZP
ICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24w
MSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVy
IDU1CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDU1IApydF9zaWdhY3Rp
b24wMSAgMTA3ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9
IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRI
QU5EIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQg
d2l0aCBzaWduYWwgbnVtYmVyIDU1CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWdu
YWw6IDU1IApydF9zaWdhY3Rpb24wMSAgMTA4ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBz
dWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNh
X2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElO
Rk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNTUKCnJ0X3Np
Z2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNTUgCnJ0X3NpZ2FjdGlvbjAxICAxMDkg
IFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2ln
YWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lH
SU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVk
IHdpdGggc2lnbmFsIG51bWJlciA1NQoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2ln
bmFsOiA1NSAKcnRfc2lnYWN0aW9uMDEgIDExMCAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwg
c3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5z
YV9mbGFncyA9IFNBX05PTUFTSyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFs
IEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA1NQoKCnJ0X3NpZ2FjdGlvbjAxICAg
IDAgIElORk8gIDogIHNpZ25hbDogNTYgCnJ0X3NpZ2FjdGlvbjAxICAxMTEgIFBBU1MgIDogIHJ0
X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAg
MCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2ln
YWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFs
IG51bWJlciA1NgoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA1NiAKcnRf
c2lnYWN0aW9uMDEgIDExMiAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiBy
ZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNB
X1JFU0VUSEFORCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIg
Q2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA1NgoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAg
OiAgc2lnbmFsOiA1NiAKcnRfc2lnYWN0aW9uMDEgIDExMyAgUEFTUyAgOiAgcnRfc2lnYWN0aW9u
IGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6
ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAg
ICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDU2
CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDU2IApydF9zaWdhY3Rpb24w
MSAgMTE0ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAg
CnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5E
fFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVy
IENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNTYKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8g
IDogIHNpZ25hbDogNTYgCnJ0X3NpZ2FjdGlvbjAxICAxMTUgIFBBU1MgIDogIHJ0X3NpZ2FjdGlv
biBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAg
OiAgc2Euc2FfZmxhZ3MgPSBTQV9OT01BU0sgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDog
IFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNTYKCgpydF9zaWdhY3Rp
b24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDU3IApydF9zaWdhY3Rpb24wMSAgMTE2ICBQQVNT
ICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlv
bjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8g
CnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRo
IHNpZ25hbCBudW1iZXIgNTcKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDog
NTcgCnJ0X3NpZ2FjdGlvbjAxICAxMTcgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2Nl
ZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxh
Z3MgPSBTQV9SRVNFVEhBTkQgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBI
YW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNTcKCnJ0X3NpZ2FjdGlvbjAxICAgIDAg
IElORk8gIDogIHNpZ25hbDogNTcgCnJ0X3NpZ2FjdGlvbjAxICAxMTggIFBBU1MgIDogIHJ0X3Np
Z2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAg
SU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0
aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51
bWJlciA1NwoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA1NyAKcnRfc2ln
YWN0aW9uMDEgIDExOSAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1
bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JF
U0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwg
SGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDU3CgpydF9zaWdhY3Rpb24wMSAgICAw
ICBJTkZPICA6ICBzaWduYWw6IDU3IApydF9zaWdhY3Rpb24wMSAgMTIwICBQQVNTICA6ICBydF9z
aWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAg
IElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfTk9NQVNLIApydF9zaWdhY3Rpb24wMSAgICAwICBJ
TkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDU3CgoKcnRf
c2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA1OCAKcnRfc2lnYWN0aW9uMDEgIDEy
MSAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9z
aWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9T
SUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxs
ZWQgd2l0aCBzaWduYWwgbnVtYmVyIDU4CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBz
aWduYWw6IDU4IApydF9zaWdhY3Rpb24wMSAgMTIyICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2Fs
bCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNh
LnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBT
aWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDU4CgpydF9zaWdhY3Rpb24w
MSAgICAwICBJTkZPICA6ICBzaWduYWw6IDU4IApydF9zaWdhY3Rpb24wMSAgMTIzICBQQVNTICA6
ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAx
ICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0
X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNp
Z25hbCBudW1iZXIgNTgKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNTgg
CnJ0X3NpZ2FjdGlvbjAxICAxMjQgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRl
ZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3Mg
PSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAg
U2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA1OAoKcnRfc2lnYWN0aW9u
MDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA1OCAKcnRfc2lnYWN0aW9uMDEgIDEyNSAgUEFTUyAg
OiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24w
MSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX05PTUFTSyAKcnRfc2lnYWN0aW9uMDEg
ICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA1
OAoKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNTkgCnJ0X3NpZ2FjdGlv
bjAxICAxMjYgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0g
MCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhB
TkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRs
ZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA1OQoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5G
TyAgOiAgc2lnbmFsOiA1OSAKcnRfc2lnYWN0aW9uMDEgIDEyNyAgUEFTUyAgOiAgcnRfc2lnYWN0
aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZP
ICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5G
TyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA1OQoKcnRfc2ln
YWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA1OSAKcnRfc2lnYWN0aW9uMDEgIDEyOCAg
UEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdh
Y3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJ
TkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQg
d2l0aCBzaWduYWwgbnVtYmVyIDU5CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWdu
YWw6IDU5IApydF9zaWdhY3Rpb24wMSAgMTI5ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBz
dWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNh
X2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElO
Rk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNTkKCnJ0X3Np
Z2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNTkgCnJ0X3NpZ2FjdGlvbjAxICAxMzAg
IFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2ln
YWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9OT01BU0sgCnJ0X3NpZ2Fj
dGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBu
dW1iZXIgNTkKCgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDYwIApydF9z
aWdhY3Rpb24wMSAgMTMxICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJl
c3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0Ff
UkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25h
bCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNjAKCnJ0X3NpZ2FjdGlvbjAxICAg
IDAgIElORk8gIDogIHNpZ25hbDogNjAgCnJ0X3NpZ2FjdGlvbjAxICAxMzIgIFBBU1MgIDogIHJ0
X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAg
MCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkQgCnJ0X3NpZ2FjdGlvbjAxICAg
IDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNjAK
CnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNjAgCnJ0X3NpZ2FjdGlvbjAx
ICAxMzMgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAK
cnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8
U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIg
Q2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA2MAoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAg
OiAgc2lnbmFsOiA2MCAKcnRfc2lnYWN0aW9uMDEgIDEzNCAgUEFTUyAgOiAgcnRfc2lnYWN0aW9u
IGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6
ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAg
ICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDYw
CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDYwIApydF9zaWdhY3Rpb24w
MSAgMTM1ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAg
CnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfTk9NQVNLIApy
dF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBz
aWduYWwgbnVtYmVyIDYwCgoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA2
MSAKcnRfc2lnYWN0aW9uMDEgIDEzNiAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2Vl
ZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFn
cyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6
ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDYxCgpydF9zaWdhY3Rp
b24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDYxIApydF9zaWdhY3Rpb24wMSAgMTM3ICBQQVNT
ICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlv
bjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EIApydF9zaWdhY3Rp
b24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVt
YmVyIDYxCgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDYxIApydF9zaWdh
Y3Rpb24wMSAgMTM4ICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3Vs
dCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVT
RVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBI
YW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNjEKCnJ0X3NpZ2FjdGlvbjAxICAgIDAg
IElORk8gIDogIHNpZ25hbDogNjEgCnJ0X3NpZ2FjdGlvbjAxICAxMzkgIFBBU1MgIDogIHJ0X3Np
Z2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAg
SU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0
aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51
bWJlciA2MQoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA2MSAKcnRfc2ln
YWN0aW9uMDEgIDE0MCAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1
bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX05P
TUFTSyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVk
IHdpdGggc2lnbmFsIG51bWJlciA2MQoKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNp
Z25hbDogNjIgCnJ0X3NpZ2FjdGlvbjAxICAxNDEgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxs
IHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Eu
c2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAg
SU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA2MgoKcnRf
c2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA2MiAKcnRfc2lnYWN0aW9uMDEgIDE0
MiAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9z
aWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORCAKcnRf
c2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2ln
bmFsIG51bWJlciA2MgoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA2MiAK
cnRfc2lnYWN0aW9uMDEgIDE0MyAgUEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVk
OiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9
IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBT
aWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDYyCgpydF9zaWdhY3Rpb24w
MSAgICAwICBJTkZPICA6ICBzaWduYWw6IDYyIApydF9zaWdhY3Rpb24wMSAgMTQ0ICBQQVNTICA6
ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAx
ICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0
X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNp
Z25hbCBudW1iZXIgNjIKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNjIg
CnJ0X3NpZ2FjdGlvbjAxICAxNDUgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRl
ZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3Mg
PSBTQV9OT01BU0sgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVy
IENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNjIKCgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZP
ICA6ICBzaWduYWw6IDYzIApydF9zaWdhY3Rpb24wMSAgMTQ2ICBQQVNTICA6ICBydF9zaWdhY3Rp
b24gY2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8g
IDogIHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAx
ICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIg
NjMKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNjMgCnJ0X3NpZ2FjdGlv
bjAxICAxNDcgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0g
MCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhB
TkQgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3
aXRoIHNpZ25hbCBudW1iZXIgNjMKCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25h
bDogNjMgCnJ0X3NpZ2FjdGlvbjAxICAxNDggIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1
Y2NlZWRlZDogcmVzdWx0ID0gMCAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2Ff
ZmxhZ3MgPSBTQV9SRVNFVEhBTkR8U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5G
TyAgOiAgU2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA2MwoKcnRfc2ln
YWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2lnbmFsOiA2MyAKcnRfc2lnYWN0aW9uMDEgIDE0OSAg
UEFTUyAgOiAgcnRfc2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdh
Y3Rpb24wMSAgICAwICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJ
TkZPIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQg
d2l0aCBzaWduYWwgbnVtYmVyIDYzCgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWdu
YWw6IDYzIApydF9zaWdhY3Rpb24wMSAgMTUwICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBz
dWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNh
X2ZsYWdzID0gU0FfTk9NQVNLIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwg
SGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDYzCgoKcnRfc2lnYWN0aW9uMDEgICAg
MCAgSU5GTyAgOiAgc2lnbmFsOiA2NCAKcnRfc2lnYWN0aW9uMDEgIDE1MSAgUEFTUyAgOiAgcnRf
c2lnYWN0aW9uIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAw
ICBJTkZPICA6ICBzYS5zYV9mbGFncyA9IFNBX1JFU0VUSEFORHxTQV9TSUdJTkZPIApydF9zaWdh
Y3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBDYWxsZWQgd2l0aCBzaWduYWwg
bnVtYmVyIDY0CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBzaWduYWw6IDY0IApydF9z
aWdhY3Rpb24wMSAgMTUyICBQQVNTICA6ICBydF9zaWdhY3Rpb24gY2FsbCBzdWNjZWVkZWQ6IHJl
c3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNhLnNhX2ZsYWdzID0gU0Ff
UkVTRVRIQU5EIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6ICBTaWduYWwgSGFuZGxlciBD
YWxsZWQgd2l0aCBzaWduYWwgbnVtYmVyIDY0CgpydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6
ICBzaWduYWw6IDY0IApydF9zaWdhY3Rpb24wMSAgMTUzICBQQVNTICA6ICBydF9zaWdhY3Rpb24g
Y2FsbCBzdWNjZWVkZWQ6IHJlc3VsdCA9IDAgCnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDog
IHNhLnNhX2ZsYWdzID0gU0FfUkVTRVRIQU5EfFNBX1NJR0lORk8gCnJ0X3NpZ2FjdGlvbjAxICAg
IDAgIElORk8gIDogIFNpZ25hbCBIYW5kbGVyIENhbGxlZCB3aXRoIHNpZ25hbCBudW1iZXIgNjQK
CnJ0X3NpZ2FjdGlvbjAxICAgIDAgIElORk8gIDogIHNpZ25hbDogNjQgCnJ0X3NpZ2FjdGlvbjAx
ICAxNTQgIFBBU1MgIDogIHJ0X3NpZ2FjdGlvbiBjYWxsIHN1Y2NlZWRlZDogcmVzdWx0ID0gMCAK
cnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgc2Euc2FfZmxhZ3MgPSBTQV9SRVNFVEhBTkR8
U0FfU0lHSU5GTyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAgU2lnbmFsIEhhbmRsZXIg
Q2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA2NAoKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAg
OiAgc2lnbmFsOiA2NCAKcnRfc2lnYWN0aW9uMDEgIDE1NSAgUEFTUyAgOiAgcnRfc2lnYWN0aW9u
IGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAwIApydF9zaWdhY3Rpb24wMSAgICAwICBJTkZPICA6
ICBzYS5zYV9mbGFncyA9IFNBX05PTUFTSyAKcnRfc2lnYWN0aW9uMDEgICAgMCAgSU5GTyAgOiAg
U2lnbmFsIEhhbmRsZXIgQ2FsbGVkIHdpdGggc2lnbmFsIG51bWJlciA2NAoKCg==
--00151750ea58e34dae046e20db91
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
--00151750ea58e34dae046e20db91
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--00151750ea58e34dae046e20db91--

