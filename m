Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1UDX6P-0001Te-Qt
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 09:27:05 +0000
Received: from mail-wi0-f170.google.com ([209.85.212.170])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UDX6M-0000MR-2G
	for ltp-list@lists.sourceforge.net; Thu, 07 Mar 2013 09:27:05 +0000
Received: by mail-wi0-f170.google.com with SMTP id hm11so3377411wib.1
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Mar 2013 01:26:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <loom.20130307T053207-617@post.gmane.org>
References: <51237A44.6080508@mpi-sws.org>
	<loom.20130307T053207-617@post.gmane.org>
Date: Thu, 7 Mar 2013 10:26:55 +0100
Message-ID: <CA+icZUX7dHp0P7=Pr_4d9r7a=pBGnQnjUNh_sCSH0nm=9UQYVg@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [LTP] Building LTP in a 64-bit machine for 32-bit target
Reply-To: sedat.dilek@gmail.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Shashi <shashi859@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Pedro Fonseca <pfonseca@mpi-sws.org>

On Thu, Mar 7, 2013 at 9:51 AM, Shashi <shashi859@gmail.com> wrote:
> Pedro Fonseca <pfonseca@...> writes:
>
>>
>> Hi,
>>
>> I've been trying to cross compile LTP on a 64-bit x86 machine to produce
>> tests for a 32-bit x86 machines. Unfortunately, so far I haven't found a
>> clean way of achieving this.
>>
>> I've tried configuring with "./configure --host=i386" but this still
>> produces x86-64 binaries.
>>
>> I've also tried configuring with "CFLAGS=-m32 ./configure CFLAGS=-m32"
>> but it gives compilation errors on some tests (e.g.
>> testcases/kernel/syscalls/chown01_16). I can get past some of the errors
>> by disabling the "/../utils/compat_16.mk" lines in the individual test
>> Makefiles. But is there a better way to compile LTP for 32-bit on a 64-bit?
>>
>> Thanks,
>> Pedro
>>
>> ------------------------------------------------------------------------------
>> Everyone hates slow websites. So do we.
>> Make your web apps faster with AppDynamics
>> Download AppDynamics Lite for free today:
>> http://p.sf.net/sfu/appdyn_d2d_feb
>>
>
> Hello Pedra Fonseca,
>
> ./configure --build=i686-pc-linux-gnu --target=i686-pc-linux-gnu "CFLAGS=-m32"
> "CPPFLAGS=-m32" "LDFLAGS=-m32"
>
> I use the above command to build ltp for 32-bit architecture on 64-bit machine.
> Once you do run this, you can check the CFLAGS, CPPFLAGS, LDFALGS being set in
> config.status file. --target flag is to set target environment if it is
> different from build environment.
> http://stackoverflow.com/questions/5139403/whats-the-difference-of-configure-option-build-host-and-target
>
> In fedora-64 bit, to build a 32-bit binary you need following packages
> sudo yum install glibc-devel.i686 libgcc.i686
>
> May be in Ubuntu, you may need these packages or similar kind. If not installed
> gcc will throw some error. Let me know if you still find problem.
>
> Regards,
> ShashiKiran
>

[ CC Pedro ]

AFAICS "-m32" is available on gcc, dunno if for example clang supports
that, too.

Can't say if "-m32" as LDFLAGS makes any sense or to say IOW "-m32"
for CC is sufficient.
Maybe you can explain that, Shashi?

To support "-m32" CFLAGS for gcc on Debian/Ubuntu you need to install
'gcc-multilib' (gcc with biarch-support) package.
This installs 'libc6-i386' and 'libc6-i386-dev' packages automatically.

     $ sudo apt-get update
     $ sudo apt-get install gcc-multilib

Another way could be to install multiarch-support if not available
(binutils-mutiarch and multiarch-support packages).
But I should check Debian's/Ubuntu's wiki pages, again... how to build
on amd64 for i386...

Hope this helps people reading this ML.

Regards,
- Sedat -

>
>
>
> ------------------------------------------------------------------------------
> Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester
> Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the
> endpoint security space. For insight on selecting the right partner to
> tackle endpoint security challenges, access the full report.
> http://p.sf.net/sfu/symantec-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
