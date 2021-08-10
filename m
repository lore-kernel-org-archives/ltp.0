From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Aug 2021 12:17:09 +0200
Subject: [LTP] [PATCH 2/4] syscalls/chmod02: Convert to new API
In-Reply-To: <20210806072405.8695-1-zhanglianjie@uniontech.com>
References: <20210806072405.8695-1-zhanglianjie@uniontech.com>
Message-ID: <YRJSJapihLk8eG1H@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/chmod/chmod02.c b/testcases/kernel/syscalls/chmod/chmod02.c
> index 94a77aeb1..e69f6b4e0 100644
> --- a/testcases/kernel/syscalls/chmod/chmod02.c
> +++ b/testcases/kernel/syscalls/chmod/chmod02.c
> @@ -1,107 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
>   *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.

FYI this is GPL-2.0 as well.

> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it is
> - * free of the rightful claim of any third person regarding infringement
> - * or the like.  Any license provided herein, whether implied or
> - * otherwise, applies only to this software file.  Patent licenses, if
> - * any, provided herein do not apply to combinations of this program with
> - * other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> - * Mountain View, CA  94043, or:
> - *
> - * http://www.sgi.com
> - *
> - * For further information regarding this notice, see:
> - *
> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> - */
> -
> -/*
>   * AUTHOR	: William Roske
>   * CO-PILOT	: Dave Fenner
>   * DATE STARTED	: 03/30/92
> + */
> +
> +/*\
> + * [Description]
>   *
>   *  Calls chmod(2) with different modes and expects success.
>   */

And the test actually does not add anything since chmod01.c covers this
and even checks the mode by doing stat() on the file. So we can actually
remove this test instead since it's redundant.

-- 
Cyril Hrubis
chrubis@suse.cz
