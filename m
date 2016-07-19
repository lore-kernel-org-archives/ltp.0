From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Jul 2016 16:09:39 +0200
Subject: [LTP] [PATCH 2/3] lib/cloner.c: Add tst_clone.h for new API
In-Reply-To: <1467803450-11622-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1467803450-11622-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1467803450-11622-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160719140938.GF6409@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
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
> + * with this program.
> + *
> + */
> +
> +#ifndef TST_CLONE_H__
> +#define TST_CLONE_H__
> +
> +/* Functions from lib/cloner.c */
> +int ltp_clone(unsigned long flags, int (*fn)(void *arg), void *arg,
> +		size_t stack_size, void *stack);
> +int ltp_clone7(unsigned long flags, int (*fn)(void *arg), void *arg,
> +		size_t stack_size, void *stack, ...);
> +int ltp_clone_malloc(unsigned long clone_flags, int (*fn)(void *arg),
> +		void *arg, size_t stacksize);
> +int ltp_clone_quick(unsigned long clone_flags, int (*fn)(void *arg),
> +		void *arg);

I'm undecided if we should rename these to start with tst_ in the new
library. Apart from that it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
