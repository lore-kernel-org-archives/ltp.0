Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1USOZQ-0005B0-0G
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 09:22:28 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1USOZM-0003v6-Nn
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 09:22:27 +0000
Date: Wed, 17 Apr 2013 05:22:15 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <786685475.1661263.1366190535675.JavaMail.root@redhat.com>
In-Reply-To: <516E68ED.3040507@gmail.com>
References: <516E68ED.3040507@gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V3]  Fix short of nodemask array.
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
To: Lans Zhang <lans.zhang2008@gmail.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Lans Zhang" <lans.zhang2008@gmail.com>
> To: "Jan Stancek" <jstancek@redhat.com>, "Zhouping Liu" <zliu@redhat.com>
> Cc: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>, ltp-list@lists.sourceforge.net
> Sent: Wednesday, 17 April, 2013 11:18:37 AM
> Subject: [PATCH V3] [LTP] Fix short of nodemask array.
> 
> Changes since V2:
> remove unused parameter in set_node()
> 
> In kernel, if user specified more nodes, e.g, 512 nodes, than the
> supported, e.g, 4 nodes, kernel will check if the non supported
> part, e.g, 508 nodes, is all zeroed in node bitmap. Currently, we
> are overrunning "nmask", whose length is shorter than MAXNODES,
> and where the unsupported bits should be cleared to pass the check.
> 
> Signed-off-by: Lans Zhang <lans.zhang2008@gmail.com>

Reviewed-by: Jan Stancek <jstancek@redhat.com>

Looks good to me, regards,
Jan

------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
