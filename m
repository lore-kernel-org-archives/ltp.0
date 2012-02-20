Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RzRZO-0004lV-4x
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 11:38:14 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RzRZN-0001F1-E9
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 11:38:14 +0000
Received: by pbcum15 with SMTP id um15so6197388pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Feb 2012 03:38:07 -0800 (PST)
Message-ID: <4F423078.3030104@casparzhang.com>
Date: Mon, 20 Feb 2012 19:37:28 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1329735301-17676-1-git-send-email-caspar@casparzhang.com>
	<1329735301-17676-2-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1329735301-17676-2-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH 2/2] mm/ksm,oom: fix count_numa()
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
To: LTP List <ltp-list@lists.sourceforge.net>

On 02/20/2012 06:55 PM, Caspar Zhang wrote:
> This patch makes ksm on oom tests use the new count_numa() function.

oops, should be s/on/and. I've changed it in my local commit.

Caspar

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
