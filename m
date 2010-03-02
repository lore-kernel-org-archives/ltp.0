Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NmTvH-0000oj-U1
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 15:22:11 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NmTvH-0000I1-28
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 15:22:11 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o22FDLHR026325
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 08:13:21 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o22FLoUN118352
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 08:21:52 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o228LbU7022177
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 01:21:37 -0700
Date: Tue, 2 Mar 2010 09:21:35 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100302152135.GA6691@us.ibm.com>
References: <OF3DD1AE6A.65D45C56-ON652576DA.002F585D-652576DA.00384F54@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OF3DD1AE6A.65D45C56-ON652576DA.002F585D-652576DA.00384F54@in.ibm.com>
Subject: Re: [LTP] LTP's filecaps test gives false positive results
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
To: Iranna D Ankad <iranna.ankad@in.ibm.com>
Cc: Rishikesh K Rajak <risrajak@in.ibm.com>, ltp-list@lists.sourceforge.net

Quoting Iranna D Ankad (iranna.ankad@in.ibm.com):
> LTP reports setcap is installed, but actually, my system has setcap 
> installed, along with all required libcap related rpms.
> 
> mx3950:/opt/ltp # setc
> setcap      setconsole  setctsid 
> mx3950:/opt/ltp #
> 
> mx3950:/opt/ltp # rpm -qa | grep cap
> libcap1-1.10-6.10
> libcap2-2.11-2.15
> libcap-progs-2.11-2.15
> libpcap0-0.9.8-50.4.32
> libcap2-32bit-2.11-2.15
> libcap1-32bit-1.10-6.10
> mx3950:/opt/ltp # 

THere are a bunch of #if directives in there (only looked at
check_simple_capset.c which I assume is where your trouble is) which
are not defined on my fedora 10 test system.  Don't know where they
came from - they predate the git history.

HAVE_SYS_CAPABILITY_H, HAVE_DECL_CAP_FROM_TEXT, etc.

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
