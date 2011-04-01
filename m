Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q5flw-0004j1-4M
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 14:56:24 +0000
Date: Fri, 1 Apr 2011 17:19:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110401151941.GB12082@saboteur.suse.cz>
References: <4D8BFF4F.8060907@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D8BFF4F.8060907@cn.fujitsu.com>
Subject: Re: [LTP] [POSIX][PATCH]Determine the completion by the associated
 error using aio_error
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  	/* Check selected request has not completed yet */
> -	if (received_selected) {
> +	if (EINPROGRESS != aio_error(aiocbs[WAIT_FOR_AIOCB])) {

Not that this is wrong, but it's kind of common sence to write the
constants on the right side of comparsion.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
