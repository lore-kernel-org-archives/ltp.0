Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZWls5-0007UQ-0n
	for ltp-list@lists.sourceforge.net; Tue, 01 Sep 2015 13:45:09 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZWls4-0004L1-0a
	for ltp-list@lists.sourceforge.net; Tue, 01 Sep 2015 13:45:09 +0000
Date: Tue, 1 Sep 2015 15:44:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150901134427.GD27041@rei.suse.cz>
References: <1440152036-16859-1-git-send-email-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1440152036-16859-1-git-send-email-liwang@redhat.com>
Subject: Re: [LTP] [PATCH v2] ltp/pounder: Don't let the testing log output
 to /dev/tty
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
> +	out = fdopen(3, "w+");

This is just complicated way of doing out = stderr;

And I doubt that this will fail under normal circumstances.

So what about doing just out = stderr; or out = stdout instead?

Otherwise it looks fine and I'm OK with applying this before the
release.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
