Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xe4Jw-0005We-SZ
	for ltp-list@lists.sourceforge.net; Tue, 14 Oct 2014 15:47:32 +0000
Date: Tue, 14 Oct 2014 17:47:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141014154711.GA26724@rei>
References: <091fa8ce5be96478cf31477561e2e90e9d5f7faa.1413201833.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <091fa8ce5be96478cf31477561e2e90e9d5f7faa.1413201833.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH 1/2 v3] add LTP_DATAROOT and tst_dataroot()
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> LTP_DATAROOT (test.sh) and tst_dataroot (libltp) define directory
> which holds test data files.
> 
> If LTPROOT is defined, it is $LTPROOT/testcases/data/$TCID
> otherwise it's $CWD/datafiles (where CWD is current working
> directory, before any call to tst_tmdir())

...

>  2.1.3 Subexecutables
>  ^^^^^^^^^^^^^^^^^^^^
> diff --git a/include/tst_resource.h b/include/tst_resource.h
> index a02a313..94c24b7 100644
> --- a/include/tst_resource.h
> +++ b/include/tst_resource.h
> @@ -41,6 +41,9 @@
>  
>  #include "test.h"
>  
> +void tst_dataroot_init(void);

Do we really need to export this function? The only usage for it IMHO
will be the test for the tst_dataroot() function itself. I would rather
see three tests one for each scenario and keep the test library API as
minimal as possible.

> +const char *tst_dataroot(void);
> +

...

> diff --git a/lib/tst_resource.c b/lib/tst_resource.c
> index 54d4795..7c8deee 100644
> --- a/lib/tst_resource.c
> +++ b/lib/tst_resource.c
> @@ -21,9 +21,61 @@
>   * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>   */
>  
> +#include <pthread.h>
>  #include "tst_resource.h"
>  #include "ltp_priv.h"
>  
> +#ifndef PATH_MAX
> +#ifdef MAXPATHLEN
> +#define PATH_MAX	MAXPATHLEN
> +#else
> +#define PATH_MAX	1024
> +#endif
> +#endif
> +
> +static pthread_mutex_t tmutex = PTHREAD_MUTEX_INITIALIZER;
> +static char dataroot[PATH_MAX];
> +extern char *TCID;
> +
> +void tst_dataroot_init(void)
> +{
> +	const char *ltproot = getenv("LTPROOT");
> +	char curdir[PATH_MAX];
> +	const char *startdir;
> +	int ret;
> +
> +	/* 1. if LTPROOT is set, use $LTPROOT/testcases/data/$TCID
> +	 * 2. else if startwd is set by tst_tmdir(), use $STARWD/datafiles
> +	 * 3. else use $CWD/datafiles */
> +	if (ltproot) {
> +		ret = snprintf(dataroot, PATH_MAX, "%s/testcases/data/%s",
> +			ltproot, TCID);
> +	} else {
> +		startdir = tst_get_startwd();
> +		if (startdir[0] == 0) {
> +			if (getcwd(curdir, PATH_MAX) == NULL)
> +				tst_brkm(TBROK | TERRNO, NULL,
> +					"tst_dataroot getcwd");
> +			startdir = curdir;
> +		}
> +		ret = snprintf(dataroot, PATH_MAX, "%s/datafiles", startdir);
> +	}
> +
> +	if (ret < 0 || ret >= PATH_MAX)
> +		tst_brkm(TBROK, NULL, "tst_dataroot snprintf: %d", ret);
> +}
> +
> +const char *tst_dataroot(void)
> +{
> +	if (dataroot[0] == 0) {
> +		pthread_mutex_lock(&tmutex);
> +		if (dataroot[0] == 0)
> +			tst_dataroot_init();
> +		pthread_mutex_unlock(&tmutex);
> +	}

That is a bit too preemptive but generally fine, but I would use
pthread_once() here instead.

> +	return dataroot;
> +}
> +
>  static int file_copy(const char *file, const int lineno,
>                       void (*cleanup_fn)(void), const char *path,
>  		     const char *filename, const char *dest)
> @@ -56,15 +108,15 @@ void tst_resource_copy(const char *file, const int lineno,
>  		dest = ".";
>  
>  	const char *ltproot = getenv("LTPROOT");
> +	const char *dataroot = tst_dataroot();
> +
> +	/* look for data files in $LTP_DATAROOT, $LTPROOT/testcases/bin
> +	 * and $CWD */
> +	if (file_copy(file, lineno, cleanup_fn, dataroot, filename, dest))
> +		return;
>  
>  	if (ltproot != NULL) {
> -		/* the data are either in testcases/data or testcases/bin */
>  		char buf[strlen(ltproot) + 64];
> -
> -		snprintf(buf, sizeof(buf), "%s/testcases/data", ltproot);
> -
> -		if (file_copy(file, lineno, cleanup_fn, buf, filename, dest))
> -			return;
>  		
>  		snprintf(buf, sizeof(buf), "%s/testcases/bin", ltproot);

Hmm, maybe we can omit looking into testcases/bin/, since the
directory to store datafiles is well defined now (and there does not
seems to be any testcases that rely on that behavior).

> @@ -72,9 +124,8 @@ void tst_resource_copy(const char *file, const int lineno,
>  			return;
>  	}
>  
> +	/* try directory test started in as last resort */
>  	const char *startwd = tst_get_startwd();
> -
> -	/* try directory test started int first */
>  	if (file_copy(file, lineno, cleanup_fn, startwd, filename, dest))
>  		return;
>  
> diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> index 10282f4..eecbfba 100644
> --- a/testcases/lib/test.sh
> +++ b/testcases/lib/test.sh
> @@ -144,4 +144,7 @@ export TST_TOTAL="$TST_TOTAL"
>  # Setup LTPROOT, default to current directory if not set
>  if [ -z "$LTPROOT" ]; then
>  	export LTPROOT="$PWD"
> +	export LTP_DATAROOT="$LTPROOT/datafiles"
> +else
> +	export LTP_DATAROOT="$LTPROOT/testcases/data/$TCID"
>  fi


Otherwise it looks very good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
