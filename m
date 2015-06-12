Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Z3L8I-0005yk-1T
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2015 09:20:14 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z3L8G-0004EB-Dp
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2015 09:20:14 +0000
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5C9K6xQ001092
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Jun 2015 05:20:06 -0400
Date: Fri, 12 Jun 2015 05:20:05 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <580330768.1000977.1434100805960.JavaMail.zimbra@redhat.com>
In-Reply-To: <1218117106.10688161.1433424005317.JavaMail.zimbra@redhat.com>
References: <0412ecc6e0cec73921a692ba87443a486bc53193.1433422701.git.jstancek@redhat.com>
	<20150604130435.GB7095@rei.suse.de>
	<1218117106.10688161.1433424005317.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] mem/oom: allocate memory using multiple threads
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
To: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Cyril Hrubis" <chrubis@suse.cz>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Thursday, 4 June, 2015 3:20:05 PM
> Subject: Re: [LTP] [PATCH v2] mem/oom: allocate memory using multiple threads
> I'll wait couple days, if someone else wants to comment on patch and
> then post or commit the version with -pthread.

Pushed with fixed -pthread.

Regards,
Jan

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
