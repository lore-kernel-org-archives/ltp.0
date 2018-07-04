From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Jul 2018 17:56:14 +0200
Subject: [LTP] [PATCH v3 0/9] Migrate tests using virt_lib.sh
 and	ipsec_lib.sh to new API
In-Reply-To: <20180703074209.911-1-pvorel@suse.cz>
References: <20180703074209.911-1-pvorel@suse.cz>
Message-ID: <20180704155613.ww7dtrilp3tvo7vi@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> I addressed issues noted by Alexey
> changes v2->v3:
> * tst_net.sh: Added TST_LIB_NET_LOADED and simplify that commit.
> * tst_net.sh: changes in tst_net.sh split into 2 commits (TST_LIB_NET_LOADED related
> one and "Harden library against deadlocks")
> * macsec_lib.sh: Move code from virt_macsec_setup to macsec_lib_setup
> * virt_lib.sh: Remove unused client_requests=20000

> @cyril: tst_test.sh: We use TST_LIB_NET_LOADED (3/8), but I kept TST_LIB_LOADED
> (2/8) as I think it's an improvement, even not used yet.

> Petr Vorel (9):

Pushed whole patchset, I added your Reviewed-by as you did in previous
versions and suggested all the changes.
Thanks a lot!

Kind regards,
Petr
