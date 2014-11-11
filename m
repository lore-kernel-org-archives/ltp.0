Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XoBJb-0006K3-5Q
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 13:16:59 +0000
Date: Tue, 11 Nov 2014 14:16:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141111131618.GD29189@rei>
References: <1415258674-17261-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1415609164-10297-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1415609164-10297-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 1/2] containers: change check_iproute()
 behavior in netns/netns_helper.h
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +static int check_iproute(int spe_ipver)
>  {
>  	FILE *ipf;
>  	int n;
> -	unsigned int ipver = 0;
> +	unsigned int cur_ipver = 0;
> +	int ret;
>  
>  	ipf = popen("ip -V", "r");
>  	if (ipf == NULL)
>  		tst_brkm(TCONF, NULL,
>  				"Failed while opening pipe for iproute check");
>  
> -	n = fscanf(ipf, "ip utility, iproute2-ss%u", &ipver);
> -	if (n < 1 || ipver < IPROUTE_MIN_VER)
> +	n = fscanf(ipf, "ip utility, iproute2-ss%u", &cur_ipver);
> +	if (n < 1) {
> +		pclose(ipf);
>  		tst_brkm(TCONF, NULL,
> -			"iproute tools do not support setting network namespaces");
> +			"Failed while obtaining version for iproute check");
> +	} else {
> +		if (cur_ipver < spe_ipver)
> +			ret = -1;
> +		else if (cur_ipver == spe_ipver)
> +			ret = 0;
> +		else
> +			ret = 1;
> +	}

Again why bother with return value when all the testcases just needs to
know if ip is newer than some version?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
