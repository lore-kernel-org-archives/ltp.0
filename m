From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Oct 2016 17:00:18 +0200
Subject: [LTP] [PATCH 1/2] syscalls/getrusage03: Use constants instead
 of magic numbers
In-Reply-To: <1471873120-4272-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1471873120-4272-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <20161005150017.GB23476@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.h b/testcases/kernel/syscalls/getrusage/getrusage03.h
> new file mode 100644
> index 0000000..7dc6d0a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/getrusage/getrusage03.h
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright (c) 2016 Synopsys, Inc. (www.synopsys.com)
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef GETRUSAGE03_H
> +#define GETRUSAGE03_H
> +
> +#define DELTA_MAX_KB		102400
> +#define CONSUME_INITIAL_MB	100
> +#define CONSUME_FORK_MALLOC_MB	50
> +#define CONSUME_GRANDCHILD_MB	300
> +#define CONSUME_ZOMBIE_MB	400
> +#define CONSUME_SIG_IGN_MB	500
> +
> +#define N_TO_STR(s) _N_TO_STR(s)
> +#define _N_TO_STR(s) #s
> +
> +static int is_in_delta(long value)
> +{
> +	return (value >= -DELTA_MAX_KB && value <= DELTA_MAX_KB);
> +}

I do not like much that you are replacing the hardcoded values with
macros. Why not integer variables instead? Then we can actually tune the
values at test start automatically.

So what about making all these CONSUME_FOO macros integer varibles
instead?

Also sorry for the delay in review.

-- 
Cyril Hrubis
chrubis@suse.cz
