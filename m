From: Xiuzhe Xiao <xiuzhe.xiao@nautel.com>
Date: Thu, 15 Mar 2018 13:53:14 +0000
Subject: [LTP] SIGSEGV in faccessat01 and fchmodat01
In-Reply-To: <394159771.7727664.1521119689058.JavaMail.zimbra@redhat.com>
References: <BY2PR13MB070967D607D2E7F4F797189A90D10@BY2PR13MB0709.namprd13.prod.outlook.com>
 <20180315115518.GB17877@rei>
 <BY2PR13MB0709FB070D6A4AC6FEEE5DD990D00@BY2PR13MB0709.namprd13.prod.outlook.com>,
 <394159771.7727664.1521119689058.JavaMail.zimbra@redhat.com>
Message-ID: <BY2PR13MB07094FEA8F29D70D9213D7AF90D00@BY2PR13MB0709.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

(gdb) r
Starting program: /opt/ltp/testcases/bin/fchmodat01

Program received signal SIGSEGV, Segmentation fault.
strlen () at ../sysdeps/arm/strlen.S:33
33              sfi_breg r1, \
(gdb) bt
#0  strlen () at ../sysdeps/arm/strlen.S:33
#1  0x44583cfc in _IO_vfprintf_internal (s=s@entry=0x34030, format=format@entry=0x1c320 "%s/fchmodattest%d.txt", ap=..., ap@entry=...)
    at /usr/src/debug/glibc/2.25-r0/git/stdio-common/vfprintf.c:1637
#2  0x44624e64 in ___vfprintf_chk (fp=fp@entry=0x34030, flag=flag@entry=1, format=0x1c320 "%s/fchmodattest%d.txt",
    format@entry=0x33b64 <testfile2> "/tmp/fchBEt8Uu/fchmodattest816.txt", ap=..., ap@entry=...)
    at /usr/src/debug/glibc/2.25-r0/git/debug/vfprintf_chk.c:33
#3  0x0001383c in vfprintf (__ap=..., __fmt=0x33b64 <testfile2> "/tmp/fchBEt8Uu/fchmodattest816.txt", __stream=0x34030)
    at /usr/include/bits/stdio2.h:127
#4  safe_file_printf (file=file@entry=0x1c2b0 "fchmodat01.c", lineno=lineno@entry=131, cleanup_fn=cleanup_fn@entry=0x121a4 <cleanup>,
    path=path@entry=0x33b64 <testfile2> "/tmp/fchBEt8Uu/fchmodattest816.txt", fmt=fmt@entry=0x1c320 "%s/fchmodattest%d.txt")
    at /usr/src/debug/ltp/20170116-r0/git/lib/safe_file_ops.c:280
#5  0x00012384 in setup () at /usr/src/debug/ltp/20170116-r0/git/testcases/kernel/syscalls/fchmodat/fchmodat01.c:131
#6  0x00011f18 in main (ac=1, av=0xbefffdd4) at /usr/src/debug/ltp/20170116-r0/git/testcases/kernel/syscalls/fchmodat/fchmodat01.c:84
(gdb)

Kernel: 4.0.0-ADI-1.2.0-yocto-standard
LTP Version: 20170116
Distro : Poky (Yocto Project Reference Distro)
DIstro Version: pyro

The kernel was from Analog Device Inc, it is built for the board named ADSP-SC589
Sorry for the lack of information, please tell me if others needed.

Thanks
Shawnx.


________________________________
From: Jan Stancek <jstancek@redhat.com>
Sent: Thursday, March 15, 2018 6:14:49 AM
To: Xiuzhe Xiao
Cc: Cyril Hrubis; ltp@lists.linux.it
Subject: Re: [LTP] SIGSEGV in faccessat01 and fchmodat01


----- Original Message -----
>
>
> Hi

> Here is the result from gdb
> seems like it is getting really deep
>
>
>
> (gdb) r
> Starting program: /opt/ltp/testcases/bin/fchmodat01
>
> Program received signal SIGSEGV, Segmentation fault.
> strlen () at ../sysdeps/arm/strlen.S:33
> 33 sfi_breg r1, \
> (gdb)

Please send the backtrace as well. Type "bt" and hit enter in gdb
after it crashes.

What distro/kernel/LTP version are you using?

Regards,
Jan
This communication, including any attached documentation, is intended only for the person or entity to which it is addressed, and may contain confidential, personal, and/or privileged information. Any unauthorized disclosure, copying, or taking action on the contents is strictly prohibited. If you have received this message in error, please contact us immediately so we may correct our records. Please then delete or destroy the original transmission and any subsequent reply. Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180315/822d479d/attachment-0001.html>
