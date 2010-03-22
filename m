Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NtbKx-0001AZ-Hc
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 06:42:07 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NtbKv-0000PE-Aj
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 06:42:07 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2M6V5ZJ003024
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Mar 2010 02:31:05 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2M6fxva166642
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Mar 2010 02:41:59 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2M6fxjt023717
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Mar 2010 02:41:59 -0400
Date: Mon, 22 Mar 2010 12:11:57 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100322064157.GB20606@linux.vnet.ibm.com>
References: <E0B6230F32558E43951AF1B0DEBF98102119D20EDD@EUSAACMS0714.eamcs.ericsson.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E0B6230F32558E43951AF1B0DEBF98102119D20EDD@EUSAACMS0714.eamcs.ericsson.se>
Subject: Re: [LTP] tcore.exp
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

>It appears that the proc check_fpu in tcore.exp has an error when the expect
>can't \
>find the expected string "xmm$num ...".  In the timeout block, the code read
>
>fail "fail to check the xmm value(timeout)"
>
>In my humble opinion, it should be
>
>send_user "fail to check the xmm value(timeout)"

Hi Anthony,

Send us a patch with the correct changes and then someone can review here.

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
