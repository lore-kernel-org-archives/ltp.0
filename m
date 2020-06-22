From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 22 Jun 2020 15:34:00 +0200
Subject: [LTP] [PATCH] network/nsf_lib.sh: TCONF on mount (udp/udp6)
 failure for Linux v5.6+
In-Reply-To: <20200618134945.GA21692@dell5510>
References: <20200617154926.32588-1-alexey.kodanev@oracle.com>
 <CAEemH2dOxAnaaMXhKyj36FqmYDQ_p_kfi-=pMQhrE3O9oQO8LA@mail.gmail.com>
 <20200618055105.GA42990@x230> <20200618093646.GA11962@dell5510>
 <8b5eef18-1c3e-d89c-9af2-b27828f3cb02@oracle.com>
 <20200618134945.GA21692@dell5510>
Message-ID: <20200622133239.GA6965@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> > Also the option's name can be renamed in new releases, so the decision
> > should be made only if the option is found (i.e. if we check without the
> > the kernel version).
> FYI (you may have noticed) there was an effort to add boolean OR for C
> implementation:
> https://patchwork.ozlabs.org/project/ltp/list/?series=149804&state=*

> > tst_check_kconfig - will be really nice to have.
> +1. Is anybody planning to work on it?

https://github.com/linux-test-project/ltp/issues/700
I'll try to implement it in July, unless somebody does it before.

> > Then, we will tconf
> > earlier in the setup if this option is found.

> > What about TCONF_IF_KCONFIG, in addition to NEEDS_KCONFIG?
> +1 (+ add it to C as well).
I'd prefer TWARN_IF_NO_CONFIG, more info in the ticket.

Kind regards,
Petr
