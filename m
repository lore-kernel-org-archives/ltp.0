Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1ZZvHp-0006LI-59
	for Ltp-list@lists.sourceforge.net; Thu, 10 Sep 2015 06:24:45 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZZvHn-0006La-ST
	for Ltp-list@lists.sourceforge.net; Thu, 10 Sep 2015 06:24:45 +0000
Message-ID: <1441866309.29760.18.camel@G08FNSTD140232>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 10 Sep 2015 14:25:09 +0800
In-Reply-To: <CAO0kMxDg1KJWzFMqyYOmP5xLe78pyf21MwizsM_P38Vbx02HeQ@mail.gmail.com>
References: <CAO0kMxDg1KJWzFMqyYOmP5xLe78pyf21MwizsM_P38Vbx02HeQ@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] Query related to LTP test suite run
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
To: kamal p <pkamalbhaskar@gmail.com>
Cc: Ltp-list@lists.sourceforge.net, ltp@lists.linux.it

Hello,

CC: ltp@lists.linux.it

On Thu, 2015-09-10 at 10:07 +0530, kamal p wrote:
> Hi,
> 
>   I've query which is based on LTP test-cases running. 
> 
>   these days I've downloaded and installed LTP on my linux host
> machine.
>   while running the test cases using runltp script my system went to
> crash after running few testcases.
> 
>   why I am facing these problem and Please clarify me anyone with
> relevant answer for these same.
> 

As I known, inotify06 would make some system crash caused by a known
kernel bug and the bug has been fixed, you can see this url:
https://github.com/torvalds/linux/commit/8f2f3eb59dff4ec538de55f2e0592fec85966aab

If the issue is inotify06, I suggest that you should remove it before
using runltp script.
You can just do like:
rm -rf <path_to_install_ltp>/testcases/bin/inotify06

Thanks,
Zeng

> Regards &Thanks,
> 
> Kamal
> 
> ------------------------------------------------------------------------------
> Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
> Get real-time metrics from all of your servers, apps and tools
> in one place.
> SourceForge users - Click here to start your Free Trial of Datadog now!
> http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
