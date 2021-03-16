From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Mar 2021 17:43:54 +0100
Subject: [LTP] [PATCH 1/2] syscalls/getppid01: Convert to the new API
In-Reply-To: <20210304021304.1126635-1-ruansy.fnst@fujitsu.com>
References: <20210304021304.1126635-1-ruansy.fnst@fujitsu.com>
Message-ID: <YFDgSgFNMH8fUwNr@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ruan,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

You extended test: checking PID range, good.

> +/*\
> + * [DESCRIPTION]
> + * 
> + * Test whether parent process id that getpid() returns is out of range.
> +\*/
nit: only */

...
> +	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);

> +	if (ppid > pid_max)
> +		tst_res(TFAIL, "getppid() returned %d, out of range!", ppid);
> +	else
> +		tst_res(TPASS, "getppid() returned %d", ppid);
>  }

Kind regards,
Petr
