Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UsPAH-0000gZ-7r
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 03:16:01 +0000
Received: from mail-pa0-f54.google.com ([209.85.220.54])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UsPAB-0006wy-73
	for ltp-list@lists.sourceforge.net; Fri, 28 Jun 2013 03:16:01 +0000
Received: by mail-pa0-f54.google.com with SMTP id kx10so1884744pab.27
	for <ltp-list@lists.sourceforge.net>;
	Thu, 27 Jun 2013 20:15:49 -0700 (PDT)
Message-ID: <51CCFFF5.20505@casparzhang.com>
Date: Fri, 28 Jun 2013 11:16:05 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1372345762-5425-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1372345762-5425-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v4] lib: tst_module: add library functions for
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

On 06/27/2013 11:09 PM, Alexey Kodanev wrote:
> There are new functions: tst_module_exists(), tst_module_load() and
> tst_module_unload(). These functions help to load and unload kernel
> modules in the tests.
>
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>   include/tst_module.h |   70 +++++++++++++++++++++++++++++++++
>   lib/tst_module.c     |  105 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 175 insertions(+), 0 deletions(-)
>   create mode 100644 include/tst_module.h
>   create mode 100644 lib/tst_module.c
>
> diff --git a/include/tst_module.h b/include/tst_module.h
> new file mode 100644
> index 0000000..7ff2c7e
> --- /dev/null
> +++ b/include/tst_module.h
> @@ -0,0 +1,70 @@
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
> + * tst_module_load function already includes tst_module_exists function,
> + * which is checking the following possible module's locations:
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
> + * @mod_name: module's file name.
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
> + * @mod_name: module's file name.
> + * @argv: an array of pointers to null-terminated strings that represent the
> + * additional parameters to the module. The array of pointers  must be
> + * terminated by a NULL pointer. If argv points to NULL, it will be ignored.
> + *
> + * In case of insmod failure, test will call cleanup_fn and exit with TBROK
> + * return value.
> + */
> +void tst_module_load(void (cleanup_fn)(void),
> +	const char *mod_name, char *const argv[]);
> +
> +/*
> + * @mod_name: can be module name or module's file name.
> + * Unload a module using rmmod program. In case of failure, test will call
> + * cleanup_fn and exit with TBROK return value.
> + */
> +void tst_module_unload(void (cleanup_fn)(void), const char *mod_name);
> +
> +#endif /* TST_MODULE */
> diff --git a/lib/tst_module.c b/lib/tst_module.c
> new file mode 100644
> index 0000000..373edb6
> --- /dev/null
> +++ b/lib/tst_module.c
> @@ -0,0 +1,105 @@
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
> +
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
> +	char *const argv[] = { "rmmod", mod_name, NULL };
> +	tst_run_cmd(cleanup_fn, argv);
> +}
>
Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
