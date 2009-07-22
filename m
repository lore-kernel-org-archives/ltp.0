Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MTUAu-0004e4-Hl
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 05:15:32 +0000
Received: from wf-out-1314.google.com ([209.85.200.173])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTUAm-0003gS-4x
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 05:15:32 +0000
Received: by wf-out-1314.google.com with SMTP id 26so1063305wfd.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 22:15:23 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 21 Jul 2009 22:15:23 -0700
Message-ID: <364299f40907212215y52221428ob6c3be2a610d84dc@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] eventfd_03 broken on 2.6.29?
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
To: LTP list <ltp-list@lists.sourceforge.net>

After applying the fix noted for the issue noted by CAI (and even
beforehand), I find that the testcase simply doesn't work (see below).

gcooper@orangebox /scratch/ltp-dev2/ltp $ strace
testcases/kernel/syscalls/eventfd2/eventfd2_03
execve("testcases/kernel/syscalls/eventfd2/eventfd2_03",
["testcases/kernel/syscalls/eventf"...], [/* 46 vars */]) = 0
brk(0)                                  = 0x1a8b000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7fcb728f1000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7fcb728f0000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=80124, ...}) = 0
mmap(NULL, 80124, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fcb728dc000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\340\346\1\0\0\0\0\0@"...,
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1383600, ...}) = 0
mmap(NULL, 3490456, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x7fcb72381000
mprotect(0x7fcb724cc000, 2097152, PROT_NONE) = 0
mmap(0x7fcb726cc000, 20480, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14b000) = 0x7fcb726cc000
mmap(0x7fcb726d1000, 17048, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fcb726d1000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7fcb728db000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7fcb728da000
arch_prctl(ARCH_SET_FS, 0x7fcb728da6f0) = 0
mprotect(0x7fcb726cc000, 16384, PROT_READ) = 0
mprotect(0x603000, 4096, PROT_READ)     = 0
mprotect(0x7fcb728f2000, 4096, PROT_READ) = 0
munmap(0x7fcb728dc000, 80124)           = 0
uname({sys="Linux", node="orangebox", ...}) = 0
syscall_290(0, 0x1, 0xfffffffd, 0x1d, 0xa, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) = -1 (errno 22)
dup(2)                                  = 3
fcntl(3, F_GETFL)                       = 0x8002 (flags O_RDWR|O_LARGEFILE)
brk(0)                                  = 0x1a8b000
brk(0x1aac000)                          = 0x1aac000
fstat(3, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7fcb728ef000
lseek(3, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
write(3, "eventfd2: Invalid argument\n"..., 27eventfd2: Invalid argument
) = 27
close(3)                                = 0
munmap(0x7fcb728ef000, 4096)            = 0
exit_group(1)                           = ?

Here's the code block where it errors out:

        if ((fd1 = eventfd2(0, EFD_SEMLIKE)) == -1 ||
            (fd2 = eventfd2(0, EFD_SEMLIKE)) == -1) {
                perror("eventfd2");
                return 1;
        }

The manpage says it should return EINVAL for bad flags (because my
kernel's version is 2.6.29, which is newer than 2.6.27, the minimum
version). Doing a bit of research it looks like the values being fed
into eventfd2 are wrong, according to the documentation:

       EFD_NONBLOCK  Set  the O_NONBLOCK file status flag on the new open file
                     description.   Using  this  flag  saves  extra  calls  to
                     fcntl(2) to achieve the same result.

       EFD_CLOEXEC   Set  the  close-on-exec (FD_CLOEXEC) flag on the new file
                     descriptor.  See the description of the O_CLOEXEC flag in
                     open(2) for reasons why this may be useful.

       In  Linux  up to version 2.6.26, the flags argument is unused, and must
       be specified as zero.

gcooper@orangebox /scratch/ltp-dev2/ltp $ egrep -r
'EFD_NONBLOCK|EFD_CLOEXEC' /usr/include/sys/eventfd.h
    EFD_CLOEXEC = 02000000,
#define EFD_CLOEXEC EFD_CLOEXEC
    EFD_NONBLOCK = 04000
#define EFD_NONBLOCK EFD_NONBLOCK
gcooper@orangebox /scratch/ltp-dev2/ltp $ egrep -r 'EFD_SEMLIKE'
/usr/include/sys/eventfd.h
gcooper@orangebox /scratch/ltp-dev2/ltp $ grep -r 1 /usr/include/sys/eventfd.h
   version 2.1 of the License, or (at your option) any later version.
   02111-1307 USA.  */
#define _SYS_EVENTFD_H  1

So, what should we define the flag to to fix this test, or should it
just be marked broken on 2.6.29?

Thanks,
-Garrett

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
