From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Jun 2020 15:49:45 +0200
Subject: [LTP] [PATCH] network/nsf_lib.sh: TCONF on mount (udp/udp6)
 failure for Linux v5.6+
In-Reply-To: <8b5eef18-1c3e-d89c-9af2-b27828f3cb02@oracle.com>
References: <20200617154926.32588-1-alexey.kodanev@oracle.com>
 <CAEemH2dOxAnaaMXhKyj36FqmYDQ_p_kfi-=pMQhrE3O9oQO8LA@mail.gmail.com>
 <20200618055105.GA42990@x230> <20200618093646.GA11962@dell5510>
 <8b5eef18-1c3e-d89c-9af2-b27828f3cb02@oracle.com>
Message-ID: <20200618134945.GA21692@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Alexey, Cyril,

> > Requiring kernel config is ok for traditional distros (and even here is
> > sometimes readable only for root, e.g. Debian/Ubuntu), but it's still rare on
> > arm (other embedded archs). I guess it'd be nice to have some variable, which
> > would turn kernel config based requirement into warning.


> Also the option's name can be renamed in new releases, so the decision
> should be made only if the option is found (i.e. if we check without the
> the kernel version).
FYI (you may have noticed) there was an effort to add boolean OR for C
implementation:
https://patchwork.ozlabs.org/project/ltp/list/?series=149804&state=*

> tst_check_kconfig - will be really nice to have.
+1. Is anybody planning to work on it?

> Then, we will tconf
> earlier in the setup if this option is found.

> What about TCONF_IF_KCONFIG, in addition to NEEDS_KCONFIG?
+1 (+ add it to C as well).

Kind regards,
Petr
