From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Apr 2018 15:40:03 +0200
Subject: [LTP] [RFC PATCH v3 10/10] ima: Print /proc/cmdline and IMA
 kernel config
In-Reply-To: <20180425131620.GA27526@x230>
References: <20180424183556.2368-1-pvorel@suse.cz>
 <20180425074116.hic5a3nfunyxamcd@g206.suse.de>
 <20180425131620.GA27526@x230>
Message-ID: <20180425134003.GB24333@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Just a small remark here: not all distributions have /boot/config-* files
> > in place. I don't remember which ones this were.
> > Wouldn't it make sense to check this file, if it does not exist check
> > if /proc/config.gz is available? 
> I haven't found any normal distro not having config in place (openSUSE/SLE, Debian/Ubuntu,
> CentOS/Red Hat), but there might be some. I guess most of embedded devices don't have
> that (it's a question if they have IKCONFIG_PROC=y) but why not to try it.

Embedded usually dont have neither of them.

Also depending on the existence of /boot/config-* is really bad idea,
just imagine you compiled and kexeced testing kernel and testcases are
starting to fail for no good reason.

> I wonder if we'd benefit from having these functions in shell API:
> is_enabled(CONFIG_FOO)
> is_module(CONFIG_FOO)
> is_builtin(CONFIG_FOO)
> 
> which would do simple grep of either /boot/config-$(uname -r) or /proc/config.gz.

Generally you cannot detect features of the running kernel by the
/boot/config-* files. We tried that and it failed miserably.

We cannot rely on /proc/config.gz because many kernels have that
disabled to spare some space.

It's sad but the only reasonable way how to detect if kernel does
support something is to try to call the syscall/open and read sysfs
file/etc. and detect ENOSYS/ENOTTY/etc.

-- 
Cyril Hrubis
chrubis@suse.cz
