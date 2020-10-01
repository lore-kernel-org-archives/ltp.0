From: Petr Vorel <petr.vorel@gmail.com>
Date: Fri, 2 Oct 2020 01:21:43 +0200
Subject: [LTP] [RFC PATCH 1/1] lapi: Add sysinfo.h to fix build with
 MUSL libc
In-Reply-To: <20201001231256.6930-1-petr.vorel@gmail.com>
References: <20201001231256.6930-1-petr.vorel@gmail.com>
Message-ID: <20201001232143.GA32085@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> The reason is to avoid indirect <linux/sysinfo.h> include when using
> some UAPI headers: <linux/netlink.h> or others -> <linux/kernel.h>
> -> <linux/sysinfo.h>

> This indirect include causes on MUSL redefinition of struct sysinfo when
> included both <sys/sysinfo.h> and some of UAPI headers:

> In file included from x86_64-buildroot-linux-musl/sysroot/usr/include/linux/kernel.h:5,
>                  from x86_64-buildroot-linux-musl/sysroot/usr/include/linux/netlink.h:5,
>                  from ../include/tst_netlink.h:14,
>                  from tst_crypto.c:13:
> x86_64-buildroot-linux-musl/sysroot/usr/include/linux/sysinfo.h:8:8: error: redefinition of ?struct sysinfo?
>  struct sysinfo {
>         ^~~~~~~
> In file included from ../include/tst_safe_macros.h:15,
>                  from ../include/tst_test.h:93,
>                  from tst_crypto.c:11:
> x86_64-buildroot-linux-musl/sysroot/usr/include/sys/sysinfo.h:10:8: note: originally defined here

FYI commit which introduced the problem is 39aabfbd0 ("Add SAFE_SYSINFO() macro").

Alpine linux has patched kernel header, that's why our travis test didn't catch that.
https://git.alpinelinux.org/aports/tree/main/linux-headers/0003-remove-inclusion-of-sysinfo.h-in-kernel.h.patch

Kind regards,
Petr
