From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Apr 2018 13:45:50 +0200
Subject: [LTP] [PATCH 2/2] syscalls/setuid: Cleanup && Convert to new API
In-Reply-To: <1519912139-18839-2-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <1519912139-18839-1-git-send-email-xuyang.jy@cn.fujitsu.com>
 <1519912139-18839-2-git-send-email-xuyang.jy@cn.fujitsu.com>
Message-ID: <20180409114550.yrbudsrf4k5e7yyr@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> From: yang xu <xuyang.jy@cn.fujitsu.com>

> 1) Merge setuid02 into setuid01
> 2) Use new compat_tst_16.h
> 3) Take use of some safe macros

> Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
> ---
>  runtest/ltplite                             |   1 -
>  runtest/stress.part3                        |   1 -
>  runtest/syscalls                            |   2 -
>  testcases/kernel/syscalls/.gitignore        |   2 -
>  testcases/kernel/syscalls/setuid/Makefile   |   7 +-
>  testcases/kernel/syscalls/setuid/setuid01.c | 110 +++++----------
>  testcases/kernel/syscalls/setuid/setuid02.c | 200 ----------------------------
>  testcases/kernel/syscalls/setuid/setuid03.c |  89 ++++---------
>  testcases/kernel/syscalls/setuid/setuid04.c | 200 +++++++++-------------------

Thanks for rewriting. Pushed with minor change - IMHO typo (see bellow).


Kind regards,
Petr

diff --git testcases/kernel/syscalls/setuid/Makefile testcases/kernel/syscalls/setuid/Makefile
index 4aaa6c6c5..6bd943aaf 100644
--- testcases/kernel/syscalls/setuid/Makefile
+++ testcases/kernel/syscalls/setuid/Makefile
@@ -20,7 +20,7 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 #for compat_16.mk uses the compat_16_tst.h
-COMPAT_16_TST_H		:= 1
+COMPAT_TST_16_H		:= 1
 
 include $(abs_srcdir)/../utils/compat_16.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
