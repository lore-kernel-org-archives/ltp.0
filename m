From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Mar 2019 14:55:57 +0100
Subject: [LTP] [PATCH v3 1/3] syscalls/tgkill01: add new test
In-Reply-To: <1552978181-27748-2-git-send-email-sumit.garg@linaro.org>
References: <1552978181-27748-1-git-send-email-sumit.garg@linaro.org>
 <1552978181-27748-2-git-send-email-sumit.garg@linaro.org>
Message-ID: <20190319135556.GH6204@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- /dev/null
> +++ b/testcases/kernel/syscalls/tgkill/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2018 Google, Inc.
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +LDLIBS			+= -pthread

I've changed this to CFLAGS += -pthread since that is only supported way
how to compile programs with pthreads on Linux.

-- 
Cyril Hrubis
chrubis@suse.cz
