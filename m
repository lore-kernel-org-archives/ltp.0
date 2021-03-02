From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Mar 2021 12:43:29 +0530
Subject: [LTP] [PATCH 5.11 000/774] 5.11.3-rc2 review
In-Reply-To: <20210301193729.179652916@linuxfoundation.org>
References: <20210301193729.179652916@linuxfoundation.org>
Message-ID: <CA+G9fYs+RueaArJXTswcX_7O4xezuJXkOUVDgXnPrtkErp7Q1Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 2 Mar 2021 at 01:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.11.3 release.
> There are 774 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Mar 2021 19:35:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.11.3-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro?s test farm.
Regressions detected on all devices (arm64, arm, x86_64 and i386).

hangup01    1  TFAIL  :  hangup01.c:133: unexpected message 3

This failure is specific to stable-rc 5.10 and 5.11.
Test PASS on mainline and Linux next kernel.

Summary
------------------------------------------------------------------------

kernel: 5.11.3-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-5.11.y
git commit: 687a937c5987c23a8caf2466a827657c09dda0ca
git describe: v5.11.2-775-g687a937c5987
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.11.y/build/v5.11.2-775-g687a937c5987

Regressions (compared to build v5.11.2)
------------------------------------------------------------------------

  ltp-pty-tests:
    * hangup01

hangup01    1  TFAIL  :  hangup01.c:133: unexpected message 3

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Strace output:
------------------

