Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZKq52-0001ux-Cb
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 15:49:12 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZKq51-0001Tb-By
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 15:49:12 +0000
Date: Thu, 30 Jul 2015 17:48:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150730154853.GC9874@rei.suse.de>
References: <1437058074-14800-1-git-send-email-liuhangbin@gmail.com>
	<20150730154636.GA9874@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150730154636.GA9874@rei.suse.de>
Subject: Re: [LTP] [PATCHv4 1/2] testcases/lib/test.sh: add tst_retry() to
 ensure cmd exec succeed
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> I've added a TCONF message in case that we failed to run the command,

I mean TINFO.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
