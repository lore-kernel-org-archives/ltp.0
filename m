Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <naresh.kamboju@linaro.org>) id 1WXkLT-0001ck-6g
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 04:42:43 +0000
Received: from mail-yh0-f50.google.com ([209.85.213.50])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WXkLS-00050m-74
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 04:42:43 +0000
Received: by mail-yh0-f50.google.com with SMTP id c41so1898234yho.9
	for <ltp-list@lists.sourceforge.net>;
	Tue, 08 Apr 2014 21:42:36 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 9 Apr 2014 10:12:36 +0530
Message-ID: <CA+G9fYuQi1+C0Mkhc0SVLKm8E9iEEF8rZ_62qAFZZcUaD9CLQQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [LTP] [Ltp-coverage] running LCOV/LTP on Beagle Bone Black -
 Cannot Allocate Memory Error
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
To: shinto.john@smartplayin.com, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, ltp-coverage <ltp-coverage@lists.sourceforge.net>

hi Shinto,

> Hi Peter,
>
> Thanks for identifying the issue.
> I checked my kernel source code and there is only gcc_3_4.c present in kernel/gcov folder and gcc_4_7.c is NOT present. So as you suggested i will have to upgrade to higher version.
>
> I will check with the latest kernel with GCOV 4.7 on beagle bone black and let you know the result.
>
> currently i use below steps for downloading the kernel source for beagle bone black.
>
> git clone git://github.com/RobertCNelson/linux-dev.git
> cd linux-dev/
> Checkout v3.8.x branch (full cape support):
>
> ~/linux-dev
> git checkout origin/am33x-v3.8 -b tmp

You may use latest linaro arm tool chain.
http://releases.linaro.org/14.03/components/toolchain/binaries/gcc-linaro-arm-linux-gnueabihf-4.8-2014.03_linux.tar.bz2

> ~/linux-dev
> ./build_kernel.sh
> Regards,
> Shinto

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
