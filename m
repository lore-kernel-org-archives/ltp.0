Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1WEFId-0000zB-5o
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 09:43:11 +0000
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WEFIb-0001Ps-44
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 09:43:11 +0000
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <oberpar@linux.vnet.ibm.com>; 
	Fri, 14 Feb 2014 09:43:02 -0000
Message-ID: <52FDE52A.4070002@linux.vnet.ibm.com>
Date: Fri, 14 Feb 2014 10:43:06 +0100
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <CA+G9fYuT4TSs=3j6K9zztsTgFNVp2YG6JT-2Q_L==1P5G+SBew@mail.gmail.com>
In-Reply-To: <CA+G9fYuT4TSs=3j6K9zztsTgFNVp2YG6JT-2Q_L==1P5G+SBew@mail.gmail.com>
Subject: Re: [LTP] How to get the Linux kernel coverage data on ARM arch
 when I run LTP test?
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
To: Naresh Kamboju <naresh.kamboju@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, fhrbata@redhat.com, Paul Larson <paul.larson@canonical.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, ltp-coverage <ltp-coverage@lists.sourceforge.net>, Mark Brown <mark.brown@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deepak Saxena <dsaxena@linaro.org>, Milosz Wasilewski <milosz.wasilewski@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 14.02.2014 10:02, Naresh Kamboju wrote:
> root@linaro-developer:/tmp/linux-linaro-3.13-2014.01# gcov kernel/gcov/base.c -o
>  /sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/kernel/gcov/
> File 'kernel/gcov/base.c'
> Lines executed:43.18% of 44
> Creating 'base.c.gcov'
> 
> root@linaro-developer:/tmp/linux-linaro-3.13-2014.01#
> 
> The above experiment gives coverage of a single file base.c when i run
> gcov manually.
> Is there any way to get Linux kernel coverage of all files after
> running LTP test cases ?

1. Reset coverage data: lcov -z
2. Run LTP (or any other test case)
3. Capture coverage data: lcov -c -o coverage.info
4. Generate HTML output: genhtml coverage.info -o out
5. View HTML output: <browser> out/index.html

More information on lcov can be found on the page behind the second URL
your quoted in your mail.


Regards,
  Peter Oberparleiter

-- 
Peter Oberparleiter
Linux on System z Development - IBM Germany


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
