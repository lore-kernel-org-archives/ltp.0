Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vpuliyal@in.ibm.com>) id 1ZL9Uk-0005q1-TQ
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2015 12:33:02 +0000
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZL9Ui-0001ne-7o
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2015 12:33:02 +0000
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <vpuliyal@in.ibm.com>;
	Fri, 31 Jul 2015 18:02:52 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id BF3F33940065
	for <Ltp-list@lists.sourceforge.net>;
	Fri, 31 Jul 2015 18:02:48 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	t6VCWWZI15401002
	for <Ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2015 18:02:47 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	t6VCUSo7016502
	for <Ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2015 18:00:28 +0530
Received: from d23ml206.in.ibm.com (d23ml206.in.ibm.com [9.182.109.28])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	t6VCUQNG016220
	for <Ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2015 18:00:27 +0530
In-Reply-To: <OF6BBCEC9B.330C6BB2-ON65257E93.002CF6C5-65257E93.002D2260@LocalDomain>
References: <OF6BBCEC9B.330C6BB2-ON65257E93.002CF6C5-65257E93.002D2260@LocalDomain>
MIME-Version: 1.0
Message-ID: <OF0F172505.DD831613-ON65257E93.0044AA23-65257E93.0044B25F@in.ibm.com>
From: Vijay K Puliyala <vpuliyal@in.ibm.com>
Date: Fri, 31 Jul 2015 18:00:21 +0530
Subject: Re: [LTP] : Test Cases for libnuma
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5245271392201283968=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Ltp-list@lists.sourceforge.net

This is a multipart message in MIME format.
--===============5245271392201283968==
Content-Type: multipart/alternative;
	boundary="=_alternative 0044B25E65257E93_="

This is a multipart message in MIME format.
--=_alternative 0044B25E65257E93_=
Content-Type: text/plain; charset="US-ASCII"

Hi,

Below output is for  " /opt/ltp/runltp   -f numa "  command . Please 
correct me if I have done any mistake. 
_______________________________________________________________________________________________________

SUSE Linux Enterprise Server 11 (ppc64)
VERSION = 11
PATCHLEVEL = 4
LSB_VERSION="core-2.0-noarch:core-3.2-noarch:core-4.0-noarch:core-2.0-ppc64:core-3.2-ppc64:core-4.0-ppc64"
NAME="SLES"
VERSION="11.4"
VERSION_ID="11.4"
PRETTY_NAME="SUSE Linux Enterprise Server 11 SP4"
ID="sles"
ANSI_COLOR="0;32"
CPE_NAME="cpe:/o:suse:sles:11:4"
Linux perf2877 3.0.101-63-ppc64 #1 SMP Tue Jun 23 16:02:31 UTC 2015 
(4b89d0c) ppc64 ppc64 ppc64 GNU/Linux

Gnu C                  gcc (SUSE Linux) 4.3.4 [gcc-4_3-branch revision 
152973]
Gnu make               3.81
util-linux             linux 2.19.1)
mount                  linux 2.19.1 (with libblkid and selinux support)
modutils               3.11.1
e2fsprogs              1.41.9
PPP                    2.4.5
Linux C Library        2.11.3
Dynamic linker (ldd)   2.11.3
Procps                 3.2.7
Net-tools              1.60
iproute2              iproute2-ss111010
Kbd                    1.14.1
Sh-utils               8.12
Modules Loaded         veth nls_utf8 quota_v2 quota_tree ext4 jbd2 crc16 
tun ext2 iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi st sr_mod 
ide_cd_mod cdrom lp parport ip6t_REJECT ip6t_LOG nf_conntrack_ipv6 
nf_defrag_ipv6 ip6table_raw xt_NOTRACK ipt_REJECT xt_tcpudp xt_pkttype 
ipt_LOG xt_limit iptable_raw iptable_filter ip6table_mangle 
nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_ipv4 
nf_defrag_ipv4 ip_tables xt_conntrack nf_conntrack ip6table_filter 
ip6_tables x_tables nfs fscache lockd auth_rpcgss nfs_acl sunrpc joydev 
fuse loop dm_mod be2net ipv6 ipv6_lib nx_crypto ses enclosure sg tg3 ptp 
pps_core hwmon ext3 jbd mbcache xhci_hcd qla2xxx usbcore sd_mod usb_common 
scsi_dh_alua scsi_dh_rdac scsi_dh_hp_sw scsi_dh_emc scsi_dh ipr libata 
lpfc scsi_transport_fc scsi_tgt scsi_mod crc_t10dif

