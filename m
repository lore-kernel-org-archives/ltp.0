Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vqzmt-0005ke-Rc
	for ltp-list@lists.sourceforge.net; Thu, 12 Dec 2013 06:30:19 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vqzmr-0005sS-8n
	for ltp-list@lists.sourceforge.net; Thu, 12 Dec 2013 06:30:19 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBC6UAcB012756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Dec 2013 06:30:11 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBC6U9IF010572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Dec 2013 06:30:10 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBC6U99b000694
	for <ltp-list@lists.sourceforge.net>; Thu, 12 Dec 2013 06:30:09 GMT
Message-ID: <52A957EF.7040003@oracle.com>
Date: Thu, 12 Dec 2013 10:30:07 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <20131211151928.GA30754@rei.Home>
In-Reply-To: <20131211151928.GA30754@rei.Home>
Subject: Re: [LTP] [RFC] LTP Test Writing Guidelines
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



On 12/11/2013 07:19 PM, chrubis@suse.cz wrote:
> Good news everyone!
>
> As number of contributors grows I've finally started to address our lack
> of documentation. I've written down a short introduction on how to write
> a LTP test. It's intended to cover just enough so that you can write a
> reasonable LTP testcase without any prior knowledge as well as to codify
> some of the rules we formed but were not written down till now.
>
> The text is attached as an asciidoc formatted plaintext and can be
> viewed in html form at [1].
>
> The attached text is a draft and it's likely that there are mistakes or
> important things missing. For example, as far as I know, we do not have
> a uniform coding style for shell scripts nor clear documentation for the
> shell LTP library functions, this should be ideally addressed as well.
>
> As usuall comments and patches are welcome ;).

Fantastic work! :)

Thank you.

Maybe add here a notice about performing a cleanup (in a separate patch) 
before doing any "serious" modifications of the old test cases?

Since there are many such "old-style" test cases in LTP, these 
situations may happen regularly.

>
> [1] http://metan.ucw.cz/outgoing/LTP_Test_Writing_Guidelines.html
>
>
>
> ------------------------------------------------------------------------------
> Rapidly troubleshoot problems before they affect your business. Most IT
> organizations don't have a clear picture of how application performance
> affects their revenue. With AppDynamics, you get 100% visibility into your
> Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
> http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
>
>
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
