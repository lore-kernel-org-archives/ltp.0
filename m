Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z5Dc6-0005me-6N
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2015 13:42:46 +0000
Date: Wed, 17 Jun 2015 15:41:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150617134136.GB3082@rei.suse.de>
References: <1434444799-29951-1-git-send-email-liwang@redhat.com>
	<20150616132109.GA17408@rei.suse.de>
	<266085602.15945003.1434547937242.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <266085602.15945003.1434547937242.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] futex: regression test for take hugepages into
 account when generating futex_key
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
> proper synchronization primitives ??
> I haven't used that. Could you show me a simple demo? 

That just means that one thread/process waits for some
message/file_change/sleeps in syscall instead of sleeping predefined
time and hoping that the other thread/process has done something
meanwhile.

Which is faster than sleeping blindly and also more error prone.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
