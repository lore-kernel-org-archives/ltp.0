Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NSMUN-0003Rk-NO
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 03:23:15 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSMUM-0008V8-Pj
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 03:23:15 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o063LcwI015920
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 20:21:38 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o063MtsK097946
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 20:22:55 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o063Ot0I015382
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 20:24:55 -0700
Date: Tue, 5 Jan 2010 21:22:53 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100106032253.GA8157@us.ibm.com>
References: <20100104171643.GA545@us.ibm.com>
	<D107C512-245B-4187-9A8D-7FDC28234A0D@gmail.com>
	<20100104233622.GA9018@us.ibm.com>
	<AA968A69-C9C7-4FC1-B4B5-849719CCB8E8@gmail.com>
	<20100105153021.GA11873@us.ibm.com>
	<948507EC-6E01-4C79-A497-0425B44863CA@gmail.com>
	<20100105173325.GA5204@us.ibm.com>
	<0921C697-823F-42DE-98CB-D99C9903323A@gmail.com>
	<364299f41001051853n3d95e1b8hd2cdabca77ad59ef@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41001051853n3d95e1b8hd2cdabca77ad59ef@mail.gmail.com>
Subject: Re: [LTP] [PATCH 1/1] say FAIL not PASS when we failed
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Quoting Garrett Cooper (yanegomi@gmail.com):
> Ok, so before I commit I just want to make sure that this makes sense with you:
> 
> The differences are:
> 1. The id -?r?u use.

Either one can be fooled, neither should be...

> 2. The while [ ! ... -a ... ] vs until [ ... -o ... ] logic (is more
> clear in my mind because it better describes the desired end-state)
> 3. Removing the which calls (because which doesn't exist on busybox
> from what I've heard) and replacing them with non-absolute commands
> (because it's the same thing...).

All look fine to me.

thanks,
-serge

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
