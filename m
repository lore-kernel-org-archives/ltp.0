Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMHyf-0003Lf-WA
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2015 15:48:38 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMHyc-0007VZ-Mj
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2015 15:48:37 +0000
Date: Mon, 3 Aug 2015 17:48:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150803154813.GB7852@rei.suse.de>
References: <55BEFD37.9090502@cn.fujitsu.com>
	<1438582432-10124-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1438582432-10124-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] open/open13.c: add O_PATH flag test
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
To: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +static void verify_fchown(void)
> +{
> +	uid_t tuid = 1000;
> +	gid_t tgid = 1000;
> +
> +	TEST(fchown(fd, tuid, tgid));

Any reason why don't we pass the numbers directly to the call?

I.e. TEST(fchonw(fd, 1000, 1000)); ?

Otherwise this looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
