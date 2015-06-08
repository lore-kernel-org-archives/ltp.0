Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z1zpy-0002r3-4E
	for ltp-list@lists.sourceforge.net; Mon, 08 Jun 2015 16:23:46 +0000
Date: Mon, 8 Jun 2015 18:22:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150608162241.GA16394@rei.suse.de>
References: <1433496634-21424-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433496634-21424-1-git-send-email-sunyuan3@huawei.com>
Subject: Re: [LTP] [PATCH V2] Fix the return value error of read_shares_file.
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
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> -inline int error_function(char *msg1, char *msg2)
> +inline void error_function(char *msg1, char *msg2)
>  {
>  	fprintf(stdout, "ERROR: %s ", msg1);
>  	fprintf(stdout, "%s\n", msg2);
> -	return -1;
> +	return;

I've removed this useless return and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
