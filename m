From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 May 2020 11:23:46 +0200
Subject: [LTP] [PATCH v5 4/4] umip_basic_test.c: improve kconfig
 verification to avoid umip wrong abort case
In-Reply-To: <20200526023233.GA14105@xpf-desktop.sh.intel.com>
References: <20191220092529.3239-1-pengfei.xu@intel.com>
 <20191220092529.3239-4-pengfei.xu@intel.com>
 <20200525212401.GA30581@dell5510>
 <20200526023233.GA14105@xpf-desktop.sh.intel.com>
Message-ID: <20200526092346.GB10775@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

...
> > Thanks for a report and your effort to fix the problem. But this does not work,
> > because current implementation does not support '|' as bitwise or, with this
> > patch will result on tests being skipped for both cases.
>   CONFIG_A|CONFIG_B=y means CONGIG_A or CONGIG_B equal 'y', it will meet the
>   test condition. So it's as expected; only could not find CONFIG_A and
>   CONFIG_B equal to 'y', then it will not meet the test condition and exit.
>   It should be as expected.
>   Thank you for considering this patch again.

Well, I understand your syntax, that you mean | as bitwise or :).
But where did you find that this syntax is supported? Have a look in
tst_kconfig_read() implementation (lib/tst_kconfig.c), there is nothing like
this. And, indeed, if you test your patch on both CONFIG_X86_INTEL_UMIP=y and
CONFIG_X86_UMIP=y, it end up with:

tst_kconfig.c:252: INFO: Missing kernel CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y
tst_kconfig.c:284: CONF: Aborting due to unsuitable kernel config, see above!

which confirm my statement there is no bitwise or support implemented :).
Or am I missing something?

And it might be questionable if CONFIG_A|CONFIG_B=y would mean (CONFIG_A|CONFIG_B)=y
or (CONFIG_A|CONFIG_B=y), thus it should be CONFIG_A=y|CONFIG_B=y

But given the fact this functionality is needed just for a single test and can
be workarounded I suggested to use LINUX_VERSION_CODE instead.
The only problem can happen when this is backported to the old code. But we
could also try to detect that with custom call twice tst_kconfig_read() in the
test setup.

Kind regards,
Petr

> > While it'd be easy to implement support for bitwise or in tst_kconfig_read(),
> > it might be enough just to check for kernel version:

> > .needs_kconfigs = (const char *[]) {
> > #if LINUX_VERSION_CODE < KERNEL_VERSION(5, 5, 0)
> > 	"CONFIG_X86_INTEL_UMIP=y",
> > #else
> > 	"CONFIG_X86_UMIP=y",
> > #endif

> > But that will work unless this feature is not backported (IMHO commit
> > b971880fe79f ("x86/Kconfig: Rename UMIP config parameter") is kind of cleanup,
> > therefore unlikely to be backported, but it can happen).

> > Kind regards,
> > Petr