timebase        : 512000000
platform        : pSeries
model           : IBM,9119-MHE
machine         : CHRP IBM,9119-MHE
no big block device was specified on commandline.
Tests which require a big block device are disabled.
You can specify it with option -z
COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 44349     -n 44349  -p  -f 
/tmp/ltp-evDbdcD9WK/alltests -l 
/opt/ltp/results/LTP_RUN_ON-2015_07_30-11h_38m_21s.log  -C 
/opt/ltp/output/LTP_RUN_ON-2015_07_30-11h_38m_21s.failed -T 
/opt/ltp/output/LTP_RUN_ON-2015_07_30-11h_38m_21s.tconf
LOG File: /opt/ltp/results/LTP_RUN_ON-2015_07_30-11h_38m_21s.log
FAILED COMMAND File: 
/opt/ltp/output/LTP_RUN_ON-2015_07_30-11h_38m_21s.failed
TCONF COMMAND File: 
/opt/ltp/output/LTP_RUN_ON-2015_07_30-11h_38m_21s.tconf
Running tests.......
<<<test_start>>>
tag=Numa-testcases stime=1438270702
cmdline="numa01.sh"
contacts=""
analysis=exit
<<<test_output>>>
Initnuma    0  TINFO  :  INIT: Numa tests will start now !!
Initnuma    0  TINFO  :  The system contains 1 nodes:  6
Initnuma    1  TCONF  :  ltpapicmd.c:190: your machine does not support 
numa policy or
                        your machine is not a NUMA machine
exitnuma    0  TINFO  :  CLEAN: removing 
/tmp/ltp-evDbdcD9WK/tst_numa.44465
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=move_pages01 stime=1438270702
cmdline="move_pages.sh 01"
contacts=""
analysis=exit
<<<test_output>>>
move_pages01    1  TCONF  :  move_pages_support.c:412: NUMA support not 
provided
move_pages01    2  TCONF  :  move_pages_support.c:412: Remaining cases not 
appropriate for configuration
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=move_pages02 stime=1438270702
cmdline="move_pages.sh 02"
contacts=""
analysis=exit
<<<test_output>>>
move_pages02    1  TCONF  :  move_pages_support.c:412: NUMA support not 
provided
move_pages02    2  TCONF  :  move_pages_support.c:412: Remaining cases not 
appropriate for configuration
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=move_pages03 stime=1438270702
cmdline="cd $LTPROOT/testcases/bin && chown root move_pages03 && chmod 
04755 move_pages03 && move_pages.sh 03"
contacts=""
analysis=exit
<<<test_output>>>
move_pages03    1  TCONF  :  move_pages_support.c:412: NUMA support not 
provided
move_pages03    2  TCONF  :  move_pages_support.c:412: Remaining cases not 
appropriate for configuration
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=1 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=move_pages04 stime=1438270702
cmdline="move_pages.sh 04"
contacts=""
analysis=exit
<<<test_output>>>
move_pages04    1  TCONF  :  move_pages_support.c:412: NUMA support not 
provided
move_pages04    2  TCONF  :  move_pages_support.c:412: Remaining cases not 
appropriate for configuration
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=move_pages05 stime=1438270702
cmdline="move_pages.sh 05"
contacts=""
analysis=exit
<<<test_output>>>
move_pages05    1  TCONF  :  move_pages_support.c:412: NUMA support not 
provided
move_pages05    2  TCONF  :  move_pages_support.c:412: Remaining cases not 
appropriate for configuration
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=move_pages06 stime=1438270702
cmdline="move_pages.sh 06"
contacts=""
analysis=exit
<<<test_output>>>
move_pages06    1  TCONF  :  move_pages_support.c:412: NUMA support not 
provided
move_pages06    2  TCONF  :  move_pages_support.c:412: Remaining cases not 
appropriate for configuration
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=move_pages07 stime=1438270702
cmdline="move_pages.sh 07"
contacts=""
analysis=exit
<<<test_output>>>
move_pages07    1  TCONF  :  move_pages_support.c:412: NUMA support not 
provided
move_pages07    2  TCONF  :  move_pages_support.c:412: Remaining cases not 
appropriate for configuration
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=move_pages08 stime=1438270702
cmdline="move_pages.sh 08"
contacts=""
analysis=exit
<<<test_output>>>
move_pages08    1  TCONF  :  move_pages08.c:138: move_pages: E2BIG was 
removed in commit 3140a227
move_pages08    2  TCONF  :  move_pages08.c:138: Remaining cases not 
appropriate for configuration
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=move_pages09 stime=1438270702
cmdline="move_pages.sh 09"
contacts=""
analysis=exit
<<<test_output>>>
move_pages09    1  TCONF  :  move_pages_support.c:412: NUMA support not 
provided
move_pages09    2  TCONF  :  move_pages_support.c:412: Remaining cases not 
appropriate for configuration
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=move_pages10 stime=1438270702
cmdline="move_pages.sh 10"
contacts=""
analysis=exit
<<<test_output>>>
move_pages10    1  TCONF  :  move_pages_support.c:412: NUMA support not 
provided
move_pages10    2  TCONF  :  move_pages_support.c:412: Remaining cases not 
appropriate for configuration
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=move_pages11 stime=1438270702
cmdline="cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod 
04755 move_pages11 && move_pages.sh 11"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
move_pages11    1  TCONF  :  move_pages_support.c:412: NUMA support not 
provided
move_pages11    2  TCONF  :  move_pages_support.c:412: Remaining cases not 
appropriate for configuration
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: 20150420

       ###############################################################

            Done executing testcases.
            LTP Version:  20150420
       ###############################################################

