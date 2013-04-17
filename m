Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1USMwB-0006Lc-VZ
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 07:37:52 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1USMwA-0002YR-4D
	for ltp-list@lists.sourceforge.net; Wed, 17 Apr 2013 07:37:51 +0000
Date: Wed, 17 Apr 2013 03:37:35 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <849990288.1414874.1366184255066.JavaMail.root@redhat.com>
In-Reply-To: <516E2E6C.2000408@gmail.com>
References: <516E2E6C.2000408@gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V2] Fix short of nodemask array.
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
> To: "Zhouping Liu" <zliu@redhat.com>, "Jan Stancek" <jstancek@redhat.com>
> Cc: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>, ltp-list@lists.sourceforge.net
> Sent: Wednesday, 17 April, 2013 7:09:00 AM
> Subject: [LTP][PATCH V2] Fix short of nodemask array.
> 
> Changes since V1:
> 1. Enhance patch header.
> 2. Use BITS_PER_LONG and set_node() to simplify the logic.
> 
> In kernel, if user specified more nodes, e.g, 512 nodes, than the
> supported, e.g, 4 nodes, kernel will check if the non supported
> part, e.g, 508 nodes, is all zeroed in node bitmap. Currently, we
> are overrunning "nmask", whose length is shorter than MAXNODES,
> and where the unsupported bits should be cleared to pass the check.
> 
> Signed-off-by: Lans Zhang <lans.zhang2008@gmail.com>

Hi,

'v' should be probably dropped here, since it's not used and rest
of patch uses 2 parameters anyway:

> +static inline void set_node(unsigned long *array, unsigned int node,
> +                            unsigned int v)
> +{
> +	array[node / BITS_PER_LONG] |= 1UL << (node % BITS_PER_LONG);
> +}
> 

Other than that, it looks good to me.

Regards,
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
