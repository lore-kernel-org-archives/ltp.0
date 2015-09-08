Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZZEgC-0006Fj-AW
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 08:55:04 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZEgA-0001as-Tq
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 08:55:04 +0000
Date: Tue, 8 Sep 2015 10:54:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150908085418.GA30154@rei.suse.cz>
References: <16f324dac1804ac5d787d210b97187e07766b47d.1441699315.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16f324dac1804ac5d787d210b97187e07766b47d.1441699315.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] linux_syscall_numbers: speed up generation
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Replace cat with echo, which should be a builtin function
> for most shells. Avoiding to spawn 'cat' for every syscall
> entry can save time when generating linux_syscall_numbers.h:

Nice catch, acked.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
