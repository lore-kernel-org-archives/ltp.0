From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 25 Jan 2021 14:24:26 +0100
Subject: [LTP] [PATCH] memcg/functional: Convert to newlib
In-Reply-To: <20210125131746.74630-1-lkml@jv-coder.de>
References: <20210125131746.74630-1-lkml@jv-coder.de>
Message-ID: <e573f919-8205-40e2-5187-49bff0983872@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

--- a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
> @@ -1,58 +1,39 @@
>   #!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2009 FUJITSU LIMITED
> +# Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
This is bad copy-and-paste for all files, where I mentioned arm, sorry...

J?rg
