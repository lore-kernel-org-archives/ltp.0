From: Pengfei Xu <pengfei.xu@intel.com>
Date: Tue, 26 May 2020 18:37:08 +0800
Subject: [LTP] [PATCH v5 4/4] umip_basic_test.c: improve kconfig
 verification to avoid umip wrong abort case
In-Reply-To: <20200526101133.GA3114075@x230>
References: <20191220092529.3239-1-pengfei.xu@intel.com>
 <20191220092529.3239-4-pengfei.xu@intel.com>
 <20200525212401.GA30581@dell5510>
 <20200526023233.GA14105@xpf-desktop.sh.intel.com>
 <20200526092346.GB10775@dell5510> <20200526092703.GC10775@dell5510>
 <20200526100700.GA24819@xpf-desktop.sh.intel.com>
 <20200526101133.GA3114075@x230>
Message-ID: <20200526103708.GA26057@xpf-desktop.sh.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 2020-05-26 at 12:11:33 +0200, Petr Vorel wrote:
> Hi Pengfei,
> 
> > > But it looks like Cyril is not against the implementation, it just needs to be
> > > fixed:
> > > https://patchwork.ozlabs.org/comment/2352151/
> 
> > You are right, actually it could be worked as my suggest way:
> > "CONFIG_A|CONFIG_B=Y".
> > I tried to use Cyril's advice "CONFIG_A=X|CONFIG_B=Y" way, which will
> > add more code complexity, so I just want to solve the problem I am currently
> > facing.
> > If we really need the "CONFIG_A=X|CONFIG_B=Y" function, which cannot be
> > satisfied by "CONFIG_A|CONFIG_B=Y" function in the future, then we could add
> > this function I think.
> > Thanks for your considering.
> 
> I'd also think that we need "CONFIG_A=X|CONFIG_B=Y", because
> "CONFIG_A|CONFIG_B=Y" is ambiguous (we support both CONFIG_FOO and
> CONFIG_FOO=bar and this must stay even with |).
> 
> Will you send a patch for that or shell I fix it with LINUX_VERSION_CODE <
> KERNEL_VERSION for now?

  Ok, thanks for your LINUX_VERSION way to fix this issue.
  Thanks!
  BR.

> 
> Kind regards,
> Petr
