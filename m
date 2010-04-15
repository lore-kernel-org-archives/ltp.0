Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O2KK1-0002sJ-Fy
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 08:21:13 +0000
Received: from mail-yx0-f181.google.com ([209.85.210.181])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O2KK0-000559-Ja
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 08:21:13 +0000
Received: by yxe11 with SMTP id 11so630298yxe.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Apr 2010 01:21:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100415065202.GB4557@linux.vnet.ibm.com>
References: <003201cadc47$a9bcec80$fd36c580$@co.jp>
	<20100415065202.GB4557@linux.vnet.ibm.com>
Date: Thu, 15 Apr 2010 01:21:07 -0700
Message-ID: <r2u364299f41004150121u981a4f55mbcb5c3254f1cd8e2@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix \"ar\" test
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
To: Mitani <mitani@ryobi.co.jp>, ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

On Wed, Apr 14, 2010 at 11:52 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Thu, Apr 15, 2010 at 11:59:28AM +0900, Mitani wrote:
>> Sorry.
>> My patch was destroyed by e-mail.
>> I attach patch for "ar01" file.
>
> Applied to next branch. Will wait for someone to Acked/test it before merging to
> master.

I would look through the commit history for this item (if not in git,
definitely in cvs). Memory serves me correctly 2~3 months ago this
script was last touched because of an output format change in ar
(which means that the test needs to be modified to detect this change,
or needs to be made semi-agnostic of the output from ar(1), preferably
the latter but that's more difficult to achieve).
HTH,
-Garrett

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
