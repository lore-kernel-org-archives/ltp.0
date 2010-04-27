Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O6iHP-00052U-Fz
	for ltp-list@lists.sourceforge.net; Tue, 27 Apr 2010 10:44:39 +0000
Received: from mail-pz0-f195.google.com ([209.85.222.195])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O6iHO-00071Y-Da
	for ltp-list@lists.sourceforge.net; Tue, 27 Apr 2010 10:44:39 +0000
Mime-Version: 1.0 (Apple Message framework v1078)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1982387996.1043141272360230694.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Tue, 27 Apr 2010 03:44:30 -0700
Message-Id: <9EAC00F5-8C83-4357-A3BE-A5E5E80CF6F0@gmail.com>
References: <1982387996.1043141272360230694.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] UTIMENSAT test fails hugely
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
To: Caspar ZHANG <czhang@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Apr 27, 2010, at 2:23 AM, Caspar ZHANG wrote:

> <syscalls-utimensat01-run-sudo-without-tty.patch>

	What good would this do if the value's deleted and not restored? It's better to document this IMO because then it at least brings the issue to light as there may be other areas of the tree that require this kind of intervention.
Thanks,
-Garrett
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
