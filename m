From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Nov 2016 15:57:02 +0100
Subject: [LTP] [PATCH 1/2] lib: move create_sig_proc() into newlib
In-Reply-To: <20161116161833.16910-1-pvorel@suse.cz>
References: <20161116161833.16910-1-pvorel@suse.cz>
Message-ID: <20161121145701.GF25334@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/tst_sig_proc.h b/include/tst_sig_proc.h
> new file mode 100644
> index 0000000..bc918eb
> --- /dev/null
> +++ b/include/tst_sig_proc.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
                      ^
		      This should be you, or Linux Test Project, as it
		      is in several other files

> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
> + */
> +
> +#ifndef TST_SIG_PROC_H__
> +#define TST_SIG_PROC_H__
> +
> +#include <sys/types.h>
> +#include <unistd.h>

The sys/types.h is enough to get the pid_t defined here.

> +pid_t create_sig_proc(int sig, int count, unsigned int usec);
> +
> +#endif	/* TST_SIG_PROC_H__ */
> diff --git a/lib/tst_sig_proc.c b/lib/tst_sig_proc.c
> new file mode 100644
> index 0000000..a5f6c54
> --- /dev/null
> +++ b/lib/tst_sig_proc.c
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>

Here as well.

> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
> + */
> +
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <stdlib.h>

You should include the tst_sig_proc.h header here, if nothing else that
will force that the function definitions in header and source are in
sync.

> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"

Shouldn't be including tst_safe_macros.h here enough?

> +pid_t create_sig_proc(int sig, int count, unsigned int usec)
> +{
> +	pid_t pid, cpid;
> +
> +	pid = getpid();
> +	cpid = SAFE_FORK();
> +
> +	if (cpid == 0) {
> +		while (count-- > 0) {
> +			usleep(usec);
> +			if (kill(pid, sig) == -1)
> +				break;
> +		}
> +		exit(0);
> +	}
> +
> +	return cpid;
> +}
> diff --git a/testcases/kernel/syscalls/ppoll/ppoll01.c b/testcases/kernel/syscalls/ppoll/ppoll01.c
> index a5815b3..8d6d7e7 100644
> --- a/testcases/kernel/syscalls/ppoll/ppoll01.c
> +++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
> @@ -28,6 +28,7 @@
>  #include <sys/wait.h>
>  #include "linux_syscall_numbers.h"
>  #include "ltp_signal.h"
> +#include "tst_sig_proc.h"
>  #include "tst_test.h"
>  
>  /* Older versions of glibc don't publish this constant's value. */
> @@ -205,25 +206,6 @@ static void cleanup(void)
>  		close(fd1);
>  }
>  
> -static pid_t create_sig_proc(int sig, int count, unsigned int usec)
> -{
> -	pid_t pid, cpid;
> -
> -	pid = getpid();
> -	cpid = SAFE_FORK();
> -
> -	if (cpid == 0) {
> -		while (count-- > 0) {
> -			usleep(usec);
> -			if (kill(pid, sig) == -1)
> -				break;
> -		}
> -		exit(0);
> -	}
> -
> -	return cpid;
> -}
> -
>  static void do_test(unsigned int i)
>  {
>  	pid_t pid = 0;
> -- 
> 2.10.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
