Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <naresh.kamboju@linaro.org>) id 1WFlgr-0004za-3R
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 14:30:29 +0000
Received: from mail-yh0-f54.google.com ([209.85.213.54])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WFlgp-0005vu-Pt
	for ltp-list@lists.sourceforge.net; Tue, 18 Feb 2014 14:30:29 +0000
Received: by mail-yh0-f54.google.com with SMTP id z6so15363278yhz.41
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Feb 2014 06:30:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52FDE52A.4070002@linux.vnet.ibm.com>
References: <CA+G9fYuT4TSs=3j6K9zztsTgFNVp2YG6JT-2Q_L==1P5G+SBew@mail.gmail.com>
	<52FDE52A.4070002@linux.vnet.ibm.com>
Date: Tue, 18 Feb 2014 20:00:21 +0530
Message-ID: <CA+G9fYv9+Fhyz=nVZQZXxLU0YMTJadfr1XVVVb9P=inEfUaDuA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
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
To: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Milosz Wasilewski <milosz.wasilewski@linaro.org>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, ltp-coverage <ltp-coverage@lists.sourceforge.net>, fhrbata@redhat.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deepak Saxena <dsaxena@linaro.org>, Mark Brown <mark.brown@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 14 February 2014 15:13, Peter Oberparleiter
<oberpar@linux.vnet.ibm.com> wrote:
> On 14.02.2014 10:02, Naresh Kamboju wrote:
>> root@linaro-developer:/tmp/linux-linaro-3.13-2014.01# gcov kernel/gcov/base.c -o
>>  /sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/kernel/gcov/
>> File 'kernel/gcov/base.c'
>> Lines executed:43.18% of 44
>> Creating 'base.c.gcov'
>>
>> root@linaro-developer:/tmp/linux-linaro-3.13-2014.01#
>>
>> The above experiment gives coverage of a single file base.c when i run
>> gcov manually.
>> Is there any way to get Linux kernel coverage of all files after
>> running LTP test cases ?
>
> 1. Reset coverage data: lcov -z
> 2. Run LTP (or any other test case)
> 3. Capture coverage data: lcov -c -o coverage.info
> 4. Generate HTML output: genhtml coverage.info -o out
> 5. View HTML output: <browser> out/index.html

It is working !!!
LTP executed on linux-linaro build on vexpress-tc2 target.
Please find results obtained
http://people.linaro.org/~naresh.kamboju/linux-linaro-coverage-by-ltp/

The plan is to run all linaro test suite and to get coverage date.

Peter Oberparleiter,
Thank you very much for your help.

Best regards
Naresh Kamboju

>
> More information on lcov can be found on the page behind the second URL
> your quoted in your mail.
>
>
> Regards,
>   Peter Oberparleiter
>
> --
> Peter Oberparleiter
> Linux on System z Development - IBM Germany
>

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
