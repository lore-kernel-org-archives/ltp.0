From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Mar 2019 16:39:12 +0100
Subject: [LTP] [RESENT][PATCH v2 1/1] lapi: Define TST_ABI{, 32,
 64} to detect target type
In-Reply-To: <20190326105235.21177-1-petr.vorel@gmail.com>
References: <20190326105235.21177-1-petr.vorel@gmail.com>
Message-ID: <20190327153911.GA9223@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> and replace __WORDSIZE with them.
> 
> Motivation was instead of finding, where all libc define __WORDSIZE,
> which is usually used for detecting target type (at least MUSL
> defines it in different place than other libc) we define our own
> constant.
> 
> + change encoding of the comment in mem01.c to utf8 and use SPDX license
> identifier.

This should go in separate patch, also I do not see a reason to keep the
"We didn't forget you" french comment in the source file, we should
probably delete it.

Other than that the rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
