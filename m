From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 28 Mar 2019 07:43:09 +0100
Subject: [LTP] [RESENT][PATCH v2 1/1] lapi: Define TST_ABI{, 32,
 64} to detect target type
In-Reply-To: <20190327153911.GA9223@rei.lan>
References: <20190326105235.21177-1-petr.vorel@gmail.com>
 <20190327153911.GA9223@rei.lan>
Message-ID: <20190328064235.GA11011@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > and replace __WORDSIZE with them.

> > Motivation was instead of finding, where all libc define __WORDSIZE,
> > which is usually used for detecting target type (at least MUSL
> > defines it in different place than other libc) we define our own
> > constant.

> > + change encoding of the comment in mem01.c to utf8 and use SPDX license
> > identifier.

> This should go in separate patch, also I do not see a reason to keep the
> "We didn't forget you" french comment in the source file, we should
> probably delete it.

> Other than that the rest looks good.

Thanks for your review!
Split into 2 patches and merged.


Kind regards,
Petr
