Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Urpsv-0006sC-9a
	for ltp-list@lists.sourceforge.net; Wed, 26 Jun 2013 13:35:45 +0000
Date: Wed, 26 Jun 2013 15:37:08 +0200
From: chrubis@suse.cz
Message-ID: <20130626133707.GC16146@rei.suse.cz>
References: <1372252361-26179-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372252361-26179-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2] lib: tst_module: add library functions for
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
> There are new functions: tst_module_exists(), tst_module_load() and
> tst_module_unload(). These functions help to load and unload kernel
> modules in the tests.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  include/tst_module.h |   68 +++++++++++++++++++++++++++++++
>  lib/tst_module.c     |  109 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 177 insertions(+), 0 deletions(-)
>  create mode 100644 include/tst_module.h
>  create mode 100644 lib/tst_module.c
> 
> diff --git a/include/tst_module.h b/include/tst_module.h
> new file mode 100644
> index 0000000..90d7cf1
> --- /dev/null
> +++ b/include/tst_module.h
> @@ -0,0 +1,68 @@
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
> + * Author:
> + * Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + * These functions help to load and unload kernel modules in the tests.
> + *
> + * tst_module_load and tst_module_unload functions already include
> + * tst_module_exists function, which is checking the following possible
> + * module's locations:
> + *
> + * 1. Current working directory
> + *
> + * 2. LTP installation path (using env LTPROOT, which is usually /opt/ltp)
> + *
> + * 3. If tmp directory created, it'll look at the test start working directory
> + *
> + */
> +
> +#ifndef TST_MODULE
> +#define TST_MODULE
> +
> +/*
> + * Check module existence.
> + *
> + * @mod_path: if it is not NULL, then tst_module_exists places the found
> + * module's path into the location pointed to by *mod_path. It must be freed
> + * with free() when it is no longer needed.
> + *
> + * In case of failure, test'll call cleanup_fn and exit with TCONF return value.
> + */
> +void tst_module_exist(void (cleanup_fn)(void), const char *mod_name,
> +	char **mod_path);
> +
> +/*
> + * Load a module using insmod program.
> + *
> + * @argv: an array of pointers to null-terminated strings that represent the
> + * additional parameters to the module. If it is NULL, it will be ignored.
> + *
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
> index 0000000..20a73bf
> --- /dev/null
> +++ b/lib/tst_module.c
> @@ -0,0 +1,109 @@
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
> +#include <stdarg.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
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
> +		if (buf != NULL)
> +			free(buf);

The if is redundant here as free() can handle NULL pointers just fine.

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
> +		if (buf != NULL)
> +			free(buf);

Here as well.

> +		tst_brkm(TCONF, cleanup_fn, "Failed to find module '%s'",
> +			mod_name);
> +	}
> +
> +	if (mod_path != NULL)
> +		*mod_path = buf;
> +	else
> +		free(buf);
> +}
> +
> +void tst_module_load(void (cleanup_fn)(void),
> +	const char *mod_name, char *const argv[])
> +{
> +	char *mod_path = NULL;
> +	tst_module_exists(cleanup_fn, mod_name, &mod_path);
> +
> +	/* add command name, module name and NULL to array */
> +	static int offset = 2;
> +	int size = offset;
> +	if (argv != NULL)
> +		size += ARRAY_SIZE(argv);

Again same problem. If you pas array of pointers in C you have two
options either to NULL terminate the array or pass it's size as
parameter. I would settle for NULL terminated in this case.

> +	char *mod_argv[size + 1];
> +	mod_argv[size] = NULL;
> +	mod_argv[0] = "insmod";
> +	mod_argv[1] = strdupa(mod_path);
> +	free(mod_path);

Hmm what about removing the strdupa() and freeing the mod_path after the
command is executed. If that fails the program exits anyway and whole
malloc heap is thrown away on program exit.

> +	int i;
> +	for (i = offset; i < size; ++i)
> +		mod_argv[i] = argv[i - offset];
> +	SAFE_EXECVP(cleanup_fn, mod_argv);
> +}
> +
> +void tst_module_unload(void (cleanup_fn)(void), const char *mod_name)
> +{
> +	char *mod_path = NULL;
> +	tst_module_exists(cleanup_fn, mod_name, &mod_path);
> +	char *const argv[] = { "rmmod", strdupa(mod_path), NULL };

Same here.

> +	free(mod_path);
> +	SAFE_EXECVP(cleanup_fn, argv);
> +}

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
