Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2Hyd-0006jd-EB
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 11:45:55 +0000
Date: Tue, 9 Jun 2015 13:44:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609114450.GA26486@rei.suse.de>
References: <1431518085-8950-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1431518085-8950-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] lib6/in6_2: don't assume that machine has 'eth0'
 interface name
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
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/network/lib6/in6_02.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/network/lib6/in6_02.c b/testcases/network/lib6/in6_02.c
> index fea1827..dadb2a5 100644
> --- a/testcases/network/lib6/in6_02.c
> +++ b/testcases/network/lib6/in6_02.c
> @@ -255,4 +255,36 @@ void initest(void)
>  void setup(void)
>  {
>  	TEST_PAUSE;
> +
> +	tst_resm(TINFO, "get interface name from LHOST_IFACES var");
> +
> +	char *ifnames = getenv("LHOST_IFACES");
> +
> +	if (!ifnames) {
> +		tst_resm(TWARN, "LHOST_IFACES not defined, default to eth0");
> +		return;
> +	}

Hmm, why not to use sscanf() instead?

sscanf(ifnames, "%ms", &name);

And even when we want to be compatible before glibc 2.7 (2007) we can
do:

static char *name[256];

sscanf(ifnames, "%255s", &name);

> +	tst_resm(TINFO, "change default 'eth0' name to '%s'", name);
> +	n2i[1].name = name;
>  }
> -- 
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> One dashboard for servers and applications across Physical-Virtual-Cloud 
> Widest out-of-the-box monitoring support with 50+ applications
> Performance metrics, stats and reports that give you Actionable Insights
> Deep dive visibility with transaction tracing using APM Insight.
> http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
