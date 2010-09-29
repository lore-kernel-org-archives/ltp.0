Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hannuxx@gmail.com>) id 1P10gP-0000Iq-Vk
	for ltp-list@lists.sourceforge.net; Wed, 29 Sep 2010 17:43:09 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P10gO-0001eS-H8
	for ltp-list@lists.sourceforge.net; Wed, 29 Sep 2010 17:43:09 +0000
Received: by bwz2 with SMTP id 2so1049793bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Sep 2010 10:43:02 -0700 (PDT)
Date: Wed, 29 Sep 2010 20:42:58 +0300
From: Hannu Heikkinen <hannuxx@iki.fi>
Message-ID: <20100929174258.GA4493@hannu-ubuntu>
References: <AANLkTinH_rH7iU4efFX8Bw9PUU_5DgMwR3q6p-bMZrOp@mail.gmail.com>
	<AANLkTin18VbZ7bO6++nPd_Fz1J4FHQRn4akkqTDLYeT5@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTin18VbZ7bO6++nPd_Fz1J4FHQRn4akkqTDLYeT5@mail.gmail.com>
Subject: Re: [LTP] LHOST_HWADDR
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
To: ARJIT SHARMA <joyarjit@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

Sorry about top posting, but I just briefly mention that please read 
<ltp-source-dir>/testcases/network/stress/README file. U have to setup values
for RHOST etc env vars found in testscripts/networkstress.sh.

br,
Hannu

