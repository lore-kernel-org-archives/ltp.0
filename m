Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <randyab@us.ibm.com>) id 1YEuTX-0005Rx-Bh
	for ltp-list@lists.sourceforge.net; Sat, 24 Jan 2015 06:45:43 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YEuTU-0005b8-J9
	for ltp-list@lists.sourceforge.net; Sat, 24 Jan 2015 06:45:43 +0000
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <randyab@us.ibm.com>;
	Fri, 23 Jan 2015 23:45:35 -0700
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
	[9.57.198.28])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 6FE2FC9003C
	for <ltp-list@lists.sourceforge.net>;
	Sat, 24 Jan 2015 01:36:44 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	t0O6jWBg24117278
	for <ltp-list@lists.sourceforge.net>; Sat, 24 Jan 2015 06:45:32 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	t0O6jWTi016291
	for <ltp-list@lists.sourceforge.net>; Sat, 24 Jan 2015 01:45:32 -0500
Received: from d01ml099.pok.ibm.com (d01ml099.pok.ibm.com [9.63.8.34])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	t0O6jWdk016282
	for <ltp-list@lists.sourceforge.net>; Sat, 24 Jan 2015 01:45:32 -0500
Message-ID: <OF94742AD0.BF94A514-ON85257DD7.0024E1A8-85257DD7.00251AB6@us.ibm.com>
From: Randy Brewster <randyab@us.ibm.com>
Date: Sat, 24 Jan 2015 01:45:31 -0500
MIME-Version: 1.0
Subject: [LTP] LTP: configure on LoZ node have these problems
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2254272661127378155=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2254272661127378155==
Content-type: multipart/alternative; 
	Boundary="0__=0ABBF744DFB767388f9e8a93df938690918c0ABBF744DFB76738"
Content-Disposition: inline

--0__=0ABBF744DFB767388f9e8a93df938690918c0ABBF744DFB76738
Content-type: text/plain; charset=US-ASCII


Hi

