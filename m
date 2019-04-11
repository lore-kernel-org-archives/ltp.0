From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 11 Apr 2019 19:46:38 +0200
Subject: [LTP] [PATCH v1] rt_tgsigqueueinfo01.c: replace definition
 ANDROID with __ANDROID__
In-Reply-To: <1554992779-14595-1-git-send-email-ruanzw@xiaopeng.com>
References: <1554992779-14595-1-git-send-email-ruanzw@xiaopeng.com>
Message-ID: <20190411174638.GA11576@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Replace the incorrect definition of ANDROID with __ANDROID__.

> +++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
> @@ -25,7 +25,7 @@
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"

> -#ifndef ANDROID
> +#ifndef __ANDROID__

Simple grep in AOSP tree would be for this change (and I'd personally prefer it as well)
I'd kindly ask android devs which one is correct :). BTW ANDROID was added by Steve.

$ cgrep '#if.* __ANDROID__' |wc -l
405

$ cgrep '#if.* ANDROID[^_]' |wc -l
22

Kind regards,
Petr
