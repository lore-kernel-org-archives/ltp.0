From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Sep 2019 15:58:04 +0200
Subject: [LTP] Kdump update required
In-Reply-To: <VI1PR0101MB2557DC78E7B6994F8429AE11F0B30@VI1PR0101MB2557.eurprd01.prod.exchangelabs.com>
References: <VI1PR0101MB2557DC78E7B6994F8429AE11F0B30@VI1PR0101MB2557.eurprd01.prod.exchangelabs.com>
Message-ID: <20190913135803.GC7939@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am writing to you about the kdump. I am trying to run kdump on Debian 9 (Stretch), but the "setup.sh" has a small error as you can see below, based on the error received:
> 
>   CC      /root/Desktop/ltp/testcases/kdump/lib/lkdtm/lkdtm.mod.o
>   LD [M]  /root/Desktop/ltp/testcases/kdump/lib/lkdtm/lkdtm.ko
> make[3]: Leaving directory '/usr/src/linux-headers-4.9.0-9-amd64'
> make[2]: Leaving directory '/root/Desktop/ltp/testcases/kdump/lib/lkdtm'
> make[1]: Leaving directory '/root/Desktop/ltp/testcases/kdump/lib'
> + echo Modify Boot Loader.
> Modify Boot Loader.
> + [ x86_64 = ppc64 ]
> + [ x86_64 = i686 ]
> + [ x86_64 = ia64 ]
> + args=crashkernel=256M@128M
> + [ -x /sbin/grubby ]
> + echo Warn: please make sure the following arguments are in Boot Loader:
> Warn: please make sure the following arguments are in Boot Loader:
> + echo crashkernel=256M@128M
> crashkernel=256M@128M
> + echo Hit any key when ready.

This tells you to modify the bootloader command line by hand.

> Hit any key when ready.
> + read
> ./setup.sh: 105: read: arg count
> Makefile:2: recipe for target 'all' failed
> make: *** [all] Error 2

This is a harmless error caused by the fact that debian uses dash as a
default shell.

-- 
Cyril Hrubis
chrubis@suse.cz
