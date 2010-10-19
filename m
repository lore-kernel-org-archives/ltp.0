Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ext-hannu.m.heikkinen@nokia.com>) id 1P889G-0006S2-Mk
	for ltp-list@lists.sourceforge.net; Tue, 19 Oct 2010 09:06:22 +0000
Received: from smtp.nokia.com ([147.243.1.47] helo=mgw-sa01.nokia.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P889E-0001Pe-T8
	for ltp-list@lists.sourceforge.net; Tue, 19 Oct 2010 09:06:22 +0000
Date: Tue, 19 Oct 2010 12:00:41 +0000
From: Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
Message-ID: <20101019120040.GA6687@hannu-debian.research.nokia.com>
References: <AANLkTinU5f4fco7BGZ0GiQoWVZNtGam7xZaT6gYTspML@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTinU5f4fco7BGZ0GiQoWVZNtGam7xZaT6gYTspML@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ext ARJIT SHARMA <joyarjit@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 18/10/10 08:56 +0200, ext ARJIT SHARMA wrote:
> 
> Hi
> 
> 
>       this is the log of PTY testcase i am getting...
> 
>       all 3 tests ie. "pty01,ptem01 and hangup01"
> 
>       failing because ptsname() function call failed.....
> 
> 
> 
> INFO: creating /opt/ltp/results directory
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> 
> Linux 192.168.1.10 2.6.32 #1 SMP Fri Oct 8 16:13:17 IST 2010 armv7l unknown unknown GNU/Linux
> 
> Gnu C                  gcc (GCC) 4.5.0
> Gnu make               3.81
> util-linux             ng 2.16.1)
> mount                  ng 2.16.1 (with libblkid support)
> modutils               3.1
> e2fsprogs              1.41.9
> PPP                    2.4.4
> Linux C Library        2.10.1
> Dynamic linker (ldd)   2.10.1
> Linux C++ Library      6.0.14
> Procps                 3.2.7
> Net-tools              1.60
> iproute2              iproute2-ss100224
> Console-tools          0.2.3
> Sh-utils               5.2.1
> Modules Loaded
> 
> free reports:
>              total       used       free     shared    buffers     cached
> Mem:        255252      28548     226704          0          0      18124
> -/+ buffers/cache:      10424     244828
> Swap:            0          0          0
> 
> /proc/cpuinfo
> Processor              : ARMv7 Processor rev 1 (v7l)
> processor              : 0
> BogoMIPS            : 996.14
> 
> processor              : 1
> BogoMIPS            : 996.14
> 
> Features : swp half thumb fastmult vfp edsp vfpv3 vfpv3d16
> CPU implementer  : 0x41
> CPU architecture: 7
> CPU variant           : 0x1
> CPU part                : 0xc09
> CPU revision         : 1
> 
> Hardware               : ST-SPEAR1300-EVB
> Revision                : 0000
> Serial                      : 0000000000000000

-clip-
> <<<test_output>>>
> pty01       1  TBROK  :  ptsname() call failed
-clip-
> ptem01      1  TBROK  :  ptsname() call failed
-clip-
> hangup01    1  TBROK  :  ptsname
-clip-

I guess u should run:

# strace -f <testcase-bin>

for having more detailed info regarding problem.

What does 
# cat /proc/sys/kernel/pty/max
say? If it is utterly small value, let's say 2..8, change it to eg:
# echo 100 > /proc/sys/kernel/pty/max

br,
Hannu

------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
