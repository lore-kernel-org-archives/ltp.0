Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maxin.john@gmail.com>) id 1NnAkT-0003ww-S8
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 13:05:53 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NnAkS-0006gZ-Vr
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 13:05:53 +0000
Received: by pwi5 with SMTP id 5so1458606pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 04 Mar 2010 05:05:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B8F5FB8.103@calsoftinc.com>
References: <4B8E3B7F.8050301@calsoftinc.com>
	<20100303124352.GD23601@linux.vnet.ibm.com>
	<4B8E5DF3.7090502@calsoftinc.com>
	<9debc4411003030900t971da33pfbe9ea4e994d74d4@mail.gmail.com>
	<BD77C355-AF47-4A92-8231-145DDBC8F54D@gmail.com>
	<20100304064544.GA11885@linux.vnet.ibm.com>
	<364299f41003032250i78c201fesc5ce55d6d2c2794f@mail.gmail.com>
	<4B8F5FB8.103@calsoftinc.com>
Date: Thu, 4 Mar 2010 18:35:46 +0530
Message-ID: <9debc4411003040505y39cd5324o598871cae7cc8841@mail.gmail.com>
From: Maxin John <maxin.john@gmail.com>
Subject: Re: [LTP] Missing test tools in recent ltp builds
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
To: Shwetabh <shwetabh.goel@calsoftinc.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi Shwetabh,

> There is one possible problem with the current solution provided by Maxin.
> The patch takes care
> only of cpuhotplug tests. However, judging by the number of files that are
> missing in /opt/ltp/testcases,
> it is quite possible that many other tests might have been broken. So,
> perhaps a generic solution to this
> problem would be to modify the Makefile to ensure that it copies all
> directories from ltp-full-20100228/testcases/
> to /opt/ltp/testcases/.

Yes, I do agree with you. This patch is intented only for the cpuhotplug tests.

Another solution (old school method) will be to have a look into the
LTP's "TODO" file :)
In that file, we can locate a number of "items missing from LTP
install based on the output log provided by runltp[lite.sh]".  Please
have a look into the "testscripts/ltp-missing-install-files.py" script
for the logic behind it.

Best Regards,
Maxin B. John

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
