From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 25 Apr 2016 10:35:32 -0400 (EDT)
Subject: [LTP] [PATCH v3 5/5] kernel/syscalls: add new test with 'open()
 +	O_TMPFILE'
In-Reply-To: <1454069150-27889-6-git-send-email-alexey.kodanev@oracle.com>
References: <1454069150-27889-1-git-send-email-alexey.kodanev@oracle.com>
 <1454069150-27889-6-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1689676802.79541.1461594932412.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Alexey Kodanev" <alexey.kodanev@oracle.com>
> To: ltp@lists.linux.it
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>
> Sent: Friday, 29 January, 2016 1:05:50 PM
> Subject: [LTP] [PATCH v3 5/5] kernel/syscalls: add new test with 'open() +	O_TMPFILE'
> 
> Test does the following steps:
> * create an unnamed temporary file in TMP directory,
> * write data into it,
> * check that file not visible in the filesystem,
> * name the file and check that it becomes visible in FS,
> * create multiple directories and related temporary files,
> * create multiple directories and link files into them. Check
>   that files permissions correspond to the ones specified with
>   open()/openat().
> 
> 'openat() + O_TMPFILE' test repeats the same steps.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>

Alexey,

do you know if this maybe depends on some config option or
support on glibc side?

I'm running 4.5 kernel and both open14 and openat03 are failing
for me. I tried xfs and ext4, both failed.

...
chdir("/tmp/opepC2qHH")                 = 0
openat(AT_FDCWD, ".", O_RDWR|O_DIRECTORY|0x400000) = 3
close(3)                                = 0
umask(0)                                = 022
umask(022)                              = 0
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
mmap(NULL, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3ff816c0000
write(1, "open14      0  TINFO  :  create "..., 75open14      0  TINFO  :  create multiple directories, link files into them
) = 75
write(1, "open14      0  TINFO  :  and che"..., 52open14      0  TINFO  :  and check file permissions
) = 52
mkdirat(AT_FDCWD, "tst03_0", 0700)      = 0
chdir("tst03_0")                        = 0
openat(AT_FDCWD, ".", O_RDWR|O_DIRECTORY|0x400000) = 3
write(3, "\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1"..., 1024) = 1024
write(3, "\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1"..., 1024) = 1024
write(3, "\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1"..., 1024) = 1024
write(3, "\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1"..., 1024) = 1024
lseek(3, 0, SEEK_SET)                   = 0
read(3, "\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1"..., 1024) = 1024
read(3, "\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1"..., 1024) = 1024
read(3, "\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1"..., 1024) = 1024
read(3, "\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1"..., 1024) = 1024
linkat(AT_FDCWD, "/proc/self/fd/3", AT_FDCWD, "tmpfile_3", AT_SYMLINK_FOLLOW) = 0
newfstatat(AT_FDCWD, "tmpfile_3", {st_mode=S_IFREG, st_size=4096, ...}, AT_SYMLINK_NOFOLLOW) = 0
write(1, "open14      1  TFAIL  :  open14."..., 74open14      1  TFAIL  :  open14.c:212: file mode read 0, but expected 755

Regards,
Jan
