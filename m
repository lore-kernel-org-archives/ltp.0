From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 5 Jun 2020 11:37:46 +0200
Subject: [LTP] [PATCH 1/1] tst_taint.h Add taint for randstruct
In-Reply-To: <20200528111504.12638-1-pvorel@suse.cz>
References: <20200528111504.12638-1-pvorel@suse.cz>
Message-ID: <20200605093746.GA23001@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> +++ b/include/tst_taint.h
> @@ -60,7 +60,8 @@
#define TST_TAINT_G     (1 <<  0) /* a module with non-GPL license loaded */

one more note. I'd rename TST_TAINT_G to TST_TAINT_P, it's misleading, we use it
to use it for 'P' (proprietary module loaded).

Also we use taint_flag.c_true, not taint_flag.c_false:
[ TAINT_PROPRIETARY_MODULE ]    = { 'P', 'G', true },

But this flag hasn't been used, it might be always as placeholder (never
actually needed).

Kind regards,
Petr
