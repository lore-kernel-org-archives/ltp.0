Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shubham@linux.vnet.ibm.com>) id 1QYwRV-0001cc-Fg
	for ltp-list@lists.sourceforge.net; Tue, 21 Jun 2011 08:36:17 +0000
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QYwRU-0005zV-0Q
	for ltp-list@lists.sourceforge.net; Tue, 21 Jun 2011 08:36:17 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp08.in.ibm.com (8.14.4/8.13.1) with ESMTP id p5L8N2NG008829
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jun 2011 13:53:02 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5L8a3232547876
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jun 2011 14:06:03 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p5L8a2aZ031287
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jun 2011 18:36:02 +1000
Message-ID: <4E0057F2.4030502@linux.vnet.ibm.com>
Date: Tue, 21 Jun 2011 14:06:02 +0530
From: Shubham Goyal <shubham@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <mailman.181450.1307593246.21896.ltp-list@lists.sourceforge.net>
	<BANLkTikpV2jpTJ8_N3FhV0Y1S5p_8n-fPA@mail.gmail.com>
In-Reply-To: <BANLkTikpV2jpTJ8_N3FhV0Y1S5p_8n-fPA@mail.gmail.com>
Subject: Re: [LTP] Ltp-list Digest, Vol 61, Issue 3
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
To: hake huang <hakehuang@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Hake,

We are not tagging GIT currently for stable releases. But its a good 
idea to add tags for stable releases as some of the folks have suggested 
previously. I will definitely add a tag in next release. Below is the 
last commit taken for May release. You can use this for rebasing.

commit 7bc2bbcbf6d8fc329506dc3fcded152c7659dab9
Author: Caspar Zhang <czhang@redhat.com>
Date:   Mon May 30 22:46:56 2011 +0800

Thanks,
Shubham

> Hi,
>
> I am rebasing my local git repository with ltp May release from
> git://ltp.git.sourceforge.net/gitroot/ltp/ltp, but I see no tag for
> May release. which commit is the last one for May release?
>
> Regards,
>
> Hake


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
