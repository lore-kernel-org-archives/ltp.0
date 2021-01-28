From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Jan 2021 15:55:12 +0100
Subject: [LTP] [PATCH 1/1] lib: Fix fs support detection for non-root
In-Reply-To: <20210128144649.6012-1-pvorel@suse.cz>
References: <20210128144649.6012-1-pvorel@suse.cz>
Message-ID: <YBLQUEdfBcuepbFA@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> +++ b/lib/tst_supported_fs_types.c
> @@ -52,10 +52,29 @@ static int has_kernel_support(const char *fs_type, int flags)
>  	char buf[128];
>  	int ret;

> +	const char * const argv[] = { "grep", "-q", "-F", "-w", fs_type, "/proc/filesystems", NULL };
"-F" is probably useless.

Kind regards,
Petr
