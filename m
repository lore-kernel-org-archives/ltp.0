Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NsGtb-0000du-BU
	for ltp-list@lists.sourceforge.net; Thu, 18 Mar 2010 14:40:23 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NsGtY-0001Lg-Nw
	for ltp-list@lists.sourceforge.net; Thu, 18 Mar 2010 14:40:21 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2IEWJXr014782
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Mar 2010 08:32:19 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2IEdv2P105820
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Mar 2010 08:39:59 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2IEdsGj022342
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Mar 2010 08:39:54 -0600
Date: Thu, 18 Mar 2010 09:39:53 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100318143953.GA6287@us.ibm.com>
References: <E0B6230F32558E43951AF1B0DEBF98102119CEC9EF@EUSAACMS0714.eamcs.ericsson.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E0B6230F32558E43951AF1B0DEBF98102119CEC9EF@EUSAACMS0714.eamcs.ericsson.se>
Subject: Re: [LTP] FW: LTP check_mqns_enable.c missing mqueue.h file
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
To: Anthony Ton <anthony.ton@ericsson.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Quoting Anthony Ton (anthony.ton@ericsson.com):
> Hi,
> 
> I am using the latest version of LTP ltp-full-20100228.  During make all, the compile check_mqns_enable.c complains "mqueue.h: No such file or directory."  Could you please tell me how to fix this?
> I am greatly appreciate your help.

# rpm -q --whatprovides /usr/include/mqueue.h
glibc-devel-2.9-13.3.1

-serge

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
