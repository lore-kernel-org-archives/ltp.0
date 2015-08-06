Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZNL4V-0007ex-QM
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2015 13:18:59 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZNL4R-0008Vm-Lg
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2015 13:18:59 +0000
Date: Thu, 6 Aug 2015 15:18:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150806131831.GA12972@rei.suse.de>
References: <1438838680-9954-1-git-send-email-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1438838680-9954-1-git-send-email-liwang@redhat.com>
Subject: Re: [LTP] [PATCH v2] ipc/msgrcv: add new testcase msgrcv08
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +	if ((size_t)sret != sizeof(msbs.mtext))
> +		tst_brkm(TBROK, NULL, "received %zi, expected %zu\n",
> +			(ssize_t)sret, (size_t)sizeof(msbs.mtext));

I've removed these cast completly (since sret is ssize_t allready and
the same for the sizeof()). Fixed the commit message and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
