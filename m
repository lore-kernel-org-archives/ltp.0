Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDbzn-00085o-PB
	for ltp-list@lists.sourceforge.net; Wed, 12 Feb 2014 15:45:07 +0000
Date: Wed, 12 Feb 2014 16:44:31 +0100
From: chrubis@suse.cz
Message-ID: <20140212154431.GB4905@rei.suse.cz>
References: <1392112090-13853-1-git-send-email-alexey.kodanev@oracle.com>
	<1392112090-13853-3-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1392112090-13853-3-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 4/4] lib: add tst_res_r.c
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
> It contains thread-safe versions of functions defined in tst_res.c.
> NOPASS mode not implemented yet.
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  lib/tst_res_r.c |  499 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 499 insertions(+), 0 deletions(-)
>  create mode 100644 lib/tst_res_r.c
> 
> diff --git a/lib/tst_res_r.c b/lib/tst_res_r.c
> new file mode 100644
> index 0000000..1cf79ad
> --- /dev/null
> +++ b/lib/tst_res_r.c
> @@ -0,0 +1,499 @@
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + * Copyright (c) 2009-2013 Cyril Hrubis <chrubis@suse.cz>
> + * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
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
> + */
> +
> +#include <pthread.h>
> +#include "tst_res.h"
> +
> +/*
> + * Synchronize access to global vars T_exitval, T_out, tst_count with
> + * mutexes.
> + */
> +pthread_mutex_t exitval_mutex = PTHREAD_MUTEX_INITIALIZER,
> +                tstcount_mutex =  PTHREAD_MUTEX_INITIALIZER,
> +                tout_mutex = PTHREAD_MUTEX_INITIALIZER;

This should be static.

> +static int exitval_or(int ttype_result)
> +{
> +	int res;
> +	pthread_mutex_lock(&exitval_mutex);
> +	res = T_exitval |= ttype_result;
> +	pthread_mutex_unlock(&exitval_mutex);
> +	return res;
> +}
> +
> +static int exitval_and(int ttype_result)
> +{
> +	int res;
> +	pthread_mutex_lock(&exitval_mutex);
> +	res = T_exitval &= ttype_result;
> +	pthread_mutex_unlock(&exitval_mutex);
> +	return res;
> +}
> +
> +static int get_tst_count()
> +{
> +	int res;
> +	pthread_mutex_lock(&tstcount_mutex);
> +	res = tst_count;
> +	pthread_mutex_unlock(&tstcount_mutex);
> +	return res;
> +}
> +
> +static void cat_file_r(char *filename);

This is hardly pefromance critical code so we don't need fine grade
locking as this. What we can do in most of the cases is to take the
mutext and call the function from tst_res.c, which would lead to much
simpler code.

> +/*
> + * tst_print_r() - thread-safe version of tst_print()
> + * Additionally takes filename, because it isn't using global File
> + */
> +static void tst_print_r(char *tcid, char *fname, int tnum, int ttype, char *tmesg)
> +{
> +	/*
> +	 * avoid unintended side effects from failures with fprintf when
> +	 * calling write(2), et all.
> +	 */
> +	int err = errno;
> +	const char *type;
> +	int ttype_result = TTYPE_RESULT(ttype);
> +	char message[USERMESG];
> +	size_t size;
> +
> +#if DEBUG
> +	printf("IN tst_print_r: tnum = %d, ttype = %d, tmesg = %s\n",
> +	       tnum, ttype, tmesg);
> +	fflush(stdout);
> +#endif
> +
> +	/*
> +	 * Save the test result type by ORing ttype into the current exit value
> +	 * (used by tst_exit()).  This is already done in tst_res(), but is
> +	 * also done here to catch internal warnings.  For internal warnings,
> +	 * tst_print() is called directly with a case of TWARN.
> +	 */
> +	exitval_or(ttype_result);
> +
> +	/*
> +	 * If output mode is DISCARD, or if the output mode is NOPASS and this
> +	 * result is not one of FAIL, BROK, or WARN, just return.  This check
> +	 * is necessary even though we check for DISCARD mode inside of
> +	 * tst_res(), since occasionally we get to this point without going
> +	 * through tst_res() (e.g. internal TWARN messages).
> +	 */
> +	if (T_mode == DISCARD || (T_mode == NOPASS && ttype_result != TFAIL &&
> +				  ttype_result != TBROK
> +				  && ttype_result != TWARN))
> +		return;
> +
> +	/*
> +	 * Build the result line and print it.
> +	 */
> +	type = strttype(ttype);
> +	if (T_mode == VERBOSE) {
> +		size = snprintf(message, sizeof(message),
> +				"%-8s %4d  %s  :  %s", tcid, tnum, type, tmesg);
> +	} else {
> +		size = snprintf(message, sizeof(message),
> +				"%-8s %4d       %s  :  %s",
> +				tcid, tnum, type, tmesg);
> +	}
> +
> +	if (size >= sizeof(message)) {
> +		printf("%s: %i: line too long\n", __func__, __LINE__);
> +		abort();
> +	}
> +
> +	if (ttype & TERRNO) {
> +		size += snprintf(message + size, sizeof(message) - size,
> +				 ": errno=%s(%i): %s", strerrnodef(err),
> +				 err, strerror(err));
> +	}
> +
> +	if (size >= sizeof(message)) {
> +		printf("%s: %i: line too long\n", __func__, __LINE__);
> +		abort();
> +	}
> +
> +	if (ttype & TTERRNO) {
> +		size += snprintf(message + size, sizeof(message) - size,
> +				 ": TEST_ERRNO=%s(%i): %s",
> +				 strerrnodef(TEST_ERRNO), (int)TEST_ERRNO,
> +				 strerror(TEST_ERRNO));
> +	}
> +
> +	if (size + 1 >= sizeof(message)) {
> +		printf("%s: %i: line too long\n", __func__, __LINE__);
> +		abort();
> +	}
> +
> +	message[size] = '\n';
> +	message[size + 1] = '\0';
> +
> +	pthread_mutex_lock(&tout_mutex);
> +	fputs(message, T_out);
> +	pthread_mutex_unlock(&tout_mutex);
> +
> +	/*
> +	 * If tst_res() was called with a file, append file contents to the
> +	 * end of last printed result.
> +	 */
> +	if (fname != NULL)
> +		cat_file_r(fname);
> +}

The same here. I don't like that the code is copied, one copy of messy
tst_print_r is more than enough. All that should be needed are mutexes
in the entry points to the ltp library, or do we have real reason not
to do it this way?

Moreover all stdio functions are protected by mutexes anyway (which is
the reason why we fgetc is so horribly slow and why we have
fgetc_unlocked)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
