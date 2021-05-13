From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 13 May 2021 14:42:36 +0800
Subject: [LTP] [PATCH] Makefile: Use SPDX in Makefile
In-Reply-To: <YJvdgJCg2ZWq8lWM@pevik>
References: <20210512084904.35159-1-xieziyao@huawei.com>
 <YJvdgJCg2ZWq8lWM@pevik>
Message-ID: <86694b65-2669-ecc8-f987-26a29027e995@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Petr,

> Unfortunately patch cannot be applied with 'git am' and even with patch:
> 
> $ patch -p1 <Makefile-Use-SPDX-in-Makefile.patch
> patching file doc/Makefile
> patch: **** malformed patch at line 244: diff --git a/include/Makefile b/include/Makefile
> 
> Line 244 is top_srcdir:
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2009, Cisco Systems Inc.
>   # Ngie Cooper, July 2009
> -#
>   top_srcdir			?= ..
> 
> I suppose you generate patch correctly with 'git format-patch' and send with
> 'git send-email'. I wonder if your mailserver breaks the patch. Could you check
> it and optionally use different mailserver? (you can send mail to ML from e.g.
> gmail and still have Signed-off-by: with huawei.com mail address).
Oops! I made some incorrect changes to the patch by mistake. My bad.

> Unrelated change: you fix also indent here. It'd be better to add it into
> separate patch.
Changed, thanks a lot.

Just re-checked the latest code and submit the v2 version. Please see: 
https://patchwork.ozlabs.org/project/ltp/list/?series=243550

Thanks for your review, Petr.

Kind Regards,
Ziyao
