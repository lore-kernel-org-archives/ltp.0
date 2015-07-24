Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZIciZ-0006B7-82
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2015 13:08:51 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZIciX-0000B5-WA
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2015 13:08:51 +0000
Date: Fri, 24 Jul 2015 09:08:43 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <264408049.3940234.1437743323021.JavaMail.zimbra@redhat.com>
In-Reply-To: <DUB407-EAS55640DF929C2D5CE78788E85810@phx.gbl>
References: <DUB407-EAS55640DF929C2D5CE78788E85810@phx.gbl>
MIME-Version: 1.0
Subject: Re: [LTP] netns tests failure on ubuntu
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
To: Cristian Valean <cristian.valean@live.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Cristian Valean" <cristian.valean@live.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 24 July, 2015 10:15:18 AM
> Subject: [LTP] netns tests failure on ubuntu
> 
> 
> 
> Hello,
> 
> All the netns tests are failing when running on ubuntu 14.04.2 from my run.
> Is there any configuration to be made or how I can troubleshoot this
> further?
> 

I'd suggest adding "set -x" to those scripts, that should give you
much more verbose output to start with.

Regards,
Jan

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
