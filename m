Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZP8vB-0005Ha-An
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 12:44:49 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZP8v7-00066E-2H
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 12:44:49 +0000
Date: Tue, 11 Aug 2015 14:44:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150811124417.GA19789@rei.suse.de>
References: <1438927624-27401-1-git-send-email-sunyuan3@huawei.com>
	<20150810122832.GA25209@rei.suse.de> <55C94D78.5030502@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55C94D78.5030502@huawei.com>
Subject: Re: [LTP] [PATCH] Add tst_wait_record_childstatus function.
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
>      Yes. You are right. I agree with you.
> "tst_record_childstatus(NULL, -1);" can be used in userns01.

FYI: I've just pushed a patch that adds note to the
test-writing-guidelines documentation about this.

Have a look at the note at the end of this paragraph:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#227-doing-real-test-in-the-child-process

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
