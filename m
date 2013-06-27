Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UsD4F-0007fs-PB
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 14:20:59 +0000
Date: Thu, 27 Jun 2013 16:22:30 +0200
From: chrubis@suse.cz
Message-ID: <20130627142230.GB21873@rei.suse.cz>
References: <1372264605-29259-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372264605-29259-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v3] lib: tst_module: add library functions for
 kernel modules
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +/*
> + * Load a module using insmod program.
> + *
> + * @argv: an array of pointers to null-terminated strings that represent the
> + * additional parameters to the module. The array of pointers  should be
> + * terminated by a NULL pointer. If argv points to NULL, it will be ignored.

Again should vs must.

> + * In case of insmod failure, test will call cleanup_fn and exit with TBROK
> + * return value.
> + */
> +void tst_module_load(void (cleanup_fn)(void),
> +	const char *mod_name, char *const argv[]);
> +
> +/*
> + * Unload a module using rmmod program. In case of failure, test will call
> + * cleanup_fn and exit with TBROK return value.
> + */
> +void tst_module_unload(void (cleanup_fn)(void), const char *mod_name);
> +
> +#endif /* TST_MODULE */
> diff --git a/lib/tst_module.c b/lib/tst_module.c
> new file mode 100644
> index 0000000..2538777
> --- /dev/null
> +++ b/lib/tst_module.c
> @@ -0,0 +1,108 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#include "test.h"
> +#include "ltp_priv.h"
> +#include "tst_module.h"
> +
> +void tst_module_exists(void (cleanup_fn)(void),
> +	const char *mod_name, char **mod_path)
> +{
> +	/* check current working directory */
> +	if (access(mod_name, F_OK) == 0) {
> +		if (mod_path != NULL)
> +			*mod_path = strdup(mod_name);
> +		return;
> +	}
> +	char *buf = NULL;
> +	int err = -1;
> +	/* check LTP installation path */
> +	const char *ltproot = getenv("LTPROOT");
> +	if (ltproot != NULL) {
> +		if (asprintf(&buf, "%s/testcases/bin/%s",
> +			ltproot, mod_name) == -1) {
> +			tst_brkm(TBROK | TERRNO, cleanup_fn,
> +				"asprintf failed at %s:%d",
> +				__FILE__, __LINE__);
> +		}
> +		err = access(buf, F_OK);
> +	}
> +	/* check start working directory */
> +	if (err == -1 && tst_tmpdir_created()) {
> +		free(buf);
> +		if (asprintf(&buf, "%s/%s", tst_get_startwd(),
> +			mod_name) == -1) {
> +			tst_brkm(TBROK | TERRNO, cleanup_fn,
> +				"asprintf failed at %s:%d",
> +				__FILE__, __LINE__);
> +		}
> +		err = access(buf, F_OK);
> +	}
> +
> +	if (err != 0) {
> +		free(buf);
> +		tst_brkm(TCONF, cleanup_fn, "Failed to find module '%s'",
> +			mod_name);
> +	}
> +
> +	if (mod_path != NULL)
> +		*mod_path = buf;
> +	else
> +		free(buf);
> +}

So you expect that the '.ko' suffix is part of the module name. It
should be written in the comment in the header. Because at least I
expect the module name to be the name that is returned by lsmod.

> +void tst_module_load(void (cleanup_fn)(void),
> +	const char *mod_name, char *const argv[])
> +{
> +	char *mod_path = NULL;
> +	tst_module_exists(cleanup_fn, mod_name, &mod_path);
> +
> +	static int offset = 2; /* command name & module path */
> +	int size = 0;
> +	while (argv && argv[size])
> +		++size;
> +	size += offset;
> +	char *mod_argv[size + 1]; /* + NULL in the end */
> +	mod_argv[size] = NULL;
> +	mod_argv[0] = "insmod";
> +	mod_argv[1] = mod_path;
> +
> +	int i;
> +	for (i = offset; i < size; ++i)
> +		mod_argv[i] = argv[i - offset];
> +
> +	tst_run_cmd(cleanup_fn, mod_argv);
> +	free(mod_path);
> +}
> +
> +void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
> +{
> +	char *mod_path = NULL;
> +	tst_module_exists(cleanup_fn, mod_name, &mod_path);
> +	char *const argv[] = { "rmmod", mod_path, NULL };

Hmm, man rmmod suggest that it takes module name (not module path) as
parameter i.e. the string without the path and the '.ko' suffix. Does it
work with module path too?

> +	tst_run_cmd(cleanup_fn, argv);
> +	free(mod_path);
> +}

The rest is fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
