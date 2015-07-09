Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1ZDDVW-0004bA-FF
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 15:13:02 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZDDVU-0007yd-Ob
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 15:13:02 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id A7935BE28E
	for <ltp-list@lists.sourceforge.net>;
	Thu,  9 Jul 2015 15:12:54 +0000 (UTC)
Received: from tarantula.localdomain (ovpn-113-174.phx2.redhat.com
	[10.3.113.174])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t69FCq8n003536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 11:12:54 -0400
Date: Thu, 9 Jul 2015 10:12:52 -0500
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20150709151252.GS17625@tarantula.localdomain>
References: <20150708203358.GA24428@tarantula.localdomain>
	<1538874773.14815420.1436428293231.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1538874773.14815420.1436428293231.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] proc/proc01.c: ignore stable_secret files
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

On Thu, Jul 09, 2015 at 03:51:33AM -0400, Jan Stancek wrote:
> > Ignore the stable_secret files in the proc01 test.
>
> Can we add it to known_issues array instead? It looks like there's no
> problem
> with opening/reading the file (in sense that would cause adverse
> effects,
> e.g. hang the test).

For some reason, I thought the known_issues array could not handle
wildcards like '*' when I looked at it last night, but I see now that
wildcards are perfectly fine.  I'll re-work the patch.

Thanks!
Jeff

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
