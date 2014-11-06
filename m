Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XmIPf-0007Ou-6f
	for ltp-list@lists.sourceforge.net; Thu, 06 Nov 2014 08:27:37 +0000
Date: Thu, 6 Nov 2014 09:26:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141106082653.GB1288@rei.nue.novell.com>
References: <1415251889-10596-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1415251889-10596-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] containers: fix three cases' exit status
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
> In iproute2 whose version is earlier than v2.6.39, ip
> command doesn't support netns object. In this condition,
> running three cases (netns_devices.sh, netns_devices2.sh
> and netns_isolation.sh) will exit with TFAIL. It is not
> suitable, so fix these cases' exit status with TCONF.

Again, it would be better to compare the versions rather than grepping
the output. And for this case it may even make sense to put the check
into a common script and source it in all the tests that needs it.

I.e. create netns_helper.sh and put the check in there.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
