Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RvVrC-0003EG-Ok
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 15:24:22 +0000
Date: Thu, 9 Feb 2012 16:38:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120209153817.GC29442@saboteur.suse.cz>
References: <20120125162602.GB28713@saboteur.suse.cz>
	<1327564464-27350-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1327564464-27350-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 2/2] aio_suspend-8-1: use aio_error to check
 completion instead
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
Cc: ltp-list@lists.sourceforge.net, vapier@gentoo.org

Hi!
>  	if (ret) {
>  		printf(TNAME " Error at aio_suspend() %d: %s\n", errno, strerror(errno));
>  		for (i=0; i<NUM_AIOCBS; i++)
> @@ -211,7 +180,9 @@ main ()
>  		if (i == WAIT_FOR_AIOCB)
>  			continue;
>  
> -	  	err = aio_error(aiocbs[i]);
> +		do {
> +			err = aio_error(aiocbs[i]);
> +		} while (err == EINPROGRESS);

I've looked carefully through the test and this part shouldn't be needed
as when we got here, the singnal handler for list completion was
allready called, or not?

I think that simple err = aio_error(aiocbs[i]) should work in this case.

The rest of the patch seems to be correct.

>  		ret = aio_return(aiocbs[i]);
>  
>  		if ((err != 0) && (ret != BUF_SIZE)) {

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
