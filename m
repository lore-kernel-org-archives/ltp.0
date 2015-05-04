Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YpHbw-0006Iz-KO
	for ltp-list@lists.sourceforge.net; Mon, 04 May 2015 14:44:44 +0000
Date: Mon, 4 May 2015 16:44:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150504144409.GB12401@rei.suse.de>
References: <1429840001-4970-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1429840001-4970-3-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1429840001-4970-3-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 3/5] hugemmap/hugemmap05: fix resource leak
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
> ensure close FILE pointer before return
> 
> Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> index 97d7689..8b9a05f 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> @@ -439,6 +439,7 @@ static int checksys(char *path, char *string, int value)
>  	if (atoi(buf) != value) {
>  		tst_resm(TFAIL, "%s is not %d but %d.", string, value,
>  			 atoi(buf));
> +		fclose(fp);
>  		return 1;
>  	}
>  	fclose(fp);
> @@ -474,6 +475,7 @@ static void init_hugepagesize(void)
>  		if (lookup(line, "Hugepagesize")) {
>  			tst_resm(TINFO, "Hugepagesize is %s kB", buf);
>  			hugepagesize = atoi(buf) * 1024;
> +			fclose(fp);
>  			return;
>  		}
>  	}

Applied, thanks.

Hint: These function can be replaced with SAFE_FILE_SCANF() and
      one comparsion.

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
