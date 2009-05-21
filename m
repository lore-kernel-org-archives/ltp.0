Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1M72qF-0001pz-Jw
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2009 07:37:27 +0000
Received: from smtp109.biz.mail.mud.yahoo.com ([68.142.201.178])
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1M72q6-0007KH-IE
	for ltp-list@lists.sourceforge.net; Thu, 21 May 2009 07:37:27 +0000
Date: Thu, 21 May 2009 15:37:54 +0800 (CST)
Message-Id: <20090521.153754.179938255.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
In-Reply-To: <23553926.post@talk.nabble.com>
References: <d51f89b0904070228q4d4333c7vdd2dfc1e1f7ca8a@mail.gmail.com>
	<23553926.post@talk.nabble.com>
Mime-Version: 1.0
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
To: rohit.170309@gmail.com
Cc: ltp-list@lists.sourceforge.net

From: rohitv <rohit.170309@gmail.com>
Subject: Re: [LTP] HTML report generation issue.
Date: Thu, 14 May 2009 23:04:13 -0700 (PDT)

> 
> Hi,
> 
> Regarding the output coming out of place, can we use the output buffered
> mode as the default? Output buffered mode can be set with the -O option.
> But, this works only when no. of instances of LTP is more than 1 (specified
> by -x option). Currently, for few of the testcases the output generated does
> not appear between <<<test_output>>> and <<<execution_status>>>, it can be
> seen anywhere before <<<test_output>>> when corresponding .output file is
> checked. This might be because of race condition in the pan driver.  I think
> by using the buffered output mode this problem can be fixed. 
> 

Are you saying that when we use pan without -x option, it will not use
buffered mode even if specifying -O option? What I am interested to know
is that if there is any side-effect for single pan instance by using -O
as default.

CAI Qian

> Regards.
> -- 
> View this message in context: http://www.nabble.com/HTML-report-generation-issue.-tp22925527p23553926.html
> Sent from the ltp-list mailing list archive at Nabble.com.
> 
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables 
> unlimited royalty-free distribution of the report engine 
> for externally facing server and web deployment. 
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
