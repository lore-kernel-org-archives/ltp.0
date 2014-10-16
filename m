Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xek68-0007la-Kf
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 12:24:04 +0000
Date: Thu, 16 Oct 2014 14:23:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141016122343.GE20676@rei.suse.de>
References: <1409153560-10176-1-git-send-email-mmarhefk@redhat.com>
	<20141015125601.GG5006@rei.suse.cz>
	<1887162987.52427068.1413453459206.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1887162987.52427068.1413453459206.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] containers: added netns/netns_interfaces.c
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> consider this patch discarded as it  was replaced with newer version:
> [PATCH v4] containers: added netns/netns_devices.sh and netns/netns_devices2.sh
> 
> the main reason was use of many system() calls in code what looks rather
> ugly, so I decided to rewrite it into shell script and also extend the test.

Ack.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