perf2877:~ #

Thanks
Vijay Kumar



From:   Vijay K Puliyala/India/IBM
To:     Ltp-list@lists.sourceforge.net
Date:   07/31/2015 01:42 PM
Subject:        Re: [LTP] : Test Cases for libnuma


Hi,

I have installed LTP on SUSE.  I want to run numa testcases.  I have done 
below steps to run numa.

_______________________________________________________________________

perf2877:/vijay/NUMA/ltp-full-20150420 # ./runltp -f numa
FATAL: LTP not installed correctly
INFO:  Follow directions in INSTALL!

______________________________________________________________________

perf2877:/vijay/NUMA/ltp-full-20150420 # /opt/ltp/runltp -f numa

<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=move_pages11 stime=1438256071
cmdline="cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod 
04755 move_pages11 && move_pages.sh 11"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
move_pages11    1  TCONF  :  move_pages_support.c:412: NUMA support not 
provided
move_pages11    2  TCONF  :  move_pages_support.c:412: Remaining cases not 
appropriate for configuration
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20150420

       ###############################################################

            Done executing testcases.
            LTP Version:  20150420
       ###############################################################


But if I run only  "/opt/ltp/runltp" with out any options or with out " -f 
numa " option  it is giving results.
____________________________________________________________________________
If I run numa01.sh I am getting below errors.
perf2877:/vijay/NUMA/ltp-full-20150420/testcases/kernel/numa # ./numa01.sh
./numa01.sh: line 66: tst_brkm: command not found
./numa01.sh: line 784: tst_resm: command not found
./numa01.sh: line 215: tst_resm: command not found
___________________________________________________________________


Please correct me if I have done any mistake. 

I have installed  below packages 

perf2877:/opt/ltp # rpm -q libnuma-devel
libnuma-devel-2.0.9-5.1.1
perf2877:/opt/ltp # rpm -q libnuma1
libnuma1-2.0.9-5.1.1
perf2877:/opt/ltp # rpm -q libnuma-devel
libnuma-devel-2.0.9-5.1.1
perf2877:/opt/ltp # rpm -q autoconf
autoconf-2.69-9.3
perf2877:/opt/ltp # rpm -q automake
automake-1.10.1-4.131.9.1
perf2877:/opt/ltp #

Also please add me in mailing list.


Thanks
Vijay Kumar

