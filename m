Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WwW42-0003Xe-Rd
	for ltp-list@lists.sourceforge.net; Mon, 16 Jun 2014 12:31:06 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WwW41-0002CX-1c
	for ltp-list@lists.sourceforge.net; Mon, 16 Jun 2014 12:31:06 +0000
Message-ID: <539EE378.3000600@oracle.com>
Date: Mon, 16 Jun 2014 16:30:48 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1395930175-3138-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1395930175-3138-4-git-send-email-stanislav.kholmanskikh@oracle.com>
	<7096320.jvPuKC4bBK@vapier>
In-Reply-To: <7096320.jvPuKC4bBK@vapier>
Subject: Re: [LTP] [PATCH V3 3/4] testscripts/isofs.sh: removed some
 "unnecessary" steps
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
To: Mike Frysinger <vapier@gentoo.org>, ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com



On 06/16/2014 10:23 AM, Mike Frysinger wrote:
> On Thu 27 Mar 2014 18:22:54 Stanislav Kholmanskikh wrote:
>> +		while /bin/true; do
>
> do not hard code paths to tools.  if you want a dummy loop, do:
> 	while :; do
> 		...
> -mike
>
Thank you.

I think I would change this at the commit time rather than to send the 
entire set again.

Ok?

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
