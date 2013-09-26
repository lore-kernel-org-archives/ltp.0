Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VP9o5-0001rP-Cq
	for ltp-list@lists.sourceforge.net; Thu, 26 Sep 2013 11:32:29 +0000
Date: Thu, 26 Sep 2013 13:32:49 +0200
From: chrubis@suse.cz
Message-ID: <20130926113249.GC14003@rei.suse.cz>
References: <CAK67bL80qDJnZqSw7J5rG3gV8+NuVHfp7uPsmAqVFVo5n4waEA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK67bL80qDJnZqSw7J5rG3gV8+NuVHfp7uPsmAqVFVo5n4waEA@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Unzip command validation irrespective of verbose
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
To: siva sankar padhy <padhy.sivasankar@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I have faced a problem while running LTP on my ARM board. The below command
> is failing.
> unzip01 unzip_tests.sh $LTPROOT/testcases/data/tst_unzip_file.zip
> As i observed the "unzip" binary on my board uses a string "inflating" to
> show the verbose message for compression of files.
> The test case is is expecting "unzip" binary to use a string "extracting"
> to show the verbose message for compression of files.
> In unzip_tests.sh the code has been written to compare the verbose message
> to PASS/FAIL the test case.
> hence it is PASS in my x86 but FAIL in my ARM board.
> 
> *So i have added this patch which will compare the directory tree output
> structure not the verbose message.*
> 
> Please find the patch below and please revert for any suggestion and
> concerns.
> This is my first patch. So please regret for any wrong formatting of make
> the patch review. :)
> 
> *I will eagerly wait for your valuable reply ASAP.*

The patch has been corrupted by your mail client (the long lines were
wrapped). Can you please resend correctly?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
