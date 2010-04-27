Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1O6iZM-0006ie-1X
	for ltp-list@lists.sourceforge.net; Tue, 27 Apr 2010 11:03:12 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O6iZL-00067B-19
	for ltp-list@lists.sourceforge.net; Tue, 27 Apr 2010 11:03:12 +0000
Date: Tue, 27 Apr 2010 07:03:03 -0400 (EDT)
From: Caspar ZHANG <czhang@redhat.com>
Message-ID: <1619776181.1046641272366183715.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <350606720.1046541272366037217.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>


----- "Garrett Cooper" <yanegomi@gmail.com> wrote:

> On Apr 27, 2010, at 2:23 AM, Caspar ZHANG wrote:
> 
> > <syscalls-utimensat01-run-sudo-without-tty.patch>
> 
> 	What good would this do if the value's deleted and not restored? It's
> better to document this IMO because then it at least brings the issue
> to light as there may be other areas of the tree that require this
> kind of intervention.

I didn't realize this matter, thanks for pointing it out. So what if adding 
the `Defaults requiretty' value back after this test finished? 

Thanks,
Caspar

> Thanks,
> -Garrett

-- 
Kernel Associate Quality Engineer
Red Hat Inc. (Beijing R&D Branch)

Red Hat China R&D Branch Unit 907, North Tower C, 
  Raycom Infotech Park, No.2 Kexueyuan Nanlu, 
  Haidian District, Beijing 100190

TEL: +86-10-62608150
Web: http://www.redhat.com/

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
