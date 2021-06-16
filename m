From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Jun 2021 13:04:28 +0200
Subject: [LTP] [PATCH 1/3] lib: tst_process_state: Add
 tst_process_release_wait()
In-Reply-To: <20210616093606.214856-2-xieziyao@huawei.com>
References: <20210616093606.214856-1-xieziyao@huawei.com>
 <20210616093606.214856-2-xieziyao@huawei.com>
Message-ID: <YMnavJjzrS7B8fgd@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  /*
>   * Copyright (C) 2012-2014 Cyril Hrubis chrubis@suse.cz
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
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
> + * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
>   */

First of all changes in license and whitespaces should be in a separate
patch from the newly added functionality.

>  #include <stdio.h>
> @@ -28,9 +12,8 @@
>  #include "test.h"
>  #include "tst_process_state.h"
> 
> -int tst_process_state_wait(const char *file, const int lineno,
> -                            void (*cleanup_fn)(void), pid_t pid,
> -			    const char state, unsigned int msec_timeout)
> +int tst_process_state_wait(const char *file, const int lineno, void (*cleanup_fn)(void),
> +			   pid_t pid, const char state, unsigned int msec_timeout)
>  {
>  	char proc_path[128], cur_state;
>  	unsigned int msecs = 0;
> @@ -39,7 +22,7 @@ int tst_process_state_wait(const char *file, const int lineno,
> 
>  	for (;;) {
>  		safe_file_scanf(file, lineno, cleanup_fn, proc_path,
> -		                "%*i %*s %c", &cur_state);
> +				"%*i %*s %c", &cur_state);
> 
>  		if (state == cur_state)
>  			break;
> @@ -84,3 +67,26 @@ int tst_process_state_wait2(pid_t pid, const char state)
>  		usleep(10000);
>  	}
>  }
> +
> +int tst_process_release_wait(pid_t pid, unsigned int msec_timeout)
> +{
> +	char proc_path[128];
> +	unsigned int msecs = 0;
> +
> +	snprintf(proc_path, sizeof(proc_path), "/proc/%i", pid);
> +
> +	for (;;) {
> +		if (access(proc_path, F_OK))
> +			break;
> +
> +		usleep(1000);
> +		msecs += 1;
> +
> +		if (msec_timeout && msecs >= msec_timeout) {
> +			errno = ETIMEDOUT;
> +			return 0;
> +		}
> +	}
> +
> +	return 1;
> +}

What exactly do we need this for?

When does /proc/$PID ceases to exit? My guess would be that the
directory ceases to exists once the child has been waited() for by a
parent process and we do not need this at all since call to system()
does wait for it's children anyways.

-- 
Cyril Hrubis
chrubis@suse.cz
