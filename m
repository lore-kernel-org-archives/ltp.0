Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glt-ltp-list@m.gmane.org>) id 1Tvoq0-0006FX-SK
	for ltp-list@lists.sourceforge.net; Thu, 17 Jan 2013 12:44:56 +0000
Received: from plane.gmane.org ([80.91.229.3])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Tvopz-0001V3-Te
	for ltp-list@lists.sourceforge.net; Thu, 17 Jan 2013 12:44:56 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glt-ltp-list@m.gmane.org>) id 1Tvoq8-0002gN-59
	for ltp-list@lists.sourceforge.net; Thu, 17 Jan 2013 13:45:04 +0100
Received: from 122.248.161.59 ([122.248.161.59])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Jan 2013 13:45:04 +0100
Received: from sravan by 122.248.161.59 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Jan 2013 13:45:04 +0100
From: Sravan V Dodla <sravan@linux.vnet.ibm.com>
Date: Thu, 17 Jan 2013 12:37:06 +0000 (UTC)
Message-ID: <loom.20130117T133157-543@post.gmane.org>
References: <1329795813-12550-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<4F4313F6.9020408@cn.fujitsu.com>
Mime-Version: 1.0
Subject: Re: [LTP]
	=?utf-8?q?=5BPATCH=5D_mem/tunable=3A_fix_the_overcommitting?=
	=?utf-8?q?_possible=09failure?=
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
To: ltp-list@lists.sourceforge.net

Wanlong Gao <gaowanlong@...> writes:

> 
> On 02/21/2012 11:43 AM, Wanlong Gao wrote:
> 
> > 1. CommitLimit may be changed when set another overcommit_memory
> >    value.
> > 2. Test overcommit_memory=2 first to avoid the condition
> >    committed > CommitLimited.
> 
> Below is my failure before this patch.

Some how even after the patch I still hit this issue.
Wanlong, is it good to skip this case of test when CommitLimit < Committed_AS.
Please comment.

./overcommit_memory -R 0
overcommit_memory    0  TINFO  :  set overcommit_ratio to 0
overcommit_memory    0  TINFO  :  MemTotal is 1020764 kB
overcommit_memory    0  TINFO  :  SwapTotal is 0 kB
overcommit_memory    0  TINFO  :  CommitLimit is 0 kB
overcommit_memory    0  TINFO  :  set overcommit_memory to 2
overcommit_memory    0  TINFO  :  CommmitLimit is 0, Committed_AS is 241680
overcommit_memory    1  TBROK  :  Unexpected error: CommitLimit < Committed_AS
overcommit_memory    2  TBROK  :  Remaining cases broken
overcommit_memory    0  TINFO  :  set overcommit_memory to 0
overcommit_memory    0  TINFO  :  set overcommit_ratio to 50

> ---
> # ./overcommit_memory -R 0 ; cat /proc/meminfo 
> overcommit_memory    0  TINFO  :  set overcommit_ratio to 0
> overcommit_memory    0  TINFO  :  MemTotal is 5780068 kB
> overcommit_memory    0  TINFO  :  SwapTotal is 4095996 kB
> overcommit_memory    0  TINFO  :  CommitLimit is 4095996 kB
> overcommit_memory    0  TINFO  :  set overcommit_memory to 0
> overcommit_memory    0  TINFO  :  malloc 2127578 kB successfully
> overcommit_memory    1  TPASS  :  alloc passed as expected
> overcommit_memory    0  TINFO  :  malloc 8510312 kB failed
> overcommit_memory    2  TPASS  :  alloc failed as expected
> overcommit_memory    0  TINFO  :  malloc 9876064 kB failed
> overcommit_memory    3  TPASS  :  alloc failed as expected
> overcommit_memory    0  TINFO  :  set overcommit_memory to 2
> overcommit_memory    0  TINFO  :  CommmitLimit is 4095996, Committed_AS is 
4096060
> overcommit_memory    4  TBROK  :  Unexpected error: CommitLimit < Committed_AS
> overcommit_memory    5  TBROK  :  Remaining cases broken
> overcommit_memory    0  TINFO  :  set overcommit_memory to 0
> overcommit_memory    0  TINFO  :  set overcommit_ratio to 50




------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
