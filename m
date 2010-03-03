Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nmh3F-0004Jm-WE
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 05:23:18 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nmh3E-000387-Mo
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 05:23:17 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o234vpDZ032074
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 23:57:51 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2355feX113388
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 00:05:41 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2355eq5013304
	for <ltp-list@lists.sourceforge.net>; Wed, 3 Mar 2010 00:05:41 -0500
Date: Wed, 3 Mar 2010 10:35:39 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100303050539.GA18982@linux.vnet.ibm.com>
References: <9debc4411003021317p4b7a2872lb200d17726df24c4@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9debc4411003021317p4b7a2872lb200d17726df24c4@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Makefile fix for 'createfile.c' build in
 network/tcp_cmds/echo
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
To: Maxin John <maxin.john@gmail.com>
Cc: ltp-list@lists.sourceforge.net


Hi Maxim,

>I have observed that the 'createfile.c' in
>testcases/network/tcp_cmds/echo directory is not getting compiled and
>installed during the LTP build. The "echo_createfile.patch" makes the
>necessary changes in the Makefile.
>
>Signed-off-by: Maxin B. John <maxin.john@gmail.com>

Thanks for patch, applied in next branch of ltp will test and apply in
master & next month release.
http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=commit;h=08c16de673d332bb8ab2827818dbab1468a2eefe

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

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
