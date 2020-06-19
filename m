From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Jun 2020 10:56:07 +0800
Subject: [LTP] [PATCH] network/nsf_lib.sh: TCONF on mount (udp/udp6)
 failure for Linux v5.6+
In-Reply-To: <20200618134945.GA21692@dell5510>
References: <20200617154926.32588-1-alexey.kodanev@oracle.com>
 <CAEemH2dOxAnaaMXhKyj36FqmYDQ_p_kfi-=pMQhrE3O9oQO8LA@mail.gmail.com>
 <20200618055105.GA42990@x230> <20200618093646.GA11962@dell5510>
 <8b5eef18-1c3e-d89c-9af2-b27828f3cb02@oracle.com>
 <20200618134945.GA21692@dell5510>
Message-ID: <CAEemH2d1Qkv114Fpy=Np-eNPic7VymQJDSrGayt0oUpRY1k8uw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr, Alexey,

On Thu, Jun 18, 2020 at 9:49 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li, Alexey, Cyril,
>
> > > Requiring kernel config is ok for traditional distros (and even here is
> > > sometimes readable only for root, e.g. Debian/Ubuntu), but it's still
> rare on
> > > arm (other embedded archs). I guess it'd be nice to have some
> variable, which
> > > would turn kernel config based requirement into warning.
>
>
> > Also the option's name can be renamed in new releases, so the decision
> > should be made only if the option is found (i.e. if we check without the
> > the kernel version).
> FYI (you may have noticed) there was an effort to add boolean OR for C
> implementation:
> https://patchwork.ozlabs.org/project/ltp/list/?series=149804&state=*
>
> > tst_check_kconfig - will be really nice to have.
> +1. Is anybody planning to work on it?
>

I have no plan to work on this, but my pleasure to help review/test
the patch if possible.


>
> > Then, we will tconf
> > earlier in the setup if this option is found.
>
> > What about TCONF_IF_KCONFIG, in addition to NEEDS_KCONFIG?
> +1 (+ add it to C as well).
>
NEEDS_KCONFIG - this is optional to me, my previous thought is
only to have tst_check_kconfig to match the situation we need to
perform some special commands for the kernel with different kconfig,
but it is also acceptable to TCONF in setup phase like what we do in
C library.

TCONF_IF_KCONFIG - And I haven't realized what the TCONF_IF_KCONFIG
the behavior here, maybe needs read code then.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200619/ee10551f/attachment.htm>
