Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UuJlE-0001oL-Oh
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 09:54:04 +0000
Date: Wed, 3 Jul 2013 11:55:30 +0200
From: chrubis@suse.cz
Message-ID: <20130703095530.GA2715@rei>
References: <1372842546-4596-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372842546-4596-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH RFC] lib: add tst_kvercmp2 to compare specific
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
>  include/test.h    |  5 +++++
>  lib/tst_kvercmp.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/include/test.h b/include/test.h
> index ee3efc3..a8e462b 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -172,6 +172,11 @@ char *get_high_address(void);
>  /* lib/tst_kvercmp.c */
>  void tst_getkver(int *k1, int *k2, int *k3);
>  int tst_kvercmp(int r1, int r2, int r3);
> +struct tst_kern_exv {
> +	char *dist_name;
> +	char *extra_ver;
> +};
> +int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers);

I would add newlines around the structure definition to keep it readable
but that is very minor.

>  /* lib/tst_is_cwd.c */
>  int tst_is_cwd_nfs(void);
> diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
> index cb4fd67..d791df0 100644
> --- a/lib/tst_kvercmp.c
> +++ b/lib/tst_kvercmp.c
> @@ -34,6 +34,7 @@
>  #include <unistd.h>
>  #include <string.h>
>  #include <sys/utsname.h>
> +#include "test.h"
>  
>  void get_kver(int *k1, int *k2, int *k3)
>  {
> @@ -66,3 +67,69 @@ int tst_kvercmp(int r1, int r2, int r3)
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
> +	char *cur_exv1, *tst_exv1;
> +#if !defined(linux)
> +	extern char *strsep();
> +	extern char *strchr();
> +#endif

Please refrain yourself from adding these workarounds for non Linux
systems. It does not make any sense to add them into the code that
parses Linux kernel version. :)

(And feel free to clean these from the rest of the file)

> +	uname(&uval);
> +	kver = uval.release;
> +	cur_exv = strchr(kver, '-');
> +	if (!cur_exv)
> +		return -1;
> +	cur_exv++;
> +	cur_exv1 = strsep(&cur_exv, ".");
> +	c1 = atoi(cur_exv1);
> +	tst_exv1 = strsep(&tst_exv, ".");
> +	t1 = atoi(tst_exv1);
> +	if ((ret = c1 - t1)) {
> +		return ret;
> +	} else if (!cur_exv && !tst_exv) {
> +		return 0;
> +	} else if (!cur_exv) {
> +		return -1;
> +	} else if (!tst_exv) {
> +		return 1;
> +	} else {
> +		c2 = atoi(cur_exv);
> +		t2 = atoi(tst_exv);
> +		return c2 - t2;
> +	}
> +}

I wonder if we can simplify this with a sscanf() and clever format
string...

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

This part looks Ok.

But perhaps we sould add a override mode too. It may happen that a fix
that arrived to vanilla x.y.c was backported to RHEL or SLES kernel
x.y.a so the extra version would not help. But adding this should be as
simple as adding over_ver into the extra version structure and using
that instead of the passed integers if it is not NULL. We may also add
this one later once we find such testcase.

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
