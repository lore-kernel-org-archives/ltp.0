Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YkvGT-0003nQ-7H
	for ltp-list@lists.sourceforge.net; Wed, 22 Apr 2015 14:04:33 +0000
Date: Wed, 22 Apr 2015 16:04:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150422140404.GA32660@rei>
References: <1427771764-22918-1-git-send-email-cuibixuan@huawei.com>
	<20150401143314.GA23093@rei> <551CB5CD.5030903@huawei.com>
	<20150402083344.GA27984@rei> <552D1041.9010103@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <552D1041.9010103@huawei.com>
Subject: Re: [LTP] [PATCH v4 1/2] syscalls/utimensat01: Use test.sh library
 for test case
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: zhuyanpeng@huawei.com, ltp-list@lists.sourceforge.net, zhanyongming@huawei.com

>  echo "Total tests: $test_num; passed: $passed_cnt; failed: $failed_cnt"
>  if test $failed_cnt -gt 0; then
>      echo "Failed tests: $failed_list"
> -    exit -1
> +    tst_resm TFAIL "test failed"
>  fi
> 
> -exit
> +tst_resm TPASS "test pass"

The tst_resm TPASS should be in the else part of the if above, otherwise
the test will print both failure and success in case that failed_cnt is
greater than zero.

And changing the check_result() to call tst_resm TFAIL/TPASS directly
would be even better. In that case this part will call only tst_exit as
the pass/fail status will be saved by the test library.

> +tst_exit
> -- 1.6.0.2

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
