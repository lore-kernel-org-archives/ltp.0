From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Aug 2016 14:15:52 +0200
Subject: [LTP] [PATCH] mkswap: make the test device size is aligned to
 pagesize
In-Reply-To: <20160816032416.GA28657@gmail.com>
References: <1469613519-27167-1-git-send-email-liwang@redhat.com>
 <20160809164118.GA27028@rei.lan> <20160815092508.GB22440@gmail.com>
 <20160815123959.GD20680@rei.lan> <20160816032416.GA28657@gmail.com>
Message-ID: <20160816121552.GC25092@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Sorry for the vague description. To be honest, mkswap.c(util-linux) is innocent
> here. The error maker is mkswap_verify() in mkswap01.sh(ltp) testcase.
> 
> The key point of problem is not only mkswap01.sh (ltp) doesn't guarantee
> test-device(LTP_DEV) size is aligned to PAGE_SIZE on all arches, but also
> it increse/decrease test-device size not aligned too.
> 
> # tail -15 mkswap01.sh
> mkswap_test "" "" "$TST_DEVICE"
> mkswap_test "" "" "$TST_DEVICE" "$((DEVICE_SIZE-10000))"     <---
> mkswap_test "-f" "" "$TST_DEVICE" "$((DEVICE_SIZE+10000))"   <---
> ...
> 
> 
> As we know that mkswap.c(util-linux) format test-device to aligned with its local
> PAGE_SIZE by force. Therefore, the real 'filesize' of formated test-device will
> be decreased in that phase. But final, the testcase just compare orignal 'filesize'
> to 'diff'(swaptotal-after - swaptotal-before) and make conclusion to get PASS/FAIL.
> That makes this test result is not reliable.

Now that makes sense.

But if that is the case we still have to align down the device size to
the page size at the start of the test. Since the device can also be
passed down to the runltp script as a parameter and we cannot make any
assumptions about its size.

-- 
Cyril Hrubis
chrubis@suse.cz
