Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bounces@nabble.com>) id 1M4qWp-0007Zz-7c
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 06:04:19 +0000
Received: from kuber.nabble.com ([216.139.236.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M4qWk-0002UW-5M
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2009 06:04:19 +0000
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1M4qWj-0002T0-GJ
	for ltp-list@lists.sourceforge.net; Thu, 14 May 2009 23:04:13 -0700
Message-ID: <23553926.post@talk.nabble.com>
Date: Thu, 14 May 2009 23:04:13 -0700 (PDT)
From: rohitv <rohit.170309@gmail.com>
In-Reply-To: <d51f89b0904070228q4d4333c7vdd2dfc1e1f7ca8a@mail.gmail.com>
MIME-Version: 1.0
References: <d51f89b0904070228q4d4333c7vdd2dfc1e1f7ca8a@mail.gmail.com>
Subject: Re: [LTP] HTML report generation issue.
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


Hi,

Regarding the output coming out of place, can we use the output buffered
mode as the default? Output buffered mode can be set with the -O option.
But, this works only when no. of instances of LTP is more than 1 (specified
by -x option). Currently, for few of the testcases the output generated does
not appear between <<<test_output>>> and <<<execution_status>>>, it can be
seen anywhere before <<<test_output>>> when corresponding .output file is
checked. This might be because of race condition in the pan driver.  I think
by using the buffered output mode this problem can be fixed. 

Regards.
-- 
View this message in context: http://www.nabble.com/HTML-report-generation-issue.-tp22925527p23553926.html
Sent from the ltp-list mailing list archive at Nabble.com.


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