On 28/09/10 10:09 +0530, ARJIT SHARMA wrote:
> Hi
> 
>      During the execution of network related tests i am getting the error as
> "environment variable LHOST_HWADDR not set"
>      i tried solving this problem even by given static hwaddr in the
> testscript "networkstress.sh" but same error is coming.
>      i am runnning LTP on armv7 architechture.
>      Here i am also sending you the log file, please help me out to solve
> this problem.
> 
> 
>                  INFO: creating /opt/ltp/results directory
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
> 
> Linux 192.168.1.10 2.6.32 #2 SMP Fri Aug 27 12:31:08 IST 2010 armv7l unknown
> unknown GNU/Linux
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
> free reports:
>              total       used       free     shared    buffers     cached
> Mem:        255556      24508     231048          0          0      14620
> -/+ buffers/cache:       9888     245668
> Swap:            0          0          0
> /proc/cpuinfo
> Processor : ARMv7 Processor rev 1 (v7l)
> processor : 0
> BogoMIPS : 996.14
> processor : 1
> BogoMIPS : 996.14
> Features : swp half thumb fastmult vfp edsp vfpv3 vfpv3d16
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant : 0x1
> CPU part : 0xc09
> CPU revision : 1
> Hardware : ST-SPEAR1300-EVB
> Revision : 0000
> Serial  : 0000000000000000
> remove test cases which require the block device.
> You can specify it with option -b
> COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 12621     -n 12621  -p  -f
> /tmp/ltp-isNlo12627/alltests -l
> /opt/ltp/results/network_stress.broken_ip.result  -C
> /opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed
> LOG File: /opt/ltp/results/network_stress.broken_ip.result
> FAILED COMMAND File:
> /opt/ltp/output/LTP_RUN_ON-network_stress.broken_ip.result.failed
> Running tests.......
> <<<test_start>>>
> tag=broken_ip4-version stime=351622598
> cmdline="broken_ip4-version"
> contacts=""
> analysis=exit
> <<<test_output>>>
> broken_ip4-version01    0  TINFO  :  Verify that the kernel is not crashed
> with receiving a large number of IPv4 packets that have wrong value in
> version field.
> broken_ip4-version01    1  TBROK  :  Environment variable LHOST_HWADDRS is
> not set.
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=3 cstime=10
> <<<test_end>>>
> <<<test_start>>>
> tag=broken_ip4-ihl stime=351622598
> cmdline="broken_ip4-ihl"
> contacts=""
> analysis=exit
> <<<test_output>>>
> broken_ip4-ihl01    0  TINFO  :  Verify that the kernel is not crashed with
> receiving a large number of IPv4 packets that have wrong value in the header
> length field.
> broken_ip4-ihl01    1  TBROK  :  Environment variable LHOST_HWADDRS is not
> set.
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=3 cstime=7
> <<<test_end>>>
> <<<test_start>>>
> tag=broken_ip4-totlen stime=351622598
> cmdline="broken_ip4-totlen"
> contacts=""
> analysis=exit
> <<<test_output>>>
> broken_ip4-totlen01    0  TINFO  :  Verify that the kernel is not crashed
> with receiving a large number of IPv4 packets that have wrong value in the
> total length field.
> broken_ip4-totlen01    1  TBROK  :  Environment variable LHOST_HWADDRS is
> not set.
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=7 cstime=5
> <<<test_end>>>
> <<<test_start>>>
> tag=broken_ip4-fragment stime=351622598
> cmdline="broken_ip4-fragment"
> contacts=""
> analysis=exit
> <<<test_output>>>
> broken_ip4-fragment01    0  TINFO  :  Verify that the kernel is not crashed
> with receiving a large number of IPv4 packets that have wrong fragment
> information
> broken_ip4-fragment01    1  TBROK  :  Environment variable LHOST_HWADDRS is
> not set.
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=2 cstime=13
> <<<test_end>>>
> <<<test_start>>>
> tag=broken_ip4-protcol stime=351622598
> cmdline="broken_ip4-protcol"
> contacts=""
> analysis=exit
> <<<test_output>>>
> broken_ip4-protocol01    0  TINFO  :  Verify that the kernel is not crashed
> with receiving a large number of IPv4 packets that have wrong value in the
> protocol field
> broken_ip4-protocol01    1  TBROK  :  Environment variable LHOST_HWADDRS is
> not set.
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=4 cstime=8
> <<<test_end>>>
> <<<test_start>>>
> tag=broken_ip4-checksum stime=351622598
> cmdline="broken_ip4-checksum"
> contacts=""
> analysis=exit
> <<<test_output>>>
> broken_ip4-checksum01    0  TINFO  :  Verify that the kernel is not crashed
> with receiving a large number of IPv4 packets that have wrong value in the
> checksum field
> broken_ip4-checksum01    1  TBROK  :  Environment variable LHOST_HWADDRS is
> not set.
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=5 cstime=7
> <<<test_end>>>
> <<<test_start>>>
> tag=broken_ip4-dstaddr stime=351622598
> cmdline="broken_ip4-dstaddr"
> contacts=""
> analysis=exit
> <<<test_output>>>
> broken_ip4-dstaddr01    0  TINFO  :  Verify that the kernel is not crashed
> with receiving a large number of IPv4 packets whose destination address is
> wrong (destination MAC address is correct)
> broken_ip4-dstaddr01    1  TBROK  :  Environment variable LHOST_HWADDRS is
> not set.
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=1 corefile=no
> cutime=3 cstime=9
> <<<test_end>>>
> <<<test_start>>>
> tag=broken_ip6-dstaddr stime=351622599
> cmdline="broken_ip6-dstaddr"
> contacts=""
> analysis=exit
> <<<test_output>>>
> broken_ip6-dstaddr01    0  TINFO  :  Verify that the kernel is not crashed
> with receiving a large number of IPv6 packets whose destination address is
> wrong (destination MAC address is correct)
> broken_ip6-dstaddr01    1  TBROK  :  Environment variable LHOST_HWADDRS is
> not set.
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=1 cstime=12
> <<<test_end>>>
> <<<test_start>>>
> tag=broken_ip6-nexthdr stime=351622599
> cmdline="broken_ip6-nexthdr"
> contacts=""
> analysis=exit
> <<<test_output>>>
> broken_ip6-nexthdr01    0  TINFO  :  Verify that the kernel is not crashed
> with receiving a large number of IPv6 packets that have wrong value in the
> next header field.
> broken_ip6-nexthdr01    1  TBROK  :  Environment variable LHOST_HWADDRS is
> not set.
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=7 cstime=7
> <<<test_end>>>
> <<<test_start>>>
> tag=broken_ip6-plen stime=351622599
> cmdline="broken_ip6-plen"
> contacts=""
> analysis=exit
> <<<test_output>>>
> broken_ip6-plen01    0  TINFO  :  Verify that the kernel is not crashed with
> receiving a large number of IPv6 packets that have wrong value in the
> payload length field.
> broken_ip6-plen01    1  TBROK  :  Environment variable LHOST_HWADDRS is not
> set.
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=2 cstime=9
> <<<test_end>>>
> <<<test_start>>>
> tag=broken_ip6-version stime=351622599
> cmdline="broken_ip6-version"
> contacts=""
> analysis=exit
> <<<test_output>>>
> broken_ip6-version01    0  TINFO  :  Verify that the kernel is not crashed
> with receiving a large number of IPv6 packets that have wrong value in
> version field.
> broken_ip6-version01    1  TBROK  :  Environment variable LHOST_HWADDRS is
> not set.
> incrementing stop
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=3 cstime=7
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: LTP-20100131
> 
>        ###############################################################"
> 
>             Done executing testcases."
>             LTP Version:  LTP-20100131
>        ###############################################################"
> 
> 
> 
> 
> -- 
> Regards,
> Arjit Sharma.

> ------------------------------------------------------------------------------
> Start uncovering the many advantages of virtual appliances
> and start using them to simplify application deployment and
> accelerate your shift to cloud computing.
> http://p.sf.net/sfu/novell-sfdev2dev

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
