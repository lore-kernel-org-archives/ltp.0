From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Jan 2021 12:11:27 +0100
Subject: [LTP] [PATCH 1/1] swapping01: fix parameter truncation in abs
In-Reply-To: <20210115122543.288948-1-egorenar@linux.ibm.com>
References: <20210115122543.288948-1-egorenar@linux.ibm.com>
Message-ID: <YAgP38nzhxIe3mQ0@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexander,

> Parameters passed to abs(int) are of type long. Use labs(long) instead
> to avoid value truncation.

> Fixes the following warning:

> swapping01.c: In function ?check_swapping?:
> swapping01.c:133:7: warning: absolute value function ?abs? given an argument of type ?long int? but has parameter of type ?int? which may cause truncation of value [-Wabsolute-value]
>   133 |   if (abs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:")) < 512)
>       |       ^~~

Merged this obvious fix. Thanks!

Kind regards,
Petr
