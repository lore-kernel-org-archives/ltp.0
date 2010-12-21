Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PUxEQ-00068u-TL
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 08:06:02 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PUxEQ-0007Y5-5E
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 08:06:02 +0000
Received: by iyj18 with SMTP id 18so2960797iyj.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Dec 2010 00:05:57 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4D1057E0.4060000@cn.fujitsu.com>
Date: Tue, 21 Dec 2010 00:05:52 -0800
Message-Id: <ABE3F4B7-6A3A-4339-999D-A3D41CC63147@gmail.com>
References: <1920170050.25294.1292915503845.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<4D1057E0.4060000@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH]Fix building error.
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Dec 20, 2010, at 11:31 PM, Bian Naimeng wrote:

> CAI Qian wrote:
>>> Could you tell me which kernels are this test fit to?
>> It is hard to tell. The old kernel might decide to back-port this feature.
> 
> I see.
> 
> Would you like tell me what's the test required? 
> 
> If the test is good, i think it should pass on old kernel which had back-port
> this feature, otherwise the back-port procedure is incorrect.

	Yes, assuming features are tied to specific versions is a bad idea; a lot of code in LTP does this in an effort to be correct as to when it was first implemented, but it's wrong because there are various groups who may have backported support for distro or product specific reasons :)...

>>> If there is old KSM interface, and this test can not work correctly on
>>> it, i think we should fix the test, it should not do anything but reports
>>> "This test is unsupported!"
>> Anyway, it would be more code to test here and there rather than kernel version. Isn't LTP's guideline to only support the latest and greatest kernels?

	I wish. It would make life a lot easier, but that isn't the way that things are today (esp the folks on here that are running ancient versions of Redhat... *cough*)... and given that trying to track Linux changes is like trying to forecast the weather, stuff is always changing -- for better or for worse -- which makes it a pain for everyone else sitting out on the sidelines, like LTP, because Linux kernel devs don't actively engage test projects.
	There isn't really a line drawn in the sand as far as what is and isn't supported by LTP, except between 2.4 and 2.6 kernels, and even that is murky in spots.
Thanks,
-Garrett
------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
