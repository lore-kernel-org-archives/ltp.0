Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WT9R2-0003y4-MK
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 12:29:28 +0000
Date: Thu, 27 Mar 2014 13:29:01 +0100
From: chrubis@suse.cz
Message-ID: <20140327122901.GB2620@rei>
References: <1394100261-12596-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1394100261-12596-2-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1394100261-12596-2-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/2] madvise/madvise02.c: extend EINVAL test
 for MADV_MERGEABLE and MADV_UNMERGEABLE advice
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
>   *  Copyright (c) International Business Machines  Corp., 2004
> - *  Copyright (c) Linux Test Project, 2013
> + *  Copyright (c) Linux Test Project, 2014

I've changed this line to:

 *  Copyright (c) Linux Test Project, 2013-2014

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
