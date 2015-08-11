Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZPEBT-0001Qj-P1
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 18:21:59 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZPEBO-0003LO-GA
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 18:21:59 +0000
Date: Tue, 11 Aug 2015 20:21:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150811182127.GC24227@rei.suse.de>
References: <1436424468-11756-1-git-send-email-alexey.kodanev@oracle.com>
	<1436424468-11756-17-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436424468-11756-17-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 16/23] network/virt: add macvtap01 test
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

> +for m in $modes; do
> +	tst_resm TINFO "add $virt_type with mode '$m'"
> +
> +	virt_add ltp_v0 mode $m > /dev/null 2>&1
> +	if [ $? -ne 0 ]; then
> +		tst_resm TCONF "iproute or kernel doesn't support mode '$m'"

		shouldn't we rather call continue here, since we issued
		TCONF but without it we will proceed with PASS/FAIL from
		the virt_add_delete_test. Or am I mistaken?

> +	else
> +		ROD_SILENT "ip li delete ltp_v0"
> +	fi
> +
> +	virt_add_delete_test "mode $m"
> +
> +	start_id=$(($start_id + $virt_count))
> +done
> +
> +tst_exit
> -- 
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> Don't Limit Your Business. Reach for the Cloud.
> GigeNET's Cloud Solutions provide you with the tools and support that
> you need to offload your IT needs and focus on growing your business.
> Configured For All Businesses. Start Your Cloud Today.
> https://www.gigenetcloud.com/
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
