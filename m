Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XHYRw-0006T2-W0
	for ltp-list@lists.sourceforge.net; Wed, 13 Aug 2014 13:18:45 +0000
Date: Wed, 13 Aug 2014 15:17:49 +0200
From: chrubis@suse.cz
Message-ID: <20140813131748.GA4864@rei.suse.cz>
References: <3f8381b9a1e1fc43c1bc47d416045e1e6fe3ae69.1406637055.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3f8381b9a1e1fc43c1bc47d416045e1e6fe3ae69.1406637055.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2 1/2] mem/oom: check for multiple outcomes if
 overcommit_memory is 0 or 1
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
> There is no guarantee that mmap() will fail before OOM tries to kill the
> process if overcommit is set to 0 or 1. So allow such tests to
> PASS if child is killed with SIGKILL.

Both looks good to me, acked.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
