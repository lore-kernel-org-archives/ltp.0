Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NpKpf-00020S-AE
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 12:16:11 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpKpe-0001ZV-43
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 12:16:11 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2AC5NnM018770
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 07:05:23 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2ACFqeA2048134
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 07:15:52 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2ACFp5g007216
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 09:15:52 -0300
Date: Wed, 10 Mar 2010 17:45:44 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100310121544.GB11404@linux.vnet.ibm.com>
References: <4B8558A6020000E80005EF62@sinclair.provo.novell.com>
	<364299f41002241708g1cd33c48k5f1e0e4553c02bec@mail.gmail.com>
	<20100225062615.GB3377@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20100225062615.GB3377@linux.vnet.ibm.com>
Subject: Re: [LTP] [patch] swapon03 cleanup v2
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
To: Garrett Cooper <yanegomi@gmail.com>, Murlin Wenzel <mwenzel@novell.com>, ltp-list@lists.sourceforge.net


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by e2.ny.us.ibm.com id
	o2AC5NnM018770

On Thu, Feb 25, 2010 at 11:56:15AM +0530, Rishikesh K Rajak wrote:
> On Wed, Feb 24, 2010 at 05:08:56PM -0800, Garrett Cooper wrote:
> > On Wed, Feb 24, 2010 at 3:49 PM, Murlin Wenzel <mwenzel@novell.com> w=
rote:
> > > Added clean_swap() to cleanup routine. =A0This makes sure all lefto=
ver swap files are removed.
> > >
> > > Signed-off-By: =A0Murlin Ray Wenzel mwenzel@novell.com
> >=20
> > Committed -- thanks!
> > -Garrett
>=20
> Thanks Garret & Murlin.


Hi Murlin,

can you please look into this failure as it still fails on my SLES11 & RH=
El5.4
boxes.

[root@mx3455a bin]# ./swapon03=20
swapon03    1  TFAIL  :  Failed swapon for file swapfile29: errno=3DEPERM=
(1):
Operation not permitted
swapon03    0  TWARN  :  tst_rmdir(): rmobj(/tmp/swasf2sLb) failed:
unlink(/tmp/swasf2sLb/swapfile22) failed; errno=3D1: Operation not permit=
ted
swapon03    1  TFAIL  :  Failed to setup swaps

attached is the strace log.

-Rishi

--=20
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=strace-log-swapon03

[root@mx3455a bin]# ./swapon03 
swapon03    1  TFAIL  :  Failed swapon for file swapfile29: errno=EPERM(1): Operation not permitted
swapon03    0  TWARN  :  tst_rmdir(): rmobj(/tmp/swasf2sLb) failed: unlink(/tmp/swasf2sLb/swapfile22) failed; errno=1: Operation not permitted
swapon03    1  TFAIL  :  Failed to setup swaps
[root@mx3455a bin]# strace ./swapon03
execve("./swapon03", ["./swapon03"], [/* 24 vars */]) = 0
brk(0)                                  = 0x110d000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f3295231000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=54784, ...}) = 0
mmap(NULL, 54784, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f3295223000
close(3)                                = 0
open("/lib64/libc.so.6", O_RDONLY)      = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`\354\1\0\0\0\0\0@"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=2435432, ...}) = 0
mmap(NULL, 3668136, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f3294c93000
mprotect(0x7f3294e0a000, 2093056, PROT_NONE) = 0
mmap(0x7f3295009000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x176000) = 0x7f3295009000
mmap(0x7f329500e000, 18600, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f329500e000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f3295222000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f3295221000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f3295220000
arch_prctl(ARCH_SET_FS, 0x7f3295221700) = 0
mprotect(0x7f3295009000, 16384, PROT_READ) = 0
mprotect(0x7f3295232000, 4096, PROT_READ) = 0
munmap(0x7f3295223000, 54784)           = 0
brk(0)                                  = 0x110d000
brk(0x112e000)                          = 0x112e000
uname({sys="Linux", node="mx3455a.in.ibm.com", ...}) = 0
rt_sigaction(SIGHUP, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGINT, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGQUIT, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGILL, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGTRAP, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGABRT, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGBUS, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGFPE, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGUSR1, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGSEGV, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGUSR2, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGPIPE, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGALRM, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGTERM, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGSTKFLT, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGTSTP, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGTTIN, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGTTOU, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGURG, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGXCPU, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGXFSZ, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGVTALRM, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGPROF, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGWINCH, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGIO, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGPWR, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGSYS, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGRT_16, {0x404b10, [], SA_RESTORER|SA_RESTART, 0x7f3294cc65e0}, {SIG_DFL, [], 0}, 8) = 0
geteuid()                               = 0
gettimeofday({1268222682, 1696}, NULL)  = 0
getpid()                                = 7784
mkdir("/tmp/swaXQgZbx", 0700)           = 0
getgid()                                = 0
chown("/tmp/swaXQgZbx", 4294967295, 0)  = 0
chmod("/tmp/swaXQgZbx", 0777)           = 0
chdir("/tmp/swaXQgZbx")                 = 0
statfs(".", {f_type="EXT2_SUPER_MAGIC", f_bsize=4096, f_blocks=12598961, f_bfree=11482616, f_bavail=10842616, f_files=3203072, f_ffree=3044055, f_fsid={695368058, -1211746724}, f_namelen=255, f_frsize=4096}) = 0
statfs(".", {f_type="EXT2_SUPER_MAGIC", f_bsize=4096, f_blocks=12598961, f_bfree=11482616, f_bavail=10842616, f_files=3203072, f_ffree=3044055, f_fsid={695368058, -1211746724}, f_namelen=255, f_frsize=4096}) = 0
setresuid(-1, 0, -1)                    = 0
open("/proc/swaps", O_RDONLY)           = 3
read(3, "Filename\t\t\t\tType\t\tSize\tUsed\tPrior"..., 8192) = 1643
close(3)                                = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f32952219d0) = 7785
wait4(7785, swapon03    1  TFAIL  :  Failed swapon for file swapfile02: errno=EPERM(1): Operation not permitted
[{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0, NULL) = 7785
--- SIGCHLD (Child exited) @ 0 (0) ---
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1), ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f3295230000
write(1, "swapon03    1  TFAIL  :  Failed t"..., 47swapon03    1  TFAIL  :  Failed to setup swaps
) = 47
exit_group(1)                           = ?


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--3MwIy2ne0vdjdPXF--

