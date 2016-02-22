From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Feb 2016 14:35:14 +0100
Subject: [LTP] [PATCH 1/5] open_posix: add SAFE_PFUNC macro
In-Reply-To: <eb9862205b7122243cfba5ecae0a9293f7d95c21.1455875648.git.jstancek@redhat.com>
References: <eb9862205b7122243cfba5ecae0a9293f7d95c21.1455875648.git.jstancek@redhat.com>
Message-ID: <20160222133513.GB6434@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifndef __SAFE_MACROS_H__
> +#define __SAFE_MACROS_H__

The file lacks GNU header and the guards should be SAFE_HELPERS rather
than SAFE_MACROS.

> +#include <string.h>

Technically we should incude stdio.h for fflush() and printf() as well.

> +#define SAFE_PFUNC(op) \
> +do {\
> +	int ret = (op); \
> +	if (ret != 0) { \
> +		printf("Test %s unresolved: got %i (%s) on line %i\n  %s\n", \
> +			__FILE__, ret, strerror(ret), __LINE__, #op); \
> +		fflush(stdout); \
> +		exit(PTS_UNRESOLVED); \
> +	} \
> +} while (0)
> +
> +#endif

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
