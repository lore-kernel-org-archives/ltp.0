From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Jun 2017 14:43:40 +0200
Subject: [LTP] [PATCH 1/2] syscalls/splice04,05: fix max limit for pipe
In-Reply-To: <1496904074-25394-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1496904074-25394-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170615124339.GB2832@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifndef SPLICE_H__
> +#define SPLICE_H__
> +
> +#include <unistd.h>
> +#include "tst_safe_file_ops.h"
> +#include "tst_minmax.h"
> +
> +static inline int get_max_limit(int default_len_data)
> +{
> +	int pipe_max_unpriv;
> +	int pipe_max_limit;
> +
> +	if (!access("/proc/sys/fs/pipe-max-size", F_OK)) {
> +		SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d", &pipe_max_unpriv);
> +		pipe_max_limit = MIN(pipe_max_unpriv, default_len_data);
> +		return pipe_max_limit;

Just do return MIN(pipe_max_unpriv, default_len_data); there is no point
in storing the result into the variable here.

> +	}
> +
> +	if (!access("/proc/sys/fs/pipe-max-pages", F_OK)) {
> +		SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-pages", "%d", &pipe_max_unpriv);
> +		pipe_max_limit = MIN(pipe_max_unpriv * getpagesize(), default_len_data);
> +		return pipe_max_limit;

And here as well.

> +	}
> +
> +	return default_len_data;
> +}

Otherwise it looks obviously OK.

-- 
Cyril Hrubis
chrubis@suse.cz
