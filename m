Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwAnJ-0003ot-K7
	for ltp-list@lists.sourceforge.net; Mon, 08 Jul 2013 12:43:53 +0000
Date: Mon, 8 Jul 2013 14:45:28 +0200
From: chrubis@suse.cz
Message-ID: <20130708124528.GE23579@rei.Home>
References: <1372930628-27064-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372930628-27064-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH V2] lib: add tst_kvercmp2 to compare specific
 vendor extra kernel versions
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Garrett Cooper <yanegomi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  include/test.h    |  7 ++++++
>  lib/tst_kvercmp.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 69 insertions(+), 3 deletions(-)
> 
> diff --git a/include/test.h b/include/test.h
> index ee3efc3..a76fafc 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -173,6 +173,13 @@ char *get_high_address(void);
>  void tst_getkver(int *k1, int *k2, int *k3);
>  int tst_kvercmp(int r1, int r2, int r3);
>  
> +struct tst_kern_exv {
> +	char *dist_name;
> +	char *extra_ver;
> +};
> +
> +int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers);
> +
>  /* lib/tst_is_cwd.c */
>  int tst_is_cwd_nfs(void);
>  int tst_is_cwd_v9fs(void);
> diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
> index cb4fd67..5ca9e21 100644
> --- a/lib/tst_kvercmp.c
> +++ b/lib/tst_kvercmp.c
> @@ -34,15 +34,13 @@
>  #include <unistd.h>
>  #include <string.h>
>  #include <sys/utsname.h>
> +#include "test.h"
>  
>  void get_kver(int *k1, int *k2, int *k3)
>  {
>  	struct utsname uval;
>  	char *kver;
>  	char *r1, *r2, *r3;
> -#if !defined(linux)
> -	extern char *strsep();	/* shut up some compilers */
> -#endif
>  
>  	uname(&uval);
>  	kver = uval.release;
> @@ -66,3 +64,64 @@ int tst_kvercmp(int r1, int r2, int r3)
>  
>  	return currver - testver;
>  }
> +
> +static int tst_kexvcmp(char *tst_exv)
> +{
> +	struct utsname uval;
> +	char *kver;
> +	char *cur_exv;
> +	int c1, c2, t1, t2;
> +	int ret;
> +	char *cur_exv1;
> +
> +	uname(&uval);
> +	kver = uval.release;
> +	cur_exv = strchr(kver, '-');
> +	if (!cur_exv)
> +		return -1;
> +	cur_exv++;
> +	sscanf(tst_exv, "%d.%d", &t1, &t2);

The sscanf returns numer of succesfull conversions, make use of that.

Moreover we can avoid some of the strchr on cur_exv with supression
modifier '*' and make the version detection more robust at the same
time.

Following statement can parse kernel version, fill the extra version
into c1 and c2 and the return value should cointain number of assigned
conversion (2 if both c1 and c2 were filled).

	ret = sscanf(cur_exv, "%*d.%*d.%*d-%d.%d", &c1, &c2);

> +	cur_exv1 = strsep(&cur_exv, ".");
> +	c1 = atoi(cur_exv1);
> +	if ((ret = c1 - t1)) {
> +		return ret;
> +	} else if (!cur_exv && !t2) {
> +		return 0;
> +	} else if (!cur_exv) {
> +		return -1;
> +	} else if (!t2) {
> +		return 1;
> +	} else {
> +		c2 = atoi(cur_exv);
> +		return c2 - t2;
> +	}
> +}
>
> +int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers)
> +{
> +	int ret;
> +	int i;
> +	struct utsname uval;
> +	char *kver;
> +	const char *cur_dist_name = NULL;
> +
> +	if ((ret = tst_kvercmp(r1, r2, r3)))
> +		return ret;
> +
> +	uname(&uval);
> +	kver = uval.release;
> +	if (strstr(kver, ".el5")) {
> +		cur_dist_name = "RHEL5";
> +	} else if (strstr(kver, ".el6")) {
> +		cur_dist_name = "RHEL6";
> +	} else {
> +		return ret;
> +	}
> +
> +	for (i = 0; vers[i].dist_name; i++) {
> +		if (!strcmp(vers[i].dist_name, cur_dist_name))
> +			return tst_kexvcmp(vers[i].extra_ver);
> +	}
> +
> +	return ret;
> +}

This part looks Ok. I don't like that uname() is called twice
unnecessarily I would just pass the result from the first one to the
tst_kexvcmp, but that is very minor.

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
