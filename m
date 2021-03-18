From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Mar 2021 19:30:16 +0100
Subject: [LTP] [PATCH] syscalls/semctl09: Skip libc test if SEM_STAT_ANY
 not defined
In-Reply-To: <20210318162409.9871-1-mdoucha@suse.cz>
References: <20210318162409.9871-1-mdoucha@suse.cz>
Message-ID: <YFOcOJP4innlbIk4@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> The libc test variant should run only if system headers define SEM_STAT_ANY.
> Skip it if we're falling back to the LAPI definition.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks!

...
> +#if !HAVE_DECL_SEM_STAT_ANY
nit: I'd prefer
#ifndef HAVE_DECL_SEM_STAT_ANY

> +	if (tst_variant == 1)
> +		tst_brk(TCONF, "libc does not support semctl(SEM_STAT_ANY)");
> +#endif
Although I understand why you want to quit only tests with root
(only these fail), it's a bit confusing to test with user nobody
and then quit the same testing with root.

Kind regards,
Petr
