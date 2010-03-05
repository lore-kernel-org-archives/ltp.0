Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NnWKQ-0008M8-HU
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 12:08:26 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NnWKO-0006wN-5C
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 12:08:26 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o25C0MuX031487
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Mar 2010 07:00:22 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o25C8Heq1269868
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Mar 2010 07:08:17 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o25C8HWU010522
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Mar 2010 09:08:17 -0300
Date: Fri, 5 Mar 2010 17:38:10 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100305120810.GA12770@linux.vnet.ibm.com>
References: <89D32649C0790143AB985A5BF77A104F02F4E803@etsmsg-hkexm05.etsmsg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <89D32649C0790143AB985A5BF77A104F02F4E803@etsmsg-hkexm05.etsmsg.org>
Subject: Re: [LTP] clock_getres01 test fails
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
To: Kiran.Girmaji@Emerson.com
Cc: ltp-list@lists.sourceforge.net

Hi Kiran,

can you please let us know few things:

    - How did you installed ltp ?
    - What OS you have ?
    - What is the automake & autoconf version ?
    - Can you try latest git tree and let us know if prob still
persists.


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
