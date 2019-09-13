From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Sep 2019 12:41:42 +0200
Subject: [LTP] [PATCH 3/3] net/if-mtu-change.sh: set LTP_TIMEOUT
In-Reply-To: <1568368812.3306.7.camel@suse.de>
References: <20190912201318.30931-1-pvorel@suse.cz>
 <20190912201318.30931-4-pvorel@suse.cz>
 <1568368812.3306.7.camel@suse.de>
Message-ID: <20190913104142.GA598@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clements,

> > +LTP_TIMEOUT=$(((CHANGE_INTERVAL + 30) * MTU_CHANGE_TIMES))

>    ^
>    TST_TIMEOUT

> At least I would go with TST_ instead of LTP_ as the prefix TST_ means
> for me Libray and LTP_ user. This apply to some other places of this
> patchset.
Good point. Metan, do we want TST_TIMEOUT for library and LTP_TIMEOUT_MUL for
user? That's a bit strange, but I'd be for it.
LTP_* is for user to define (that's actually not true for tst_net.sh)
and TST_* for test definitions in script.

Kind regards,
Petr
