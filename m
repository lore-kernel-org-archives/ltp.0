From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Jan 2019 18:24:02 +0100
Subject: [LTP] [PATCH 6/6] ima/ima_violations: Temporarily remove the
 printk rate limit
In-Reply-To: <698e6865-d0af-f71e-d51e-c4791ef1a096@linux.alibaba.com>
References: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547518476-34008-7-git-send-email-zhang.jia@linux.alibaba.com>
 <20190115150759.GA2954@dell5510>
 <698e6865-d0af-f71e-d51e-c4791ef1a096@linux.alibaba.com>
Message-ID: <20190115172401.GC2954@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jia,

> >> +	reset_printk_ratelimit
> > This should be called in cleanup function.
> > Actually as it's called only once I'd put it into cleanup function.

> I recognized that ima_setup.sh already defines a cleanup() so I cannot
> define another cleanup function in ima_violations.sh. Do you mean moving
> reset_printk_ratelimit into cleanup() defined in ima_setup.sh?
No. You can define redefine local cleanup function in ima_violations.sh after
loading ima_setup.sh and call ima_cleanup() in it.

+ you can change setup in ima_setup.sh:
TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
(see testcases/network/stress/ipsec/ipsec_lib.sh and testcases/network/stress/ipsec/ipsec_lib.sh and it's usage).

Cleanup of something defined in setup should be always in cleanup function and
not in any tests as it's called always after tst_brk() calls (some tests might
get skipped, so cleanup cannot be in them).

Kind regards,
Petr
