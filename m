Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PG8lF-0005WN-RK
	for ltp-list@lists.sourceforge.net; Wed, 10 Nov 2010 11:22:41 +0000
Date: Wed, 10 Nov 2010 12:33:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101110113349.GA26340@saboteur.suse.cz>
References: <AANLkTin+-8g9XECkPeCehfo154VWu-VkfYG69oanANY0@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTin+-8g9XECkPeCehfo154VWu-VkfYG69oanANY0@mail.gmail.com>
Subject: Re: [LTP] [RFC] Move testcases/mce-test to testcases/kernel/mce-test
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
>     According to the README...
> 
> The MCE test suite is a collection of tools and test scripts for
> testing the Linux kernel MCE processing features. The goal is to cover
> most Linux kernel MCE processing code paths and features with
> automation tests.
> 
>     Logically it seems like this component should be under
> testcases/kernel instead of testcases.

Yes it's kernel test which tests that kernel responses to MCE by
injecting MCE errors. So I vote for moving this to testcases/kernel/.

And while we are touching it, there is a more recent version on
kernel.org, so if mce-test should stay in LTP we may consider some
policy for updating it regulary otherwise it would just bitrot slowly.

http://git.kernel.org/?p=utils/cpu/mce/mce-test.git;a=summary

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
