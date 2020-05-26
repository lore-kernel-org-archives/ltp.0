From: Pengfei Xu <pengfei.xu@intel.com>
Date: Tue, 26 May 2020 18:07:00 +0800
Subject: [LTP] [PATCH v5 4/4] umip_basic_test.c: improve kconfig
 verification to avoid umip wrong abort case
In-Reply-To: <20200526092703.GC10775@dell5510>
References: <20191220092529.3239-1-pengfei.xu@intel.com>
 <20191220092529.3239-4-pengfei.xu@intel.com>
 <20200525212401.GA30581@dell5510>
 <20200526023233.GA14105@xpf-desktop.sh.intel.com>
 <20200526092346.GB10775@dell5510> <20200526092703.GC10775@dell5510>
Message-ID: <20200526100700.GA24819@xpf-desktop.sh.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 2020-05-26 at 11:27:03 +0200, Petr Vorel wrote:
> Hi Xu,
> 
> > ...
> > > > Thanks for a report and your effort to fix the problem. But this does not work,
> > > > because current implementation does not support '|' as bitwise or, with this
> > > > patch will result on tests being skipped for both cases.
> > >   CONFIG_A|CONFIG_B=y means CONGIG_A or CONGIG_B equal 'y', it will meet the
> > >   test condition. So it's as expected; only could not find CONFIG_A and
> > >   CONFIG_B equal to 'y', then it will not meet the test condition and exit.
> > >   It should be as expected.
> > >   Thank you for considering this patch again.
> 
> > Well, I understand your syntax, that you mean | as bitwise or :).
> > But where did you find that this syntax is supported? Have a look in
> > tst_kconfig_read() implementation (lib/tst_kconfig.c), there is nothing like
> > this. And, indeed, if you test your patch on both CONFIG_X86_INTEL_UMIP=y and
> > CONFIG_X86_UMIP=y, it end up with:
> 
> > tst_kconfig.c:252: INFO: Missing kernel CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y
> > tst_kconfig.c:284: CONF: Aborting due to unsuitable kernel config, see above!
> 
> > which confirm my statement there is no bitwise or support implemented :).
> > Or am I missing something?
> 
> OK I now realized, that it's a 4th patch of patchset. I thought it's just single
> patch, because the rest was rejected by Cyril:
> https://patchwork.ozlabs.org/project/ltp/list/?series=149804&state=*
> 
> But it looks like Cyril is not against the implementation, it just needs to be
> fixed:
> https://patchwork.ozlabs.org/comment/2352151/

You are right, actually it could be worked as my suggest way:
"CONFIG_A|CONFIG_B=Y".
I tried to use Cyril's advice "CONFIG_A=X|CONFIG_B=Y" way, which will
add more code complexity, so I just want to solve the problem I am currently
facing.
If we really need the "CONFIG_A=X|CONFIG_B=Y" function, which cannot be
satisfied by "CONFIG_A|CONFIG_B=Y" function in the future, then we could add
this function I think.
Thanks for your considering.

BR
Thanks!

Pengfei

> 
> Kind regards,
> Petr
