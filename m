From: Li Wang <liwang@redhat.com>
Date: Sat, 16 Jun 2018 12:15:14 +0800
Subject: [LTP] [PATCH] fcntl36: fix 32-bit sporadic failures
In-Reply-To: <8b5ddc69aae83b332b205dbeddb3284ab00f827e.1529082112.git.jstancek@redhat.com>
References: <8b5ddc69aae83b332b205dbeddb3284ab00f827e.1529082112.git.jstancek@redhat.com>
Message-ID: <CAEemH2e5Cwz=_AHG2KAi-zacdaL0BQBpN7Qtb89Gs7_SnO9fkw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Jun 16, 2018 at 1:22 AM, Jan Stancek <jstancek@redhat.com> wrote:
> fcntl36 testcase has been observed to sporadically fail, when
> running 32-bit user-space on 64-bit kernel.
>
> Strace shows that region length is 0 for some commands:
>   fcntl64(6, F_SETLK, {l_type=F_UNLCK, l_whence=SEEK_SET, l_start=5120, l_len=0}
>
> This is because testcase is passing struct flock64, but
> command is F_SETLK, not F_SETLK64.
>
> So, kernel treats argument for POSIX command as 32-bit "struct flock":
>
>   static long do_compat_fcntl64(unsigned int fd, unsigned int cmd,
>   ...
>         case F_SETLK:
>         case F_SETLKW:
>                 err = get_compat_flock(&flock, compat_ptr(arg));
>                 ...
>
> in contrast to F_OFD_* commands, where argument  is treated
> as "struct flock64":
>         case F_SETLK64:
>         case F_SETLKW64:
>         case F_OFD_SETLK:
>         case F_OFD_SETLKW:
>                 err = get_compat_flock64(&flock, compat_ptr(arg));
>                 ...
>
> Switch argument of POSIX commands to 'struct flock' and leave it to
> glibc to pick correct syscall and command.
>
> I tested fcntl36 and fcntl36_64 on x86_64 kernel (as 64bit + 32bit binary)
> and i386 kernel by running 100 iterations.

Sounds reasonable.

I can stably reproduce this issue on my raspbery Pi3, and with your
patch applied, the problem was gone.

[root@centos-rpi3 fcntl]# uname  -a
Linux centos-rpi3 4.9.13-v7.1.el7 #1 SMP Mon Feb 27 10:45:31 UTC 2017
armv7l armv7l armv7l GNU/Linux

[root@centos-rpi3 fcntl]# file fcntl36
fcntl36: ELF 32-bit LSB executable, ARM, version 1 (SYSV), dynamically
linked (uses shared libs), for GNU/Linux 2.6.32,
BuildID[sha1]=73d3a834d43361ecd4331d9b77781ea932a970cc, not stripped

[root@centos-rpi3 fcntl]# ./fcntl36
tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
fcntl36.c:303: INFO: OFD read lock vs OFD write lock
fcntl36.c:381: PASS: Access between threads synchronized
fcntl36.c:303: INFO: OFD write lock vs POSIX write lock
fcntl36.c:381: PASS: Access between threads synchronized
fcntl36.c:303: INFO: OFD read lock vs POSIX write lock
fcntl36.c:381: PASS: Access between threads synchronized
fcntl36.c:303: INFO: OFD write lock vs POSIX read lock
fcntl36.c:381: PASS: Access between threads synchronized
fcntl36.c:303: INFO: OFD write lock vs OFD write lock
fcntl36.c:381: PASS: Access between threads synchronized
fcntl36.c:303: INFO: OFD r/w lock vs POSIX write lock
fcntl36.c:381: PASS: Access between threads synchronized
fcntl36.c:303: INFO: OFD r/w lock vs POSIX read lock
fcntl36.c:381: PASS: Access between threads synchronized

Summary:
passed   7
failed   0
skipped  0
warnings 0


-- 
Regards,
Li Wang
