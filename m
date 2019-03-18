From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Mar 2019 20:10:41 +0100
Subject: [LTP] [PATCH v2 0/6] ltp: AF_ALG test helpers and a few
 regression tests
In-Reply-To: <20190318182747.GA5924@dell5510>
References: <20190318171327.237014-1-ebiggers@kernel.org>
 <20190318182747.GA5924@dell5510>
Message-ID: <20190318191041.GB5924@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Eric,

> > Changed since v1:

> >     - Define 'AF_ALG' in include/lapi/socket.h if undefined.
> >       Also move 'SOL_ALG' definition to there.
> The only minor issue is with missing SOL_ALG on older distros.

> Going to push it with this fix including lapi/socket.h on lib/tst_af_alg.c and
> testcases/kernel/crypto/af_alg01.c.

Merged with this small fix.

Kind regards,
Petr
