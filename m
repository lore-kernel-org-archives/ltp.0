Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rl0DB-0000cn-MQ
	for ltp-list@lists.sourceforge.net; Wed, 11 Jan 2012 15:35:37 +0000
Date: Wed, 11 Jan 2012 16:47:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120111154701.GG7143@saboteur.suse.cz>
References: <1326135670-18584-1-git-send-email-eguan@redhat.com>
	<1326290366-7464-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1326290366-7464-1-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH v2] syscalls/sendfile08: new test case for
 sendfile(2) syscall
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
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> A bug in the splice code had caused the file position on the write side
> of the sendfile system call to be incorrectly set to the read side file
> position. This can result in the data being written to an incorrect offset.
> 
> This is a regression test for kernel commit
> 2cb4b05e7647891b46b91c07c9a60304803d1688
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> v2:
> 	Remove unnecessary comments
> 
>  runtest/syscalls                                |    2 +
>  testcases/kernel/syscalls/sendfile/sendfile08.c |  131 +++++++++++++++++++++++
>  2 files changed, 133 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/sendfile/sendfile08.c

Commited, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
