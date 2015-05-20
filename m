Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Yv4BQ-0005il-Mh
	for ltp-list@lists.sourceforge.net; Wed, 20 May 2015 13:37:16 +0000
Date: Wed, 20 May 2015 15:36:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150520133631.GA9052@rei.suse.de>
References: <1432024368-23287-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1432024368-23287-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] testcases/kernel/syscalls: make use of
 ARRAY_SIZE
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
To: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> --- a/testcases/kernel/syscalls/sysctl/sysctl01.c
> +++ b/testcases/kernel/syscalls/sysctl/sysctl01.c
> @@ -66,8 +66,6 @@ static int sysctl(int *name, int nlen, void *oldval, size_t * oldlenp,
>  	return syscall(__NR__sysctl, &args);
>  }
>  
> -#define SIZE(x) sizeof(x)/sizeof(x[0])
> -
>  struct utsname buf;
>  char osname[BUFSIZ];
>  size_t osnamelth;
> @@ -115,7 +113,7 @@ int main(int ac, char **av)
>  
>  		for (i = 0; i < TST_TOTAL; ++i) {
>  
> -			osnamelth = SIZE(osname);
> +			osnamelth = ARRAY_SIZE(osname);

These could be turned into simple sizeof(osname) as sizeof(char) == 1 by
definition.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
