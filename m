From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Jun 2018 15:41:27 +0200
Subject: [LTP] [PATCH v2] memcg: functional: 4.16 kernel updates stat
 counter in a batch of 33 pages
In-Reply-To: <1528412177-51227-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1528412177-51227-1-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <20180628134127.frazjrk2aireq5ec@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,


> Due to upstream kernel commit a983b5ebee57209c99f68c8327072f25e0e6e3da
> ("mm: memcontrol: fix excessive complexity in memory.stat reporting"),
> memory.stat is updated in a batch of 33 pages. This results in some test
> cases fail at checking stat counter since they just touch one page.

> Introduce PAGESIZES, which is 33 * PAGESIZE, used by affected test
> cases, keep others still use PAGESIZE. And, this change doesn't break
> pre-4.16 kernel.

> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> v1 --> v2:
> * Rename TST_PAGESIZE to PAGESIZES per Li Wang's suggestion

Pushed, thanks!


Kind regards,
Petr
