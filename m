From: Pengfei Xu <pengfei.xu@intel.com>
Date: Tue, 26 May 2020 10:32:33 +0800
Subject: [LTP] [PATCH v5 4/4] umip_basic_test.c: improve kconfig
 verification to avoid umip wrong abort case
In-Reply-To: <20200525212401.GA30581@dell5510>
References: <20191220092529.3239-1-pengfei.xu@intel.com>
 <20191220092529.3239-4-pengfei.xu@intel.com>
 <20200525212401.GA30581@dell5510>
Message-ID: <20200526023233.GA14105@xpf-desktop.sh.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
  Thanks and my feedback is as below.

  Thanks.
  BR.

On 2020-05-25 at 23:24:01 +0200, Petr Vorel wrote:
> Hi Xu,
> 
> > From v5.5 main line, umip kconfig changed from "CONFIG_X86_INTEL_UMIP=y"
> > to "CONFIG_X86_UMIP=y".
> > We could use "CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y" to check kconfig
> > CONFIG_X86_INTEL_UMIP=y(old kernel) or CONFIG_X86_UMIP=y(new kernel) for umip.
> 
> > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> > ---
> >  testcases/kernel/security/umip/umip_basic_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > diff --git a/testcases/kernel/security/umip/umip_basic_test.c b/testcases/kernel/security/umip/umip_basic_test.c
> > index 1baa26c52..24eca8890 100644
> > --- a/testcases/kernel/security/umip/umip_basic_test.c
> > +++ b/testcases/kernel/security/umip/umip_basic_test.c
> > @@ -171,7 +171,7 @@ static struct tst_test test = {
> >  	.forks_child = 1,
> >  	.test = verify_umip_instruction,
> >  	.needs_kconfigs = (const char *[]){
> > -		"CONFIG_X86_INTEL_UMIP=y",
> > +		"CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y",
> 
> We're sorry to get to your patch now, after 5 months.
> 
> Thanks for a report and your effort to fix the problem. But this does not work,
> because current implementation does not support '|' as bitwise or, with this
> patch will result on tests being skipped for both cases.
  CONFIG_A|CONFIG_B=y means CONGIG_A or CONGIG_B equal 'y', it will meet the
  test condition. So it's as expected; only could not find CONFIG_A and
  CONFIG_B equal to 'y', then it will not meet the test condition and exit.
  It should be as expected.
  Thank you for considering this patch again.

> 
> While it'd be easy to implement support for bitwise or in tst_kconfig_read(),
> it might be enough just to check for kernel version:
> 
> .needs_kconfigs = (const char *[]){
> #if LINUX_VERSION_CODE < KERNEL_VERSION(5, 5, 0)
> 	"CONFIG_X86_INTEL_UMIP=y",
> #else
> 	"CONFIG_X86_UMIP=y",
> #endif
> 
> But that will work unless this feature is not backported (IMHO commit
> b971880fe79f ("x86/Kconfig: Rename UMIP config parameter") is kind of cleanup,
> therefore unlikely to be backported, but it can happen).
> 
> Kind regards,
> Petr
