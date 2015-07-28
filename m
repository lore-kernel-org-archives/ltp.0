Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZK2mM-0002GW-2U
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2015 11:10:38 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZK2mK-00064j-Om
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2015 11:10:38 +0000
Date: Tue, 28 Jul 2015 07:10:30 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1035562052.1262041.1438081830548.JavaMail.zimbra@redhat.com>
In-Reply-To: <1437987192-7436-1-git-send-email-liwang@redhat.com>
References: <1437987192-7436-1-git-send-email-liwang@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [Patch v2] syscalls/sysfs: replace syscall() macro by
 ltp_syscall()
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
> To: ltp-list@lists.sourceforge.net
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Monday, 27 July, 2015 10:53:12 AM
> Subject: [Patch v2] syscalls/sysfs: replace syscall() macro by ltp_syscall()
> 
> v1 ---> v2
> 	a. remove the __NR_sysfs macro defined
> 	b. replace syscall() with ltp_syscall()
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Pushed with modified commit message, that reflects final version of patch.

Thanks,
Jan

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