(01:38:13) svtc1a:/opt/ltp-full-20150119 # configure
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking build system type... s390x-ibm-linux-gnu
checking host system type... s390x-ibm-linux-gnu
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking for style of include used by make... GNU
checking dependency style of gcc... none
checking for ar... ar
checking for flex... flex
checking lex output file root... lex.yy
checking lex library... -lfl
checking whether yytext is a pointer... yes
checking for ranlib... ranlib
checking for strip... strip
checking for bison... bison -y
checking how to run the C preprocessor... gcc -E
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking dmapi.h usability... yes
checking dmapi.h presence... yes
checking for dmapi.h... yes
checking ifaddrs.h usability... yes
checking ifaddrs.h presence... yes
checking for ifaddrs.h... yes
checking libaio.h usability... yes
checking libaio.h presence... yes
checking for libaio.h... yes
checking mm.h usability... no
checking mm.h presence... no
checking for mm.h... no
checking pthread.h usability... yes
checking pthread.h presence... yes
checking for pthread.h... yes
checking attr/xattr.h usability... no
checking attr/xattr.h presence... no
checking for attr/xattr.h... no
checking linux/genetlink.h usability... no
checking linux/genetlink.h presence... yes
configure: WARNING: linux/genetlink.h: present but cannot be compiled
configure: WARNING: linux/genetlink.h:     check for missing prerequisite
headers?
configure: WARNING: linux/genetlink.h: see the Autoconf documentation
configure: WARNING: linux/genetlink.h:     section "Present But Cannot Be
Compiled"
configure: WARNING: linux/genetlink.h: proceeding with the compiler's
result
configure: WARNING:     ## --------------------------------------------- ##
configure: WARNING:     ## Report this to ltp-list@lists.sourceforge.net ##
configure: WARNING:     ## --------------------------------------------- ##
checking for linux/genetlink.h... no
checking linux/mempolicy.h usability... yes
checking linux/mempolicy.h presence... yes
checking for linux/mempolicy.h... yes
checking linux/module.h usability... no
checking linux/module.h presence... no
checking for linux/module.h... no
checking linux/netlink.h usability... no
checking linux/netlink.h presence... yes
configure: WARNING: linux/netlink.h: present but cannot be compiled
configure: WARNING: linux/netlink.h:     check for missing prerequisite
headers?
configure: WARNING: linux/netlink.h: see the Autoconf documentation
configure: WARNING: linux/netlink.h:     section "Present But Cannot Be
Compiled"
configure: WARNING: linux/netlink.h: proceeding with the compiler's result
configure: WARNING:     ## --------------------------------------------- ##
configure: WARNING:     ## Report this to ltp-list@lists.sourceforge.net ##
configure: WARNING:     ## --------------------------------------------- ##
checking for linux/netlink.h... no
checking sys/epoll.h usability... yes
checking sys/epoll.h presence... yes
checking for sys/epoll.h... yes
checking sys/inotify.h usability... yes
checking sys/inotify.h presence... yes
checking for sys/inotify.h... yes
checking sys/fanotify.h usability... no
checking sys/fanotify.h presence... no
checking for sys/fanotify.h... no
checking sys/jfsdmapi.h usability... no
checking sys/jfsdmapi.h presence... no
checking for sys/jfsdmapi.h... no
checking sys/prctl.h usability... yes
checking sys/prctl.h presence... yes
checking for sys/prctl.h... yes
checking whether to define _FORTIFY_SOURCE=2... yes
checking if gcc supports -Wold-style-definition... yes
checking for mkdtemp... yes
checking sys/capability.h usability... no
checking sys/capability.h presence... no
checking for sys/capability.h... no
checking openssl/sha.h usability... no
checking openssl/sha.h presence... no
checking for openssl/sha.h... no
checking sys/ptrace.h usability... yes
checking sys/ptrace.h presence... yes
checking for sys/ptrace.h... yes
checking sys/reg.h usability... no
checking sys/reg.h presence... no
checking for sys/reg.h... no
checking asm/ptrace.h usability... yes
checking asm/ptrace.h presence... yes
checking for asm/ptrace.h... yes
checking linux/ptrace.h usability... yes
checking linux/ptrace.h presence... yes
checking for linux/ptrace.h... yes
checking for struct user_regs_struct... yes
checking for struct pt_regs... no
checking whether PTRACE_GETSIGINFO is declared... yes
checking whether PTRACE_O_TRACEVFORKDONE is declared... yes
checking whether PTRACE_SETOPTIONS is declared... yes
checking for struct ptrace_peeksiginfo_args... no
checking for fork... yes
checking for daemon... yes
checking for vfork... yes
checking for sys/prctl.h... (cached) yes
checking whether PR_CAPBSET_DROP is declared... yes
checking whether PR_CAPBSET_READ is declared... yes
checking linux/securebits.h usability... no
checking linux/securebits.h presence... no
checking for linux/securebits.h... no
checking selinux/selinux.h usability... no
checking selinux/selinux.h presence... no
checking for selinux/selinux.h... no
checking for struct sigaction.sa_sigaction... yes
checking for libaio.h... (cached) yes
checking for io_setup in -laio... yes
checking io_set_eventfd is defined in aio library or aio header... yes
checking for modify_ldt... no
checking asm/ldt.h usability... no
checking asm/ldt.h presence... no
checking for asm/ldt.h... no
checking for linux/mempolicy.h... (cached) yes
checking for numa_alloc_onnode in -lnuma... no
checking for numa_move_pages in -lnuma... no
checking for numa_available in -lnuma... no
checking whether MPOL_BIND is declared... no
checking whether MPOL_DEFAULT is declared... no
checking whether MPOL_F_ADDR is declared... no
checking whether MPOL_F_MEMS_ALLOWED is declared... no
checking whether MPOL_F_NODE is declared... no
checking whether MPOL_INTERLEAVE is declared... no
checking whether MPOL_PREFERRED is declared... no
checking numa.h usability... no
checking numa.h presence... no
checking for numa.h... no
checking numaif.h usability... no
checking numaif.h presence... no
checking for numaif.h... no
checking for signalfd... yes
checking sys/signalfd.h usability... yes
checking sys/signalfd.h presence... yes
checking for sys/signalfd.h... yes
checking linux/types.h usability... yes
checking linux/types.h presence... yes
checking for linux/types.h... yes
checking for linux/signalfd.h... no
checking for signalfd.h... no
checking for unshare... yes
checking for utimensat... yes
checking for linux/taskstats.h... yes
checking for struct taskstats.freepages_count... yes
checking for struct taskstats.nvcsw... yes
checking for struct taskstats.read_bytes... yes
checking whether CLOCK_MONOTONIC_RAW is declared... no
checking whether CLOCK_REALTIME_COARSE is declared... no
checking whether CLOCK_MONOTONIC_COARSE is declared... no
checking whether MADV_MERGEABLE is declared... yes
checking sys/acl.h usability... no
checking sys/acl.h presence... no
checking for sys/acl.h... no
checking for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS in <linux/fs.h>... yes
checking for MREMAP_FIXED in <sys/mman.h>... yes
checking for kernel-devel... yes
checking for XFS quota (xfs/xqm.h)... no
checking if clone() supports 7 args... yes
checking for mkdirat... yes
checking for fchownat... yes
checking for mknodat... yes
checking for readlinkat... yes
checking for openat... yes
checking for renameat... yes
checking for fallocate... yes
checking for fcntl f_owner_ex... yes
checking for perf_event_attr in linux/perf_event.h... yes
checking tirpc/netconfig.h usability... no
checking tirpc/netconfig.h presence... no
checking for tirpc/netconfig.h... no
checking for tee... yes
checking for splice... yes
checking for vmsplice... yes
checking for timerfd_create... yes
checking for timerfd_settime... yes
checking for timerfd_gettime... yes
checking sys/timerfd.h usability... yes
checking sys/timerfd.h presence... yes
checking for sys/timerfd.h... yes
checking linux/can.h usability... no
checking linux/can.h presence... yes
configure: WARNING: linux/can.h: present but cannot be compiled
configure: WARNING: linux/can.h:     check for missing prerequisite
headers?
configure: WARNING: linux/can.h: see the Autoconf documentation
configure: WARNING: linux/can.h:     section "Present But Cannot Be
Compiled"
configure: WARNING: linux/can.h: proceeding with the compiler's result
configure: WARNING:     ## --------------------------------------------- ##
configure: WARNING:     ## Report this to ltp-list@lists.sourceforge.net ##
configure: WARNING:     ## --------------------------------------------- ##
checking for linux/can.h... no
checking for struct iovec... yes
checking linux/keyctl.h usability... yes
checking linux/keyctl.h presence... yes
checking for linux/keyctl.h... yes
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating include/mk/config.mk
config.status: creating include/mk/features.mk
config.status: creating lib/ltp.pc
config.status: creating m4/Makefile
config.status: creating execltp
config.status: creating include/config.h
config.status: include/config.h is unchanged
config.status: executing depfiles commands
=== configuring in utils/ffsb-6.0-rc2
(/opt/ltp-full-20150119/utils/ffsb-6.0-rc2)
configure: running /bin/sh ./configure --disable-option-checking
'--prefix=/opt/ltp'  --cache-file=/dev/null --srcdir=.
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking build system type... s390x-ibm-linux-gnu
checking host system type... s390x-ibm-linux-gnu
checking for style of include used by make... GNU
checking for gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking dependency style of gcc... gcc3
checking how to run the C preprocessor... gcc -E
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for AIX... no
checking for gcc... (cached) gcc
checking whether we are using the GNU C compiler... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for gcc option to accept ISO C89... (cached) none needed
checking dependency style of gcc... (cached) gcc3
checking for main in -lm... yes
checking for main in -lpthread... yes
checking for ANSI C header files... yes
checking for sys/wait.h that is POSIX.1 compatible... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking pthread.h usability... yes
checking pthread.h presence... yes
checking for pthread.h... yes
checking fcntl.h usability... yes
checking fcntl.h presence... yes
checking for fcntl.h... yes
checking limits.h usability... yes
checking limits.h presence... yes
checking for limits.h... yes
checking for stdint.h... (cached) yes
checking sys/time.h usability... yes
checking sys/time.h presence... yes
checking for sys/time.h... yes
checking for unistd.h... (cached) yes
checking sys/vfs.h usability... yes
checking sys/vfs.h presence... yes
checking for sys/vfs.h... yes
checking sys/limits.h usability... no
checking sys/limits.h presence... no
checking for sys/limits.h... no
checking for an ANSI C-conforming const... yes
checking whether time.h and sys/time.h may both be included... yes
checking for function prototypes... yes
checking whether setvbuf arguments are reversed... no
checking for system... yes
checking for gettimeofday... yes
checking for mkdir... yes
checking for strerror... yes
checking for open64... yes
checking for stat64... yes
checking for fseeko64... yes
checking for lrand48_r... yes
checking for srand48_r... yes
configure: creating ./config.status
config.status: creating Makefile
config.status: creating config.h
config.status: config.h is unchanged
config.status: executing depfiles commands
config.status: executing default commands
(01:38:31) svtc1a:/opt/ltp-full-20150119 #

