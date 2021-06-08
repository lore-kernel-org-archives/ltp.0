From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 8 Jun 2021 22:43:43 +0200
Subject: [LTP] [PATCH 1/7] getitimer02: Skipped EFAULT tests for libc
 variant.
In-Reply-To: <20210607104515.29838-1-vinay.m.engg@gmail.com>
References: <20210607104515.29838-1-vinay.m.engg@gmail.com>
Message-ID: <YL/Wf51Y6V5lRnkM@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Vinay,

> Tested EFAULT cases only for "__NR_getitimer" syscall.
Well, you added testing raw syscall via test variant.
That's IMHO the most important thing to mention.

In the text after blank line I'd mention EFAULT skipped on raw syscall.
It'd would deserve to mention why.

Also, as test it's quite simple, it'd be nice, if you first convert it to new
API and in second commit added test variants.
During rewrite you should remove #if !defined(UCLINUX) check as getitimer() is
supported on uclibc-ng.

This apply to whole patchset (some tests are already ported to new API).

Kind regards,
Petr
