From: Leo Liang <ycliang@andestech.com>
Date: Fri, 15 Jan 2021 16:54:07 +0800
Subject: [LTP] [PATCH 1/1] device-drivers/zram: Fix false-judgement on
 zram's presence
In-Reply-To: <YABgDXi2WHSWmwHF@pevik>
References: <20210114074603.GB32318@andestech.com>
 <YABgDXi2WHSWmwHF@pevik>
Message-ID: <20210115085406.GA23267@andestech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On Thu, Jan 14, 2021 at 11:15:25PM +0800, Petr Vorel wrote:
> Hi Leo,
> 
> > zram_lib.sh uses the return value of modinfo to check if zram module exists,
> > but the behavior of modinfo implemented by busybox is different.
> 
> > The busybox-implemented modinfo would also return true (code: 0)
> > even if zram module is not present,
> > so grep the info that only shows when the module exists.
> 
> > -modinfo zram > /dev/null 2>&1 ||
> > +modinfo zram | grep "filename" > /dev/null 2>&1 ||
> nit: 
> modinfo zram | grep -q "filename" ||
> 
> >  	tst_brk TCONF "zram not configured in kernel"
> 
> Thank you for a report. Actually, we have a helper for it:
> TST_NEEDS_DRIVERS="zram"
> 
> But this helper is broken for BusyBox, which means it's broken for many tests.
> 
> The helper calls tst_check_driver() C function (lib/tst_kernel.c):
> 
> int tst_check_driver(const char *name)
> {
> #ifndef __ANDROID__
> 	const char * const argv[] = { "modprobe", "-n", name, NULL };
> 	int res = tst_cmd_(NULL, argv, "/dev/null", "/dev/null",
> 			       TST_CMD_PASS_RETVAL);
> 
> 	/* 255 - it looks like modprobe not available */
> 	return (res == 255) ? 0 : res;
> #else
> 	/* Android modprobe may not have '-n', or properly installed
> 	 * module.*.bin files to determine built-in drivers. Assume
> 	 * all drivers are available.
> 	 */
> 	return 0;
> #endif
> }
> 
> and the problem is that modprobe from busybox does not support -n.
> It does support -D, which could be used, *but* unless is busybox binary
> configured with CONFIG_MODPROBE_SMALL=y (IMHO the default) => not suitable
> for us.
> 
> IMHO we have only 2 options:
> * write something on our own which would look into /lib/modules and
> /system/lib/modules (Android). That's what BusyBox implementation does
> (also kmod implementation looks into /lib/modules). BusyBox has this path in
> defined in build time configuration (CONFIG_DEFAULT_MODULES_DIR), but I'd be
> surprised if any system had both directories.
> pros: no external dependency
> cons: more code
> 
> * use modinfo, but grep for output: for 'filename:' (turn Leo's suggestion into
> C code in the API):
> cons: module not checked, when modprobe missing (we check for 255 exit code).
> 

Thanks for breaking things down in such detail!

I personally prefer the first option that looking into those directories ourselves.
So let's drop this patch and stay as is for now!

> BTW not sure whether bother about android support anyway. On Android phone I
> have available (Android 8), there is empty /system/lib/modules directory and no
> /proc/modules:, thus nor BusyBox neither even toybox modprobe/modinfo
> implementations work.
 
BTW, I found that there's a ver_linux script that detects the version of util-linux.
But as I searched through commit log of LTP, there are a lot of workarounds
regarding the compatibility issue with Busybox (around 10 commits or so).

Is there a certain version of util-linux is expected to conduct a full run of LTP ?

Thanks again,
Leo

> Kind regards,
> Petr
