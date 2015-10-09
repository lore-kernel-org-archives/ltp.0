From: Cui Bixuan <cuibixuan@huawei.com>
Date: Fri, 9 Oct 2015 08:28:11 +0800
Subject: [LTP] [PATCH v3] sched_getattr/sched_getattr01: Add new
 testcase to test sched_getattr
In-Reply-To: <20151008142303.GA10976@rei.suse.cz>
References: <20150929163350.GB32435@rei.suse.cz> <561628F7.3010902@huawei.com>
 <20151008142303.GA10976@rei.suse.cz>
Message-ID: <56170A1B.2090104@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2015/10/8 22:23, Cyril Hrubis wrote:
> Hi!
> Pushed with following changes:
> 
> * TCID changed to match the file name
> 
> * Added tst_parse_opts() and TEST_LOOPING()
>   (Somehow I've missed that it's missing in the review)
> 
> * Added tst_require_root() since the test needs root to change
>   scheduller attributes
> 
> * Removed newlines from the tst_resm()/tst_brkm() strings
> 
Thanks.

> Thanks.
> 