--=_alternative 0044B25E65257E93_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">Below output is for &nbsp;&quot;<b>
/opt/ltp/runltp &nbsp; -f numa</b> &quot; &nbsp;command . Please correct
me if I have done any mistake. </font>
<br><font size=2 face="sans-serif">_______________________________________________________________________________________________________</font>
<br>
<br><font size=2 face="sans-serif">SUSE Linux Enterprise Server 11 (ppc64)</font>
<br><font size=2 face="sans-serif">VERSION = 11</font>
<br><font size=2 face="sans-serif">PATCHLEVEL = 4</font>
<br><font size=2 face="sans-serif">LSB_VERSION=&quot;core-2.0-noarch:core-3.2-noarch:core-4.0-noarch:core-2.0-ppc64:core-3.2-ppc64:core-4.0-ppc64&quot;</font>
<br><font size=2 face="sans-serif">NAME=&quot;SLES&quot;</font>
<br><font size=2 face="sans-serif">VERSION=&quot;11.4&quot;</font>
<br><font size=2 face="sans-serif">VERSION_ID=&quot;11.4&quot;</font>
<br><font size=2 face="sans-serif">PRETTY_NAME=&quot;SUSE Linux Enterprise
Server 11 SP4&quot;</font>
<br><font size=2 face="sans-serif">ID=&quot;sles&quot;</font>
<br><font size=2 face="sans-serif">ANSI_COLOR=&quot;0;32&quot;</font>
<br><font size=2 face="sans-serif">CPE_NAME=&quot;cpe:/o:suse:sles:11:4&quot;</font>
<br><font size=2 face="sans-serif">Linux perf2877 3.0.101-63-ppc64 #1 SMP
Tue Jun 23 16:02:31 UTC 2015 (4b89d0c) ppc64 ppc64 ppc64 GNU/Linux</font>
<br>
<br><font size=2 face="sans-serif">Gnu C &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;gcc (SUSE Linux) 4.3.4 [gcc-4_3-branch revision
152973]</font>
<br><font size=2 face="sans-serif">Gnu make &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; 3.81</font>
<br><font size=2 face="sans-serif">util-linux &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; linux 2.19.1)</font>
<br><font size=2 face="sans-serif">mount &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;linux 2.19.1 (with libblkid and selinux support)</font>
<br><font size=2 face="sans-serif">modutils &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; 3.11.1</font>
<br><font size=2 face="sans-serif">e2fsprogs &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;1.41.9</font>
<br><font size=2 face="sans-serif">PPP &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2.4.5</font>
<br><font size=2 face="sans-serif">Linux C Library &nbsp; &nbsp; &nbsp;
&nbsp;2.11.3</font>
<br><font size=2 face="sans-serif">Dynamic linker (ldd) &nbsp; 2.11.3</font>
<br><font size=2 face="sans-serif">Procps &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; 3.2.7</font>
<br><font size=2 face="sans-serif">Net-tools &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;1.60</font>
<br><font size=2 face="sans-serif">iproute2 &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;iproute2-ss111010</font>
<br><font size=2 face="sans-serif">Kbd &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1.14.1</font>
<br><font size=2 face="sans-serif">Sh-utils &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; 8.12</font>
<br><font size=2 face="sans-serif">Modules Loaded &nbsp; &nbsp; &nbsp;
&nbsp; veth nls_utf8 quota_v2 quota_tree ext4 jbd2 crc16 tun ext2 iscsi_tcp
libiscsi_tcp libiscsi scsi_transport_iscsi st sr_mod ide_cd_mod cdrom lp
parport ip6t_REJECT ip6t_LOG nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_raw
xt_NOTRACK ipt_REJECT xt_tcpudp xt_pkttype ipt_LOG xt_limit iptable_raw
iptable_filter ip6table_mangle nf_conntrack_netbios_ns nf_conntrack_broadcast
nf_conntrack_ipv4 nf_defrag_ipv4 ip_tables xt_conntrack nf_conntrack ip6table_filter
ip6_tables x_tables nfs fscache lockd auth_rpcgss nfs_acl sunrpc joydev
fuse loop dm_mod be2net ipv6 ipv6_lib nx_crypto ses enclosure sg tg3 ptp
pps_core hwmon ext3 jbd mbcache xhci_hcd qla2xxx usbcore sd_mod usb_common
scsi_dh_alua scsi_dh_rdac scsi_dh_hp_sw scsi_dh_emc scsi_dh ipr libata
lpfc scsi_transport_fc scsi_tgt scsi_mod crc_t10dif</font>
<br>
<br><font size=2 face="sans-serif">timebase &nbsp; &nbsp; &nbsp; &nbsp;:
512000000</font>
<br><font size=2 face="sans-serif">platform &nbsp; &nbsp; &nbsp; &nbsp;:
pSeries</font>
<br><font size=2 face="sans-serif">model &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
: IBM,9119-MHE</font>
<br><font size=2 face="sans-serif">machine &nbsp; &nbsp; &nbsp; &nbsp;
: CHRP IBM,9119-MHE</font>
<br><font size=2 face="sans-serif">no big block device was specified on
commandline.</font>
<br><font size=2 face="sans-serif">Tests which require a big block device
are disabled.</font>
<br><font size=2 face="sans-serif">You can specify it with option -z</font>
<br><font size=2 face="sans-serif">COMMAND: &nbsp; &nbsp;/opt/ltp/bin/ltp-pan
&nbsp;-e -S &nbsp; -a 44349 &nbsp; &nbsp; -n 44349 &nbsp;-p &nbsp;-f /tmp/ltp-evDbdcD9WK/alltests
-l /opt/ltp/results/LTP_RUN_ON-2015_07_30-11h_38m_21s.log &nbsp;-C /opt/ltp/output/LTP_RUN_ON-2015_07_30-11h_38m_21s.failed
-T /opt/ltp/output/LTP_RUN_ON-2015_07_30-11h_38m_21s.tconf</font>
<br><font size=2 face="sans-serif">LOG File: /opt/ltp/results/LTP_RUN_ON-2015_07_30-11h_38m_21s.log</font>
<br><font size=2 face="sans-serif">FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2015_07_30-11h_38m_21s.failed</font>
<br><font size=2 face="sans-serif">TCONF COMMAND File: /opt/ltp/output/LTP_RUN_ON-2015_07_30-11h_38m_21s.tconf</font>
<br><font size=2 face="sans-serif">Running tests.......</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=Numa-testcases stime=1438270702</font>
<br><font size=2 face="sans-serif">cmdline=&quot;numa01.sh&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">Initnuma &nbsp; &nbsp;0 &nbsp;TINFO
&nbsp;: &nbsp;INIT: Numa tests will start now !!</font>
<br><font size=2 face="sans-serif">Initnuma &nbsp; &nbsp;0 &nbsp;TINFO
&nbsp;: &nbsp;The system contains 1 nodes: &nbsp;6</font>
<br><font size=2 face="sans-serif">Initnuma &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: &nbsp;ltpapicmd.c:190: your machine does not support numa policy
or</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; your machine is not a NUMA machine</font>
<br><font size=2 face="sans-serif">exitnuma &nbsp; &nbsp;0 &nbsp;TINFO
&nbsp;: &nbsp;CLEAN: removing /tmp/ltp-evDbdcD9WK/tst_numa.44465</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=0
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=move_pages01 stime=1438270702</font>
<br><font size=2 face="sans-serif">cmdline=&quot;move_pages.sh 01&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">move_pages01 &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: NUMA support not provided</font>
<br><font size=2 face="sans-serif">move_pages01 &nbsp; &nbsp;2 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: Remaining cases not appropriate
for configuration</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=move_pages02 stime=1438270702</font>
<br><font size=2 face="sans-serif">cmdline=&quot;move_pages.sh 02&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">move_pages02 &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: NUMA support not provided</font>
<br><font size=2 face="sans-serif">move_pages02 &nbsp; &nbsp;2 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: Remaining cases not appropriate
for configuration</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=1</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=move_pages03 stime=1438270702</font>
<br><font size=2 face="sans-serif">cmdline=&quot;cd $LTPROOT/testcases/bin
&amp;&amp; chown root move_pages03 &amp;&amp; chmod 04755 move_pages03
&amp;&amp; move_pages.sh 03&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">move_pages03 &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: NUMA support not provided</font>
<br><font size=2 face="sans-serif">move_pages03 &nbsp; &nbsp;2 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: Remaining cases not appropriate
for configuration</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=1 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=move_pages04 stime=1438270702</font>
<br><font size=2 face="sans-serif">cmdline=&quot;move_pages.sh 04&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">move_pages04 &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: NUMA support not provided</font>
<br><font size=2 face="sans-serif">move_pages04 &nbsp; &nbsp;2 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: Remaining cases not appropriate
for configuration</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=move_pages05 stime=1438270702</font>
<br><font size=2 face="sans-serif">cmdline=&quot;move_pages.sh 05&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">move_pages05 &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: NUMA support not provided</font>
<br><font size=2 face="sans-serif">move_pages05 &nbsp; &nbsp;2 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: Remaining cases not appropriate
for configuration</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=move_pages06 stime=1438270702</font>
<br><font size=2 face="sans-serif">cmdline=&quot;move_pages.sh 06&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">move_pages06 &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: NUMA support not provided</font>
<br><font size=2 face="sans-serif">move_pages06 &nbsp; &nbsp;2 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: Remaining cases not appropriate
for configuration</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=move_pages07 stime=1438270702</font>
<br><font size=2 face="sans-serif">cmdline=&quot;move_pages.sh 07&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">move_pages07 &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: NUMA support not provided</font>
<br><font size=2 face="sans-serif">move_pages07 &nbsp; &nbsp;2 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: Remaining cases not appropriate
for configuration</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=move_pages08 stime=1438270702</font>
<br><font size=2 face="sans-serif">cmdline=&quot;move_pages.sh 08&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">move_pages08 &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: &nbsp;move_pages08.c:138: move_pages: E2BIG was removed in commit
3140a227</font>
<br><font size=2 face="sans-serif">move_pages08 &nbsp; &nbsp;2 &nbsp;TCONF
&nbsp;: &nbsp;move_pages08.c:138: Remaining cases not appropriate for configuration</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=move_pages09 stime=1438270702</font>
<br><font size=2 face="sans-serif">cmdline=&quot;move_pages.sh 09&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">move_pages09 &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: NUMA support not provided</font>
<br><font size=2 face="sans-serif">move_pages09 &nbsp; &nbsp;2 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: Remaining cases not appropriate
for configuration</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=move_pages10 stime=1438270702</font>
<br><font size=2 face="sans-serif">cmdline=&quot;move_pages.sh 10&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">move_pages10 &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: &nbsp;<b>move_pages_support.c:412: NUMA support not provided</b></font>
<br><font size=2 face="sans-serif">move_pages10 &nbsp; &nbsp;2 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: Remaining cases not appropriate
for configuration</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=move_pages11 stime=1438270702</font>
<br><font size=2 face="sans-serif">cmdline=&quot;cd $LTPROOT/testcases/bin
&amp;&amp; chown root move_pages11 &amp;&amp; chmod 04755 move_pages11
&amp;&amp; move_pages.sh 11&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">incrementing stop</font>
<br><font size=2 face="sans-serif">move_pages11 &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: <b>&nbsp;move_pages_support.c:412: NUMA support not provided</b></font>
<br><font size=2 face="sans-serif">move_pages11 &nbsp; &nbsp;2 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: Remaining cases not appropriate
for configuration</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">INFO: ltp-pan reported all tests PASS</font>
<br><font size=2 face="sans-serif">LTP Version: 20150420</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp;###############################################################</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Done executing testcases.</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
LTP Version: &nbsp;20150420</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp;###############################################################</font>
<br>
<br><font size=2 face="sans-serif">perf2877:~ #</font>
<br>
<br><font size=2 face="sans-serif">Thanks</font>
<br><font size=2 face="sans-serif">Vijay Kumar</font>
<br>
<br>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Vijay K Puliyala/India/IBM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Ltp-list@lists.sourceforge.net</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">07/31/2015 01:42 PM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [LTP] :
Test Cases for libnuma</font>
<br>
<hr noshade>
<br>
<br><font size=2 face="sans-serif">Hi,</font>
<br>
<br><font size=2 face="sans-serif">I have installed LTP on SUSE. &nbsp;I
want to run numa testcases. &nbsp;I have done below steps to run numa.</font>
<br>
<br><font size=2 face="sans-serif">_______________________________________________________________________</font>
<br>
<br><font size=2 face="sans-serif">perf2877:/vijay/NUMA/ltp-full-20150420
# ./runltp -f numa</font>
<br><font size=2 face="sans-serif">FATAL: LTP not installed correctly</font>
<br><font size=2 face="sans-serif">INFO: &nbsp;Follow directions in INSTALL!</font>
<br>
<br><font size=2 face="sans-serif">______________________________________________________________________</font>
<br>
<br><font size=2 face="sans-serif">perf2877:/vijay/NUMA/ltp-full-20150420
# /opt/ltp/runltp -f numa</font>
<br>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_start&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">tag=move_pages11 stime=1438256071</font>
<br><font size=2 face="sans-serif">cmdline=&quot;cd $LTPROOT/testcases/bin
&amp;&amp; chown root move_pages11 &amp;&amp; chmod 04755 move_pages11
&amp;&amp; move_pages.sh 11&quot;</font>
<br><font size=2 face="sans-serif">contacts=&quot;&quot;</font>
<br><font size=2 face="sans-serif">analysis=exit</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_output&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">incrementing stop</font>
<br><font size=2 face="sans-serif">move_pages11 &nbsp; &nbsp;1 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412:<b> NUMA support not provided</b></font>
<br><font size=2 face="sans-serif">move_pages11 &nbsp; &nbsp;2 &nbsp;TCONF
&nbsp;: &nbsp;move_pages_support.c:412: Remaining cases not appropriate
for configuration</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;execution_status&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif">initiation_status=&quot;ok&quot;</font>
<br><font size=2 face="sans-serif">duration=0 termination_type=exited termination_id=32
corefile=no</font>
<br><font size=2 face="sans-serif">cutime=0 cstime=0</font>
<br><font size=2 face="sans-serif">&lt;&lt;&lt;test_end&gt;&gt;&gt;</font>
<br><font size=2 face="sans-serif"><b><i>INFO: ltp-pan reported some tests
FAIL</i></b></font>
<br><font size=2 face="sans-serif">LTP Version: 20150420</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp;###############################################################</font>
<br>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
Done executing testcases.</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
LTP Version: &nbsp;20150420</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp;###############################################################</font>
<br>
<br>
<br><font size=2 face="sans-serif">But if I run only &nbsp;&quot;/opt/ltp/runltp&quot;
with out any options or with out &quot; -f numa &quot; option &nbsp;it
is giving results.</font>
<br><font size=2 face="sans-serif">____________________________________________________________________________</font>
<br><font size=2 face="sans-serif">If I run numa01.sh I am getting below
errors.</font>
<br><font size=2 face="sans-serif">perf2877:/vijay/NUMA/ltp-full-20150420/testcases/kernel/numa
# ./numa01.sh</font>
<br><font size=2 face="sans-serif">./numa01.sh: line 66: tst_brkm: command
not found</font>
<br><font size=2 face="sans-serif">./numa01.sh: line 784: tst_resm: command
not found</font>
<br><font size=2 face="sans-serif">./numa01.sh: line 215: tst_resm: command
not found</font>
<br><font size=2 face="sans-serif">___________________________________________________________________</font>
<br>
<br>
<br><font size=2 face="sans-serif">Please correct me if I have done any
mistake. </font>
<br>
<br><font size=2 face="sans-serif">I have installed &nbsp;below packages
&nbsp;</font>
<br>
<br><font size=2 face="sans-serif">perf2877:/opt/ltp # rpm -q libnuma-devel</font>
<br><font size=2 face="sans-serif">libnuma-devel-2.0.9-5.1.1</font>
<br><font size=2 face="sans-serif">perf2877:/opt/ltp # rpm -q libnuma1</font>
<br><font size=2 face="sans-serif">libnuma1-2.0.9-5.1.1</font>
<br><font size=2 face="sans-serif">perf2877:/opt/ltp # rpm -q libnuma-devel</font>
<br><font size=2 face="sans-serif">libnuma-devel-2.0.9-5.1.1</font>
<br><font size=2 face="sans-serif">perf2877:/opt/ltp # rpm -q autoconf</font>
<br><font size=2 face="sans-serif">autoconf-2.69-9.3</font>
<br><font size=2 face="sans-serif">perf2877:/opt/ltp # rpm -q automake</font>
<br><font size=2 face="sans-serif">automake-1.10.1-4.131.9.1</font>
<br><font size=2 face="sans-serif">perf2877:/opt/ltp #</font>
<br>
<br><font size=2 face="sans-serif">Also please add me in mailing list.</font>
<br>
<br>
<br><font size=2 face="sans-serif">Thanks</font>
<br><font size=2 face="sans-serif">Vijay Kumar</font>
<br>
--=_alternative 0044B25E65257E93_=--



--===============5245271392201283968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============5245271392201283968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5245271392201283968==--



