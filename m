From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Apr 2019 15:58:15 +0200
Subject: [LTP] [PATCH] Makefile: Remove IDcheck.sh
In-Reply-To: <20190408152145.29005-1-chrubis@suse.cz>
References: <20190408152145.29005-1-chrubis@suse.cz>
Message-ID: <20190412135815.GA15132@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> There is no point in running the IDcheck on 'make install' as it's
> completely pointless to print ignored errors on installation which is
> only confusing users.
+1

> Also the same script is even executed as a part of runltp script which
> is more appropriate place for it.

+1

I hope to implement one day tst_user() and tst_group() [1].
Than IDcheck.sh could be removed :).

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/468
