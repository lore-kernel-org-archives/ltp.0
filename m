From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 28 Sep 2018 10:00:06 +0300
Subject: [LTP] [PATCH v4] syscalls/fanotify11: new test for report
	thread id
In-Reply-To: <20180928010958.20601-1-nixiaoming@huawei.com>
References: <20180928010958.20601-1-nixiaoming@huawei.com>
Message-ID: <CAOQ4uxh4E-9sZqZ7n7DaeDTS1wT6LHMJwq=oO3=cLMrhNaZTow@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 28, 2018 at 4:58 AM nixiaoming <nixiaoming@huawei.com> wrote:
>
> syscalls/fanotify11
> test fanotify_init with FAN_EVENT_INFO_TID
>         data->pid is ID(pid)  of the thread that caused the event
> test fanotify_init without FAN_EVENT_INFO_TID
>         data->pid is ID(tgid) of the process that caused the event
>
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> ---
>
> this is not testing an upstream feature, only RFC.
>
>  runtest/syscalls                                |   1 +
>  testcases/kernel/syscalls/fanotify/.gitignore   |   1 +
>  testcases/kernel/syscalls/fanotify/Makefile     |   2 +-
>  testcases/kernel/syscalls/fanotify/fanotify11.c | 131 ++++++++++++++++++++++++
>  4 files changed, 134 insertions(+), 1 deletion(-)
>  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify11.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 0d0be77..84b0d6e 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -497,6 +497,7 @@ fanotify06 fanotify06
>  fanotify07 fanotify07
>  fanotify08 fanotify08
>  fanotify09 fanotify09
> +fanotify11 fanotify11
>
>  ioperm01 ioperm01
>  ioperm02 ioperm02
> diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
> index ec75539..62180ab 100644
> --- a/testcases/kernel/syscalls/fanotify/.gitignore
> +++ b/testcases/kernel/syscalls/fanotify/.gitignore
> @@ -7,3 +7,4 @@
>  /fanotify07
>  /fanotify08
>  /fanotify09
> +/fanotify11
> diff --git a/testcases/kernel/syscalls/fanotify/Makefile b/testcases/kernel/syscalls/fanotify/Makefile
> index bb58878..5d01b48 100644
> --- a/testcases/kernel/syscalls/fanotify/Makefile
> +++ b/testcases/kernel/syscalls/fanotify/Makefile
> @@ -17,7 +17,7 @@
>  #
>
>  top_srcdir             ?= ../../../..
> -
> +fanotify11: CFLAGS+=-pthread
>  include $(top_srcdir)/include/mk/testcases.mk
>
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify11.c b/testcases/kernel/syscalls/fanotify/fanotify11.c
> new file mode 100644
> index 0000000..45959b4
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
> @@ -0,0 +1,131 @@
> +/*
> + * Copyright (c) 2018 Huawei.  All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it is
> + * free of the rightful claim of any third person regarding infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *

I also need your permission to use license
SPDX-License-Identifier: GPL-2.0-or-later

Instead of only GPL 2.0.

Thanks,
Amir.
