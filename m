Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UwzCs-0000NC-7t
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 18:33:38 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwzCq-0004px-98
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 18:33:38 +0000
Date: Wed, 10 Jul 2013 14:33:26 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1212845049.2016896.1373481206257.JavaMail.root@redhat.com>
In-Reply-To: <51DD9B64.7050802@casparzhang.com>
References: <1373356491-15338-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<51DD9B64.7050802@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V3] lib: add tst_kvercmp2 to compare specific
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
To: Caspar Zhang <caspar@casparzhang.com>, Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> Cc: "LTP" <ltp-list@lists.sourceforge.net>, "Cyril Hrubis" <chrubis@suse.cz>, "Garrett Cooper" <yanegomi@gmail.com>,
> "Mike Frysinger" <vapier@gentoo.org>, jstancek@redhat.com
> Sent: Wednesday, 10 July, 2013 7:35:32 PM
> Subject: Re: [PATCH V3] lib: add tst_kvercmp2 to compare specific vendor extra kernel versions
> 
> On 07/09/2013 03:54 PM, Wanlong Gao wrote:
> > We can now test specific verdor kernel versions in
> > test cases like:
> >
> > static struct tst_kern_exv exv[] = {
> > 	{"RHEL6", "234"},
> > 	{"SLES10", "0.91"},
> > 	{NULL, NULL}
> > };
> >
> > ...
> >
> > 	if (tst_kvercmp2(2, 6, 25, exv) < 0)
> > 		...
> > ...
> >
> > Thank you for Cyril's suggestion.
> >
> >
> > Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> > ---
> >   include/test.h    |  7 +++++++
> >   lib/tst_kvercmp.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
> >   2 files changed, 50 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/test.h b/include/test.h
> > index ee3efc3..a76fafc 100644
> > --- a/include/test.h
> > +++ b/include/test.h
> > @@ -173,6 +173,13 @@ char *get_high_address(void);
> >   void tst_getkver(int *k1, int *k2, int *k3);
> >   int tst_kvercmp(int r1, int r2, int r3);
> >
> > +struct tst_kern_exv {
> > +	char *dist_name;
> > +	char *extra_ver;
> > +};
> > +
> > +int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers);
> > +
> >   /* lib/tst_is_cwd.c */
> >   int tst_is_cwd_nfs(void);
> >   int tst_is_cwd_v9fs(void);
> > diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
> > index cb4fd67..15fb571 100644
> > --- a/lib/tst_kvercmp.c
> > +++ b/lib/tst_kvercmp.c
> > @@ -34,15 +34,13 @@
> >   #include <unistd.h>
> >   #include <string.h>
> >   #include <sys/utsname.h>
> > +#include "test.h"
> >
> >   void get_kver(int *k1, int *k2, int *k3)
> >   {
> >   	struct utsname uval;
> >   	char *kver;
> >   	char *r1, *r2, *r3;
> > -#if !defined(linux)
> > -	extern char *strsep();	/* shut up some compilers */
> > -#endif
> >
> >   	uname(&uval);
> >   	kver = uval.release;
> > @@ -66,3 +64,45 @@ int tst_kvercmp(int r1, int r2, int r3)
> >
> >   	return currver - testver;
> >   }
> > +
> > +static int tst_kexvcmp(char *tst_exv, char *cur_ver)
> > +{
> > +	int c1 = 0, c2 = 0, t1 = 0, t2 = 0;
> > +	int ret;
> > +
> > +	sscanf(cur_ver, "%*d.%*d.%*d-%d.%d", &c1, &c2);
> > +	sscanf(tst_exv, "%d.%d", &t1, &t2);
> > +	if ((ret = c1 - t1))
> 
> not sure if the brackets are duplicated...

What caught my (and checkpatch's) eye is that these are assignments in if condition,
but I'm not sure how strictly we take checkpatch output.

> 
> > +		return ret;
> > +	else
> > +		return c2 - t2;
> > +}
> > +
> > +int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers)
> > +{
> > +	int ret;
> > +	int i;
> > +	struct utsname uval;
> > +	char *kver;
> > +	const char *cur_dist_name = NULL;
> > +
> > +	if ((ret = tst_kvercmp(r1, r2, r3)))
> 
> here as well.
> 
> > +		return ret;
> > +
> > +	uname(&uval);
> > +	kver = uval.release;
> > +	if (strstr(kver, ".el5")) {
> > +		cur_dist_name = "RHEL5";
> > +	} else if (strstr(kver, ".el6")) {
> > +		cur_dist_name = "RHEL6";
> > +	} else {
> > +		return ret;
> > +	}
> > +
> > +	for (i = 0; vers[i].dist_name; i++) {
> > +		if (!strcmp(vers[i].dist_name, cur_dist_name))
> > +			return tst_kexvcmp(vers[i].extra_ver, kver);
> > +	}
> > +
> > +	return ret;
> > +}
> >
> 
> Others look good.

Looks good to me as well.

Regards,
Jan

> 
> Reviewed-by: Caspar Zhang <caspar@casparzhang.com>
> 

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