(01:38:31) svtc1a:/opt/ltp-full-20150119 # uname -a
Linux svtc1a 3.0.101-0.15-default #1 SMP Wed Jan 22 15:49:03 UTC 2014
(5c01f4e) s390x s390x s390x GNU/Linux
(01:44:49) svtc1a:/opt/ltp-full-20150119 #

Thanks
=============================================
Randy Brewster                                   randyab@us.ibm.com
IBM pSeries Cluster System Test
Dept VN6A / 7T          MS/P966
2455 South Road
Poughkeepsie, NY, 12601-5400
(845)-433-7133                                    (tieline 293-7133)

--0__=0ABBF744DFB767388f9e8a93df938690918c0ABBF744DFB76738
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><font size="2" face="sans-serif">Hi </font><br>
<br>
<font size="2" face="sans-serif">(01:38:13) svtc1a:/opt/ltp-full-20150119 # configure</font><br>
<font size="2" face="sans-serif">checking for a BSD-compatible install... /usr/bin/install -c</font><br>
<font size="2" face="sans-serif">checking whether build environment is sane... yes</font><br>
<font size="2" face="sans-serif">checking for a thread-safe mkdir -p... /bin/mkdir -p</font><br>
<font size="2" face="sans-serif">checking for gawk... gawk</font><br>
<font size="2" face="sans-serif">checking whether make sets $(MAKE)... yes</font><br>
<font size="2" face="sans-serif">checking whether make supports nested variables... yes</font><br>
<font size="2" face="sans-serif">checking build system type... s390x-ibm-linux-gnu</font><br>
<font size="2" face="sans-serif">checking host system type... s390x-ibm-linux-gnu</font><br>
<font size="2" face="sans-serif">checking for gcc... gcc</font><br>
<font size="2" face="sans-serif">checking whether the C compiler works... yes</font><br>
<font size="2" face="sans-serif">checking for C compiler default output file name... a.out</font><br>
<font size="2" face="sans-serif">checking for suffix of executables...</font><br>
<font size="2" face="sans-serif">checking whether we are cross compiling... no</font><br>
<font size="2" face="sans-serif">checking for suffix of object files... o</font><br>
<font size="2" face="sans-serif">checking whether we are using the GNU C compiler... yes</font><br>
<font size="2" face="sans-serif">checking whether gcc accepts -g... yes</font><br>
<font size="2" face="sans-serif">checking for gcc option to accept ISO C89... none needed</font><br>
<font size="2" face="sans-serif">checking for style of include used by make... GNU</font><br>
<font size="2" face="sans-serif">checking dependency style of gcc... none</font><br>
<font size="2" face="sans-serif">checking for ar... ar</font><br>
<font size="2" face="sans-serif">checking for flex... flex</font><br>
<font size="2" face="sans-serif">checking lex output file root... lex.yy</font><br>
<font size="2" face="sans-serif">checking lex library... -lfl</font><br>
<font size="2" face="sans-serif">checking whether yytext is a pointer... yes</font><br>
<font size="2" face="sans-serif">checking for ranlib... ranlib</font><br>
<font size="2" face="sans-serif">checking for strip... strip</font><br>
<font size="2" face="sans-serif">checking for bison... bison -y</font><br>
<font size="2" face="sans-serif">checking how to run the C preprocessor... gcc -E</font><br>
<font size="2" face="sans-serif">checking for grep that handles long lines and -e... /usr/bin/grep</font><br>
<font size="2" face="sans-serif">checking for egrep... /usr/bin/grep -E</font><br>
<font size="2" face="sans-serif">checking for ANSI C header files... yes</font><br>
<font size="2" face="sans-serif">checking for sys/types.h... yes</font><br>
<font size="2" face="sans-serif">checking for sys/stat.h... yes</font><br>
<font size="2" face="sans-serif">checking for stdlib.h... yes</font><br>
<font size="2" face="sans-serif">checking for string.h... yes</font><br>
<font size="2" face="sans-serif">checking for memory.h... yes</font><br>
<font size="2" face="sans-serif">checking for strings.h... yes</font><br>
<font size="2" face="sans-serif">checking for inttypes.h... yes</font><br>
<font size="2" face="sans-serif">checking for stdint.h... yes</font><br>
<font size="2" face="sans-serif">checking for unistd.h... yes</font><br>
<font size="2" face="sans-serif">checking dmapi.h usability... yes</font><br>
<font size="2" face="sans-serif">checking dmapi.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for dmapi.h... yes</font><br>
<font size="2" face="sans-serif">checking ifaddrs.h usability... yes</font><br>
<font size="2" face="sans-serif">checking ifaddrs.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for ifaddrs.h... yes</font><br>
<font size="2" face="sans-serif">checking libaio.h usability... yes</font><br>
<font size="2" face="sans-serif">checking libaio.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for libaio.h... yes</font><br>
<font size="2" face="sans-serif">checking mm.h usability... no</font><br>
<font size="2" face="sans-serif">checking mm.h presence... no</font><br>
<font size="2" face="sans-serif">checking for mm.h... no</font><br>
<font size="2" face="sans-serif">checking pthread.h usability... yes</font><br>
<font size="2" face="sans-serif">checking pthread.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for pthread.h... yes</font><br>
<font size="2" face="sans-serif">checking attr/xattr.h usability... no</font><br>
<font size="2" face="sans-serif">checking attr/xattr.h presence... no</font><br>
<font size="2" face="sans-serif">checking for attr/xattr.h... no</font><br>
<font size="2" face="sans-serif">checking linux/genetlink.h usability... no</font><br>
<font size="2" face="sans-serif">checking linux/genetlink.h presence... yes</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/genetlink.h: present but cannot be compiled</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/genetlink.h: &nbsp; &nbsp; check for missing prerequisite headers?</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/genetlink.h: see the Autoconf documentation</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/genetlink.h: &nbsp; &nbsp; section &quot;Present But Cannot Be Compiled&quot;</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/genetlink.h: proceeding with the compiler's result</font><br>
<font size="2" face="sans-serif">configure: WARNING: &nbsp; &nbsp; ## --------------------------------------------- ##</font><br>
<font size="2" face="sans-serif">configure: WARNING: &nbsp; &nbsp; ## Report this to ltp-list@lists.sourceforge.net ##</font><br>
<font size="2" face="sans-serif">configure: WARNING: &nbsp; &nbsp; ## --------------------------------------------- ##</font><br>
<font size="2" face="sans-serif">checking for linux/genetlink.h... no</font><br>
<font size="2" face="sans-serif">checking linux/mempolicy.h usability... yes</font><br>
<font size="2" face="sans-serif">checking linux/mempolicy.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for linux/mempolicy.h... yes</font><br>
<font size="2" face="sans-serif">checking linux/module.h usability... no</font><br>
<font size="2" face="sans-serif">checking linux/module.h presence... no</font><br>
<font size="2" face="sans-serif">checking for linux/module.h... no</font><br>
<font size="2" face="sans-serif">checking linux/netlink.h usability... no</font><br>
<font size="2" face="sans-serif">checking linux/netlink.h presence... yes</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/netlink.h: present but cannot be compiled</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/netlink.h: &nbsp; &nbsp; check for missing prerequisite headers?</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/netlink.h: see the Autoconf documentation</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/netlink.h: &nbsp; &nbsp; section &quot;Present But Cannot Be Compiled&quot;</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/netlink.h: proceeding with the compiler's result</font><br>
<font size="2" face="sans-serif">configure: WARNING: &nbsp; &nbsp; ## --------------------------------------------- ##</font><br>
<font size="2" face="sans-serif">configure: WARNING: &nbsp; &nbsp; ## Report this to ltp-list@lists.sourceforge.net ##</font><br>
<font size="2" face="sans-serif">configure: WARNING: &nbsp; &nbsp; ## --------------------------------------------- ##</font><br>
<font size="2" face="sans-serif">checking for linux/netlink.h... no</font><br>
<font size="2" face="sans-serif">checking sys/epoll.h usability... yes</font><br>
<font size="2" face="sans-serif">checking sys/epoll.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for sys/epoll.h... yes</font><br>
<font size="2" face="sans-serif">checking sys/inotify.h usability... yes</font><br>
<font size="2" face="sans-serif">checking sys/inotify.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for sys/inotify.h... yes</font><br>
<font size="2" face="sans-serif">checking sys/fanotify.h usability... no</font><br>
<font size="2" face="sans-serif">checking sys/fanotify.h presence... no</font><br>
<font size="2" face="sans-serif">checking for sys/fanotify.h... no</font><br>
<font size="2" face="sans-serif">checking sys/jfsdmapi.h usability... no</font><br>
<font size="2" face="sans-serif">checking sys/jfsdmapi.h presence... no</font><br>
<font size="2" face="sans-serif">checking for sys/jfsdmapi.h... no</font><br>
<font size="2" face="sans-serif">checking sys/prctl.h usability... yes</font><br>
<font size="2" face="sans-serif">checking sys/prctl.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for sys/prctl.h... yes</font><br>
<font size="2" face="sans-serif">checking whether to define _FORTIFY_SOURCE=2... yes</font><br>
<font size="2" face="sans-serif">checking if gcc supports -Wold-style-definition... yes</font><br>
<font size="2" face="sans-serif">checking for mkdtemp... yes</font><br>
<font size="2" face="sans-serif">checking sys/capability.h usability... no</font><br>
<font size="2" face="sans-serif">checking sys/capability.h presence... no</font><br>
<font size="2" face="sans-serif">checking for sys/capability.h... no</font><br>
<font size="2" face="sans-serif">checking openssl/sha.h usability... no</font><br>
<font size="2" face="sans-serif">checking openssl/sha.h presence... no</font><br>
<font size="2" face="sans-serif">checking for openssl/sha.h... no</font><br>
<font size="2" face="sans-serif">checking sys/ptrace.h usability... yes</font><br>
<font size="2" face="sans-serif">checking sys/ptrace.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for sys/ptrace.h... yes</font><br>
<font size="2" face="sans-serif">checking sys/reg.h usability... no</font><br>
<font size="2" face="sans-serif">checking sys/reg.h presence... no</font><br>
<font size="2" face="sans-serif">checking for sys/reg.h... no</font><br>
<font size="2" face="sans-serif">checking asm/ptrace.h usability... yes</font><br>
<font size="2" face="sans-serif">checking asm/ptrace.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for asm/ptrace.h... yes</font><br>
<font size="2" face="sans-serif">checking linux/ptrace.h usability... yes</font><br>
<font size="2" face="sans-serif">checking linux/ptrace.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for linux/ptrace.h... yes</font><br>
<font size="2" face="sans-serif">checking for struct user_regs_struct... yes</font><br>
<font size="2" face="sans-serif">checking for struct pt_regs... no</font><br>
<font size="2" face="sans-serif">checking whether PTRACE_GETSIGINFO is declared... yes</font><br>
<font size="2" face="sans-serif">checking whether PTRACE_O_TRACEVFORKDONE is declared... yes</font><br>
<font size="2" face="sans-serif">checking whether PTRACE_SETOPTIONS is declared... yes</font><br>
<font size="2" face="sans-serif">checking for struct ptrace_peeksiginfo_args... no</font><br>
<font size="2" face="sans-serif">checking for fork... yes</font><br>
<font size="2" face="sans-serif">checking for daemon... yes</font><br>
<font size="2" face="sans-serif">checking for vfork... yes</font><br>
<font size="2" face="sans-serif">checking for sys/prctl.h... (cached) yes</font><br>
<font size="2" face="sans-serif">checking whether PR_CAPBSET_DROP is declared... yes</font><br>
<font size="2" face="sans-serif">checking whether PR_CAPBSET_READ is declared... yes</font><br>
<font size="2" face="sans-serif">checking linux/securebits.h usability... no</font><br>
<font size="2" face="sans-serif">checking linux/securebits.h presence... no</font><br>
<font size="2" face="sans-serif">checking for linux/securebits.h... no</font><br>
<font size="2" face="sans-serif">checking selinux/selinux.h usability... no</font><br>
<font size="2" face="sans-serif">checking selinux/selinux.h presence... no</font><br>
<font size="2" face="sans-serif">checking for selinux/selinux.h... no</font><br>
<font size="2" face="sans-serif">checking for struct sigaction.sa_sigaction... yes</font><br>
<font size="2" face="sans-serif">checking for libaio.h... (cached) yes</font><br>
<font size="2" face="sans-serif">checking for io_setup in -laio... yes</font><br>
<font size="2" face="sans-serif">checking io_set_eventfd is defined in aio library or aio header... yes</font><br>
<font size="2" face="sans-serif">checking for modify_ldt... no</font><br>
<font size="2" face="sans-serif">checking asm/ldt.h usability... no</font><br>
<font size="2" face="sans-serif">checking asm/ldt.h presence... no</font><br>
<font size="2" face="sans-serif">checking for asm/ldt.h... no</font><br>
<font size="2" face="sans-serif">checking for linux/mempolicy.h... (cached) yes</font><br>
<font size="2" face="sans-serif">checking for numa_alloc_onnode in -lnuma... no</font><br>
<font size="2" face="sans-serif">checking for numa_move_pages in -lnuma... no</font><br>
<font size="2" face="sans-serif">checking for numa_available in -lnuma... no</font><br>
<font size="2" face="sans-serif">checking whether MPOL_BIND is declared... no</font><br>
<font size="2" face="sans-serif">checking whether MPOL_DEFAULT is declared... no</font><br>
<font size="2" face="sans-serif">checking whether MPOL_F_ADDR is declared... no</font><br>
<font size="2" face="sans-serif">checking whether MPOL_F_MEMS_ALLOWED is declared... no</font><br>
<font size="2" face="sans-serif">checking whether MPOL_F_NODE is declared... no</font><br>
<font size="2" face="sans-serif">checking whether MPOL_INTERLEAVE is declared... no</font><br>
<font size="2" face="sans-serif">checking whether MPOL_PREFERRED is declared... no</font><br>
<font size="2" face="sans-serif">checking numa.h usability... no</font><br>
<font size="2" face="sans-serif">checking numa.h presence... no</font><br>
<font size="2" face="sans-serif">checking for numa.h... no</font><br>
<font size="2" face="sans-serif">checking numaif.h usability... no</font><br>
<font size="2" face="sans-serif">checking numaif.h presence... no</font><br>
<font size="2" face="sans-serif">checking for numaif.h... no</font><br>
<font size="2" face="sans-serif">checking for signalfd... yes</font><br>
<font size="2" face="sans-serif">checking sys/signalfd.h usability... yes</font><br>
<font size="2" face="sans-serif">checking sys/signalfd.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for sys/signalfd.h... yes</font><br>
<font size="2" face="sans-serif">checking linux/types.h usability... yes</font><br>
<font size="2" face="sans-serif">checking linux/types.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for linux/types.h... yes</font><br>
<font size="2" face="sans-serif">checking for linux/signalfd.h... no</font><br>
<font size="2" face="sans-serif">checking for signalfd.h... no</font><br>
<font size="2" face="sans-serif">checking for unshare... yes</font><br>
<font size="2" face="sans-serif">checking for utimensat... yes</font><br>
<font size="2" face="sans-serif">checking for linux/taskstats.h... yes</font><br>
<font size="2" face="sans-serif">checking for struct taskstats.freepages_count... yes</font><br>
<font size="2" face="sans-serif">checking for struct taskstats.nvcsw... yes</font><br>
<font size="2" face="sans-serif">checking for struct taskstats.read_bytes... yes</font><br>
<font size="2" face="sans-serif">checking whether CLOCK_MONOTONIC_RAW is declared... no</font><br>
<font size="2" face="sans-serif">checking whether CLOCK_REALTIME_COARSE is declared... no</font><br>
<font size="2" face="sans-serif">checking whether CLOCK_MONOTONIC_COARSE is declared... no</font><br>
<font size="2" face="sans-serif">checking whether MADV_MERGEABLE is declared... yes</font><br>
<font size="2" face="sans-serif">checking sys/acl.h usability... no</font><br>
<font size="2" face="sans-serif">checking sys/acl.h presence... no</font><br>
<font size="2" face="sans-serif">checking for sys/acl.h... no</font><br>
<font size="2" face="sans-serif">checking for FS_IOC_GETFLAGS and FS_IOC_SETFLAGS in &lt;linux/fs.h&gt;... yes</font><br>
<font size="2" face="sans-serif">checking for MREMAP_FIXED in &lt;sys/mman.h&gt;... yes</font><br>
<font size="2" face="sans-serif">checking for kernel-devel... yes</font><br>
<font size="2" face="sans-serif">checking for XFS quota (xfs/xqm.h)... no</font><br>
<font size="2" face="sans-serif">checking if clone() supports 7 args... yes</font><br>
<font size="2" face="sans-serif">checking for mkdirat... yes</font><br>
<font size="2" face="sans-serif">checking for fchownat... yes</font><br>
<font size="2" face="sans-serif">checking for mknodat... yes</font><br>
<font size="2" face="sans-serif">checking for readlinkat... yes</font><br>
<font size="2" face="sans-serif">checking for openat... yes</font><br>
<font size="2" face="sans-serif">checking for renameat... yes</font><br>
<font size="2" face="sans-serif">checking for fallocate... yes</font><br>
<font size="2" face="sans-serif">checking for fcntl f_owner_ex... yes</font><br>
<font size="2" face="sans-serif">checking for perf_event_attr in linux/perf_event.h... yes</font><br>
<font size="2" face="sans-serif">checking tirpc/netconfig.h usability... no</font><br>
<font size="2" face="sans-serif">checking tirpc/netconfig.h presence... no</font><br>
<font size="2" face="sans-serif">checking for tirpc/netconfig.h... no</font><br>
<font size="2" face="sans-serif">checking for tee... yes</font><br>
<font size="2" face="sans-serif">checking for splice... yes</font><br>
<font size="2" face="sans-serif">checking for vmsplice... yes</font><br>
<font size="2" face="sans-serif">checking for timerfd_create... yes</font><br>
<font size="2" face="sans-serif">checking for timerfd_settime... yes</font><br>
<font size="2" face="sans-serif">checking for timerfd_gettime... yes</font><br>
<font size="2" face="sans-serif">checking sys/timerfd.h usability... yes</font><br>
<font size="2" face="sans-serif">checking sys/timerfd.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for sys/timerfd.h... yes</font><br>
<font size="2" face="sans-serif">checking linux/can.h usability... no</font><br>
<font size="2" face="sans-serif">checking linux/can.h presence... yes</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/can.h: present but cannot be compiled</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/can.h: &nbsp; &nbsp; check for missing prerequisite headers?</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/can.h: see the Autoconf documentation</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/can.h: &nbsp; &nbsp; section &quot;Present But Cannot Be Compiled&quot;</font><br>
<font size="2" face="sans-serif">configure: WARNING: linux/can.h: proceeding with the compiler's result</font><br>
<font size="2" face="sans-serif">configure: WARNING: &nbsp; &nbsp; ## --------------------------------------------- ##</font><br>
<font size="2" face="sans-serif">configure: WARNING: &nbsp; &nbsp; ## Report this to ltp-list@lists.sourceforge.net ##</font><br>
<font size="2" face="sans-serif">configure: WARNING: &nbsp; &nbsp; ## --------------------------------------------- ##</font><br>
<font size="2" face="sans-serif">checking for linux/can.h... no</font><br>
<font size="2" face="sans-serif">checking for struct iovec... yes</font><br>
<font size="2" face="sans-serif">checking linux/keyctl.h usability... yes</font><br>
<font size="2" face="sans-serif">checking linux/keyctl.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for linux/keyctl.h... yes</font><br>
<font size="2" face="sans-serif">checking that generated files are newer than configure... done</font><br>
<font size="2" face="sans-serif">configure: creating ./config.status</font><br>
<font size="2" face="sans-serif">config.status: creating include/mk/config.mk</font><br>
<font size="2" face="sans-serif">config.status: creating include/mk/features.mk</font><br>
<font size="2" face="sans-serif">config.status: creating lib/ltp.pc</font><br>
<font size="2" face="sans-serif">config.status: creating m4/Makefile</font><br>
<font size="2" face="sans-serif">config.status: creating execltp</font><br>
<font size="2" face="sans-serif">config.status: creating include/config.h</font><br>
<font size="2" face="sans-serif">config.status: include/config.h is unchanged</font><br>
<font size="2" face="sans-serif">config.status: executing depfiles commands</font><br>
<font size="2" face="sans-serif">=== configuring in utils/ffsb-6.0-rc2 (/opt/ltp-full-20150119/utils/ffsb-6.0-rc2)</font><br>
<font size="2" face="sans-serif">configure: running /bin/sh ./configure --disable-option-checking '--prefix=/opt/ltp' &nbsp;--cache-file=/dev/null --srcdir=.</font><br>
<font size="2" face="sans-serif">checking for a BSD-compatible install... /usr/bin/install -c</font><br>
<font size="2" face="sans-serif">checking whether build environment is sane... yes</font><br>
<font size="2" face="sans-serif">checking for a thread-safe mkdir -p... /bin/mkdir -p</font><br>
<font size="2" face="sans-serif">checking for gawk... gawk</font><br>
<font size="2" face="sans-serif">checking whether make sets $(MAKE)... yes</font><br>
<font size="2" face="sans-serif">checking build system type... s390x-ibm-linux-gnu</font><br>
<font size="2" face="sans-serif">checking host system type... s390x-ibm-linux-gnu</font><br>
<font size="2" face="sans-serif">checking for style of include used by make... GNU</font><br>
<font size="2" face="sans-serif">checking for gcc... gcc</font><br>
<font size="2" face="sans-serif">checking for C compiler default output file name... a.out</font><br>
<font size="2" face="sans-serif">checking whether the C compiler works... yes</font><br>
<font size="2" face="sans-serif">checking whether we are cross compiling... no</font><br>
<font size="2" face="sans-serif">checking for suffix of executables...</font><br>
<font size="2" face="sans-serif">checking for suffix of object files... o</font><br>
<font size="2" face="sans-serif">checking whether we are using the GNU C compiler... yes</font><br>
<font size="2" face="sans-serif">checking whether gcc accepts -g... yes</font><br>
<font size="2" face="sans-serif">checking for gcc option to accept ISO C89... none needed</font><br>
<font size="2" face="sans-serif">checking dependency style of gcc... gcc3</font><br>
<font size="2" face="sans-serif">checking how to run the C preprocessor... gcc -E</font><br>
<font size="2" face="sans-serif">checking for grep that handles long lines and -e... /usr/bin/grep</font><br>
<font size="2" face="sans-serif">checking for egrep... /usr/bin/grep -E</font><br>
<font size="2" face="sans-serif">checking for AIX... no</font><br>
<font size="2" face="sans-serif">checking for gcc... (cached) gcc</font><br>
<font size="2" face="sans-serif">checking whether we are using the GNU C compiler... (cached) yes</font><br>
<font size="2" face="sans-serif">checking whether gcc accepts -g... (cached) yes</font><br>
<font size="2" face="sans-serif">checking for gcc option to accept ISO C89... (cached) none needed</font><br>
<font size="2" face="sans-serif">checking dependency style of gcc... (cached) gcc3</font><br>
<font size="2" face="sans-serif">checking for main in -lm... yes</font><br>
<font size="2" face="sans-serif">checking for main in -lpthread... yes</font><br>
<font size="2" face="sans-serif">checking for ANSI C header files... yes</font><br>
<font size="2" face="sans-serif">checking for sys/wait.h that is POSIX.1 compatible... yes</font><br>
<font size="2" face="sans-serif">checking for sys/types.h... yes</font><br>
<font size="2" face="sans-serif">checking for sys/stat.h... yes</font><br>
<font size="2" face="sans-serif">checking for stdlib.h... yes</font><br>
<font size="2" face="sans-serif">checking for string.h... yes</font><br>
<font size="2" face="sans-serif">checking for memory.h... yes</font><br>
<font size="2" face="sans-serif">checking for strings.h... yes</font><br>
<font size="2" face="sans-serif">checking for inttypes.h... yes</font><br>
<font size="2" face="sans-serif">checking for stdint.h... yes</font><br>
<font size="2" face="sans-serif">checking for unistd.h... yes</font><br>
<font size="2" face="sans-serif">checking pthread.h usability... yes</font><br>
<font size="2" face="sans-serif">checking pthread.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for pthread.h... yes</font><br>
<font size="2" face="sans-serif">checking fcntl.h usability... yes</font><br>
<font size="2" face="sans-serif">checking fcntl.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for fcntl.h... yes</font><br>
<font size="2" face="sans-serif">checking limits.h usability... yes</font><br>
<font size="2" face="sans-serif">checking limits.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for limits.h... yes</font><br>
<font size="2" face="sans-serif">checking for stdint.h... (cached) yes</font><br>
<font size="2" face="sans-serif">checking sys/time.h usability... yes</font><br>
<font size="2" face="sans-serif">checking sys/time.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for sys/time.h... yes</font><br>
<font size="2" face="sans-serif">checking for unistd.h... (cached) yes</font><br>
<font size="2" face="sans-serif">checking sys/vfs.h usability... yes</font><br>
<font size="2" face="sans-serif">checking sys/vfs.h presence... yes</font><br>
<font size="2" face="sans-serif">checking for sys/vfs.h... yes</font><br>
<font size="2" face="sans-serif">checking sys/limits.h usability... no</font><br>
<font size="2" face="sans-serif">checking sys/limits.h presence... no</font><br>
<font size="2" face="sans-serif">checking for sys/limits.h... no</font><br>
<font size="2" face="sans-serif">checking for an ANSI C-conforming const... yes</font><br>
<font size="2" face="sans-serif">checking whether time.h and sys/time.h may both be included... yes</font><br>
<font size="2" face="sans-serif">checking for function prototypes... yes</font><br>
<font size="2" face="sans-serif">checking whether setvbuf arguments are reversed... no</font><br>
<font size="2" face="sans-serif">checking for system... yes</font><br>
<font size="2" face="sans-serif">checking for gettimeofday... yes</font><br>
<font size="2" face="sans-serif">checking for mkdir... yes</font><br>
<font size="2" face="sans-serif">checking for strerror... yes</font><br>
<font size="2" face="sans-serif">checking for open64... yes</font><br>
<font size="2" face="sans-serif">checking for stat64... yes</font><br>
<font size="2" face="sans-serif">checking for fseeko64... yes</font><br>
<font size="2" face="sans-serif">checking for lrand48_r... yes</font><br>
<font size="2" face="sans-serif">checking for srand48_r... yes</font><br>
<font size="2" face="sans-serif">configure: creating ./config.status</font><br>
<font size="2" face="sans-serif">config.status: creating Makefile</font><br>
<font size="2" face="sans-serif">config.status: creating config.h</font><br>
<font size="2" face="sans-serif">config.status: config.h is unchanged</font><br>
<font size="2" face="sans-serif">config.status: executing depfiles commands</font><br>
<font size="2" face="sans-serif">config.status: executing default commands</font><br>
<font size="2" face="sans-serif">(01:38:31) svtc1a:/opt/ltp-full-20150119 #</font><br>
<br>
<font size="2" face="sans-serif">(01:38:31) svtc1a:/opt/ltp-full-20150119 # uname -a</font><br>
<font size="2" face="sans-serif">Linux svtc1a 3.0.101-0.15-default #1 SMP Wed Jan 22 15:49:03 UTC 2014 (5c01f4e) s390x s390x s390x GNU/Linux</font><br>
<font size="2" face="sans-serif">(01:44:49) svtc1a:/opt/ltp-full-20150119 #</font><br>
<br>
<font size="2" face="sans-serif">Thanks</font><br>
<font size="2" face="sans-serif">=============================================<br>
Randy Brewster &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; randyab@us.ibm.com<br>
IBM pSeries Cluster System Test<br>
Dept VN6A / 7T &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;MS/P966<br>
2455 South Road<br>
Poughkeepsie, NY, 12601-5400<br>
(845)-433-7133 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(tieline 293-7133)<br>
<br>
</font></body></html>
--0__=0ABBF744DFB767388f9e8a93df938690918c0ABBF744DFB76738--



--===============2254272661127378155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
--===============2254272661127378155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2254272661127378155==--



