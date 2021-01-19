From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Jan 2021 08:41:59 +0100
Subject: [LTP] [PATCH v2 1/2] lib: Fix kernel module detection on BusyBox
In-Reply-To: <20210118161308.30771-1-pvorel@suse.cz>
References: <20210118161308.30771-1-pvorel@suse.cz>
Message-ID: <YAaNR0PzZt5A1Fjm@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
...
> -int tst_check_driver(const char *name)
> +#ifndef __ANDROID__
> +# define MODULES_DIR "/lib/modules"
> +#else
> +# define MODULES_DIR "/system/lib/modules"
> +#endif

OK, MODULES_DIR is not needed now as I kept Android skipped (unless somebody
contributes code or share algorithm for Android).

Kind regards,
Petr
