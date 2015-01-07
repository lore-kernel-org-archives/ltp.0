Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Y8pn0-0000vg-8O
	for ltp-list@lists.sourceforge.net; Wed, 07 Jan 2015 12:32:42 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y8pmy-0004xz-Rh
	for ltp-list@lists.sourceforge.net; Wed, 07 Jan 2015 12:32:42 +0000
Date: Wed, 7 Jan 2015 07:32:34 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1910508304.3829751.1420633954389.JavaMail.zimbra@redhat.com>
In-Reply-To: <169945440.3971026.1420553236395.JavaMail.zimbra@redhat.com>
References: <1419664386-14888-1-git-send-email-liwang@redhat.com>
	<511980342.1455678.1419931434983.JavaMail.zimbra@redhat.com>
	<1667897429.3183348.1420341038221.JavaMail.zimbra@redhat.com>
	<124148100.2234995.1420452985543.JavaMail.zimbra@redhat.com>
	<1759699028.3904548.1420537912980.JavaMail.zimbra@redhat.com>
	<27844855.3137974.1420540536445.JavaMail.zimbra@redhat.com>
	<169945440.3971026.1420553236395.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] mem/hugeshmat: new case for hugepage leak
 inspection
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





----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 6 January, 2015 3:07:16 PM
> Subject: Re: [LTP] [PATCH] mem/hugeshmat: new case for hugepage leak inspection
> 
> > I'm assuming that both absolute address and sleep is not necessary.
> > I think I'll take some recent kernel, revert that patch and try to
> > reproduce
> > the failure.
> 
> Hi Jan,
> 
> I just tried kernel-3.10.0+ without the fixed patch, and I hit a CPU stuck
> issue
> with absolute address and sleep(3).

I tried the same with 2.6.18-92.el5. When I revert the patch I can reproduce the leak.
sleep(3) doesn't seem to have any effect, I think we can safely remove it.
Attaching at BOUNDARY however seems necessary. As soon as I change shmat to use "NULL",
the leak no longer happens, I'm not sure why that is.

+        if (huge_total != hugepages || huge_free != hugepages)
This condition in setup() seems to strict. I think we don't need all hugepages
to be free when test starts. 

Regards,
Jan


------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