+ cd /opt/ltp/testcases/bin/
+ strace -f ./hangup01
execve(\"./hangup01\", [\"./hangup01\"], 0xbed15d14 /* 18 vars */) = 0
brk(NULL)                               = 0x43000
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb6feb000
access(\"/etc/ld.so.preload\", R_OK)      = -1 ENOENT (No such file or
directory)
openat(AT_FDCWD, \"/etc/ld.so.cache\", O_RDONLY|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=19813, ...}) = 0
mmap2(NULL, 19813, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb6fe6000
close(3)                                = 0
openat(AT_FDCWD, \"/lib/libc.so.6\", O_RDONLY|O_CLOEXEC) = 3
read(3, \"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\\r\1\0004\0\0\0\"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1238788, ...}) = 0
mmap2(NULL, 1308016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb6e7d000
mprotect(0xb6fa8000, 61440, PROT_NONE)  = 0
mmap2(0xb6fb7000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12a000) = 0xb6fb7000
mmap2(0xb6fba000, 9584, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb6fba000
close(3)                                = 0
set_tls(0xb6febd10, 0xb6fec400, 0xb6fee000, 0xb6febd10, 0xb6fee000) = 0
mprotect(0xb6fb7000, 8192, PROT_READ)   = 0
mprotect(0x3c000, 4096, PROT_READ)      = 0
mprotect(0xb6fed000, 4096, PROT_READ)   = 0
munmap(0xb6fe6000, 19813)               = 0
openat(AT_FDCWD, \"/dev/ptmx\", O_RDWR)   = 3
ioctl(3, TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(3, TIOCGPTN, [0])                 = 0
stat64(\"/dev/pts/0\", {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
ioctl(3, TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(3, TIOCGPTN, [0])                 = 0
stat64(\"/dev/pts/0\", {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
getuid32()                              = 0
socket(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) = 4
connect(4, {sa_family=AF_UNIX, sun_path=\"/var/run/nscd/socket\"},
110) = -1 ENOENT (No such file or directory)
close(4)                                = 0
socket(AF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0) = 4
connect(4, {sa_family=AF_UNIX, sun_path=\"/var/run/nscd/socket\"},
110) = -1 ENOENT (No such file or directory)
close(4)                                = 0
brk(NULL)                               = 0x43000
brk(0x64000)                            = 0x64000
openat(AT_FDCWD, \"/etc/nsswitch.conf\", O_RDONLY|O_CLOEXEC) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=514, ...}) = 0
read(4, \"# /etc/nsswitch.conf\n#\n# Example\"..., 4096) = 514
read(4, \"\", 4096)                       = 0
close(4)                                = 0
openat(AT_FDCWD, \"/etc/ld.so.cache\", O_RDONLY|O_CLOEXEC) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=19813, ...}) = 0
mmap2(NULL, 19813, PROT_READ, MAP_PRIVATE, 4, 0) = 0xb6fe6000
close(4)                                = 0
openat(AT_FDCWD, \"/lib/libnss_compat.so.2\", O_RDONLY|O_CLOEXEC) = 4
read(4, \"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\350\f\0\0004\0\0\0\"...,
512) = 512
fstat64(4, {st_mode=S_IFREG|0755, st_size=26332, ...}) = 0
mmap2(NULL, 91760, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 4,
0) = 0xb6e66000
mprotect(0xb6e6c000, 61440, PROT_NONE)  = 0
mmap2(0xb6e7b000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0x5000) = 0xb6e7b000
close(4)                                = 0
mprotect(0xb6e7b000, 4096, PROT_READ)   = 0
munmap(0xb6fe6000, 19813)               = 0
openat(AT_FDCWD, \"/etc/ld.so.cache\", O_RDONLY|O_CLOEXEC) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=19813, ...}) = 0
mmap2(NULL, 19813, PROT_READ, MAP_PRIVATE, 4, 0) = 0xb6fe6000
close(4)                                = 0
openat(AT_FDCWD, \"/lib/libnss_nis.so.2\", O_RDONLY|O_CLOEXEC) = 4
read(4, \"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\350\27\0\0004\0\0\0\"...,
512) = 512
fstat64(4, {st_mode=S_IFREG|0755, st_size=38456, ...}) = 0
mmap2(NULL, 103004, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 4,
0) = 0xb6e4c000
mprotect(0xb6e55000, 61440, PROT_NONE)  = 0
mmap2(0xb6e64000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0x8000) = 0xb6e64000
close(4)                                = 0
openat(AT_FDCWD, \"/lib/libnsl.so.1\", O_RDONLY|O_CLOEXEC) = 4
read(4, \"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\334.\0\0004\0\0\0\"...,
512) = 512
fstat64(4, {st_mode=S_IFREG|0755, st_size=67384, ...}) = 0
mmap2(NULL, 141056, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 4,
0) = 0xb6e29000
mprotect(0xb6e39000, 61440, PROT_NONE)  = 0
mmap2(0xb6e48000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0xf000) = 0xb6e48000
mmap2(0xb6e4a000, 5888, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb6e4a000
close(4)                                = 0
openat(AT_FDCWD, \"/lib/libnss_files.so.2\", O_RDONLY|O_CLOEXEC) = 4
read(4, \"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0008\32\0\0004\0\0\0\"...,
512) = 512
fstat64(4, {st_mode=S_IFREG|0755, st_size=38448, ...}) = 0
mmap2(NULL, 127752, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 4,
0) = 0xb6e09000
mprotect(0xb6e12000, 61440, PROT_NONE)  = 0
mmap2(0xb6e21000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 4, 0x8000) = 0xb6e21000
mmap2(0xb6e23000, 21256, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb6e23000
close(4)                                = 0
mprotect(0xb6e21000, 4096, PROT_READ)   = 0
mprotect(0xb6e48000, 4096, PROT_READ)   = 0
mprotect(0xb6e64000, 4096, PROT_READ)   = 0
munmap(0xb6fe6000, 19813)               = 0
openat(AT_FDCWD, \"/etc/group\", O_RDONLY|O_CLOEXEC) = 4
_llseek(4, 0, [0], SEEK_CUR)            = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=756, ...}) = 0
mmap2(NULL, 756, PROT_READ, MAP_SHARED, 4, 0) = 0xb6fea000
_llseek(4, 756, [756], SEEK_SET)        = 0
munmap(0xb6fea000, 756)                 = 0
close(4)                                = 0
ioctl(3, TIOCSPTLCK, [0])               = 0
clone(child_stack=NULL,
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
child_tidptr=0xb6feb8b8) = 366
nanosleep({tv_sec=1, tv_nsec=0}, strace: Process 366 attached
 <unfinished ...>
[pid   366] ioctl(3, TCGETS, {B38400 opost isig icanon echo ...}) = 0
[pid   366] ioctl(3, TIOCGPTN, [0])     = 0
[pid   366] stat64(\"/dev/pts/0\", {st_mode=S_IFCHR|0620,
st_rdev=makedev(136, 0), ...}) = 0
[pid   366] openat(AT_FDCWD, \"/dev/pts/0\", O_RDWR) = 4
[pid   366] write(4, \"I love Linux!\", 13) = 13
[pid   366] close(4)                    = 0
[pid   366] openat(AT_FDCWD, \"/dev/pts/0\", O_RDWR) = 4
[pid   366] write(4, \"Use the LTP for all your Linux t\"..., 45) = 45
[pid   366] close(4)                    = 0
[pid   366] openat(AT_FDCWD, \"/dev/pts/0\", O_RDWR) = 4
[pid   366] write(4, \"For the latest version of the LT\"..., 73) = 73
[pid   366] close(4)                    = 0
[pid   366] exit_group(0)               = ?
[pid   366] +++ exited with 0 +++
<... nanosleep resumed> {tv_sec=0, tv_nsec=957592940}) = ?
ERESTART_RESTARTBLOCK (Interrupted by signal)
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=366,
si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
nanosleep({tv_sec=0, tv_nsec=957592940}, 0xbeeceb48) = 0
poll([{fd=3, events=POLLIN}], 1, -1)    = 1 ([{fd=3, revents=POLLIN|POLLHUP}])
read(3, \"I love Linux!\", 13)            = 13
poll([{fd=3, events=POLLIN}], 1, -1)    = 1 ([{fd=3, revents=POLLIN|POLLHUP}])
read(3, \"Use the LTP for all your Linux t\"..., 45) = 45
poll([{fd=3, events=POLLIN}], 1, -1)    = 1 ([{fd=3, revents=POLLIN|POLLHUP}])
read(3, \"For the latest version of the LT\"..., 73) = 64
ioctl(1, TCGETS, {B115200 opost isig icanon echo ...}) = 0
fstat64(1, {st_mode=S_IFCHR|0600, st_rdev=makedev(204, 64), ...}) = 0
ioctl(1, TCGETS, {B115200 opost isig icanon echo ...}) = 0
write(1, \"hangup01    1  TFAIL \"..., 73hangup01    1  TFAIL  :
hangup01.c:133: unexpected message 3
) = 73


Test case link:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/pty/hangup01.c#L133

Full test log link,
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.11.y/build/v5.11.2-775-g687a937c5987/testrun/4055638/suite/ltp-pty-tests/test/hangup01/log

Test results comparison between 5.10, 5.11, Linux mainline and Linux
next master.
https://qa-reports.linaro.org/_/comparetest/?project=651&project=597&project=22&project=6&suite=ltp-pty-tests&test=hangup01


-- 
Linaro LKFT
https://lkft.linaro.org
