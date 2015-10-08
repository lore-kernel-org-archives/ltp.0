From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Oct 2015 16:23:04 +0200
Subject: [LTP] [PATCH v3] sched_getattr/sched_getattr01: Add new
 testcase to test sched_getattr
In-Reply-To: <561628F7.3010902@huawei.com>
References: <20150929163350.GB32435@rei.suse.cz> <561628F7.3010902@huawei.com>
Message-ID: <20151008142303.GA10976@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with following changes:

* TCID changed to match the file name

* Added tst_parse_opts() and TEST_LOOPING()
  (Somehow I've missed that it's missing in the review)

* Added tst_require_root() since the test needs root to change
  scheduller attributes

* Removed newlines from the tst_resm()/tst_brkm() strings

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
