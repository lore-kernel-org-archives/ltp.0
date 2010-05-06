Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O9vvR-0008Fq-KW
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 07:55:17 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O9vvQ-0005Eh-Q2
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 07:55:17 +0000
Received: by pwj5 with SMTP id 5so2409001pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 May 2010 00:55:11 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1078)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4BE26A1A.1000102@in.ibm.com>
Date: Thu, 6 May 2010 00:55:14 -0700
Message-Id: <239C044B-6014-4FA7-AC8B-6D71AFE8FEDA@gmail.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065801.23879.92449.sendpatchset@subratamodak.linux.ibm.com>
	<4BE26A1A.1000102@in.ibm.com>
Subject: Re: [LTP] [08/12 FAILURE] LTPE clock gettime03 fails
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
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, B N Poornima <bnpoorni@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, Sharyathi Nagesh <sharyath@in.ibm.com>

On May 6, 2010, at 12:04 AM, Suzuki Poulose wrote:

> <fix-timer-tests-bad-header.diff>

	Maybe a better solution would be to NULL terminate the array (well, or do similar)? Using two units of measurement just seems like it'd complicate how things are being performed...
Thanks,
-Garrett
------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
