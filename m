Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P88Ev-0004qC-AC
	for ltp-list@lists.sourceforge.net; Tue, 19 Oct 2010 09:12:13 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P88Eu-0006bU-GS
	for ltp-list@lists.sourceforge.net; Tue, 19 Oct 2010 09:12:13 +0000
Received: by gwb17 with SMTP id 17so1129239gwb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 19 Oct 2010 02:12:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20101019120040.GA6687@hannu-debian.research.nokia.com>
References: <AANLkTinU5f4fco7BGZ0GiQoWVZNtGam7xZaT6gYTspML@mail.gmail.com>
	<20101019120040.GA6687@hannu-debian.research.nokia.com>
Date: Tue, 19 Oct 2010 02:12:06 -0700
Message-ID: <AANLkTi=m7BBJUb_nA8myRr9xag5E0H6z5iETjhidZxOB@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] PTY
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
To: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Tue, Oct 19, 2010 at 5:00 AM, Hannu Heikkinen
<ext-hannu.m.heikkinen@nokia.com> wrote:
> On 18/10/10 08:56 +0200, ext ARJIT SHARMA wrote:
>>
>> Hi
>>
>>
>> =A0 =A0 =A0 this is the log of PTY testcase i am getting...
>>
>> =A0 =A0 =A0 all 3 tests ie. "pty01,ptem01 and hangup01"
>>
>> =A0 =A0 =A0 failing because ptsname() function call failed.....
>>
>>
>>
>> INFO: creating /opt/ltp/results directory
>> If some fields are empty or look unusual you may have an old version.
>> Compare to the current minimal requirements in Documentation/Changes.
>>
>> Linux 192.168.1.10 2.6.32 #1 SMP Fri Oct 8 16:13:17 IST 2010 armv7l unkn=
own unknown GNU/Linux
>>
>> Gnu C =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gcc (GCC) 4.5.0
>> Gnu make =A0 =A0 =A0 =A0 =A0 =A0 =A0 3.81
>> util-linux =A0 =A0 =A0 =A0 =A0 =A0 ng 2.16.1)
>> mount =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ng 2.16.1 (with libblkid suppor=
t)
>> modutils =A0 =A0 =A0 =A0 =A0 =A0 =A0 3.1
>> e2fsprogs =A0 =A0 =A0 =A0 =A0 =A0 =A01.41.9
>> PPP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02.4.4
>> Linux C Library =A0 =A0 =A0 =A02.10.1
>> Dynamic linker (ldd) =A0 2.10.1
>> Linux C++ Library =A0 =A0 =A06.0.14
>> Procps =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3.2.7
>> Net-tools =A0 =A0 =A0 =A0 =A0 =A0 =A01.60
>> iproute2 =A0 =A0 =A0 =A0 =A0 =A0 =A0iproute2-ss100224
>> Console-tools =A0 =A0 =A0 =A0 =A00.2.3
>> Sh-utils =A0 =A0 =A0 =A0 =A0 =A0 =A0 5.2.1
>> Modules Loaded
>>
>> free reports:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0total =A0 =A0 =A0 used =A0 =A0 =A0 free =A0 =
=A0 shared =A0 =A0buffers =A0 =A0 cached
>> Mem: =A0 =A0 =A0 =A0255252 =A0 =A0 =A028548 =A0 =A0 226704 =A0 =A0 =A0 =
=A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A018124
>> -/+ buffers/cache: =A0 =A0 =A010424 =A0 =A0 244828
>> Swap: =A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A0 =A00
>>
>> /proc/cpuinfo
>> Processor =A0 =A0 =A0 =A0 =A0 =A0 =A0: ARMv7 Processor rev 1 (v7l)
>> processor =A0 =A0 =A0 =A0 =A0 =A0 =A0: 0
>> BogoMIPS =A0 =A0 =A0 =A0 =A0 =A0: 996.14
>>
>> processor =A0 =A0 =A0 =A0 =A0 =A0 =A0: 1
>> BogoMIPS =A0 =A0 =A0 =A0 =A0 =A0: 996.14
>>
>> Features : swp half thumb fastmult vfp edsp vfpv3 vfpv3d16
>> CPU implementer =A0: 0x41
>> CPU architecture: 7
>> CPU variant =A0 =A0 =A0 =A0 =A0 : 0x1
>> CPU part =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: 0xc09
>> CPU revision =A0 =A0 =A0 =A0 : 1
>>
>> Hardware =A0 =A0 =A0 =A0 =A0 =A0 =A0 : ST-SPEAR1300-EVB
>> Revision =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: 0000
>> Serial =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: 0000000000000000
>
> -clip-
>> <<<test_output>>>
>> pty01 =A0 =A0 =A0 1 =A0TBROK =A0: =A0ptsname() call failed
> -clip-
>> ptem01 =A0 =A0 =A01 =A0TBROK =A0: =A0ptsname() call failed
> -clip-
>> hangup01 =A0 =A01 =A0TBROK =A0: =A0ptsname
> -clip-
>
> I guess u should run:
>
> # strace -f <testcase-bin>
>
> for having more detailed info regarding problem.
>
> What does
> # cat /proc/sys/kernel/pty/max
> say? If it is utterly small value, let's say 2..8, change it to eg:
> # echo 100 > /proc/sys/kernel/pty/max

Please try with the latest sources; the diagnostic messages should be
considerably better now.
-Garrett

---------------------------------------------------------------------------=
---
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly =

Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
