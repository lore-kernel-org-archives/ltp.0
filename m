Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1USRD8-00082P-QE
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 12:11:38 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1USRD7-0002Zy-Gu
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 12:11:38 +0000
Date: Wed, 17 Apr 2013 08:11:12 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <935467223.1827831.1366200672270.JavaMail.root@redhat.com>
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
> Sent: Wednesday, April 17, 2013 5:18:37 PM
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

Reviewed-by: Zhouping Liu <zliu@redhat.com>

-- 
Thanks,
Zhouping

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
