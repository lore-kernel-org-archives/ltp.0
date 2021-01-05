From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Jan 2021 14:38:10 +0100
Subject: [LTP] [RFC PATCH 2/2] include/tst_test_macros.h: Report TINFO
 when TST_EXP_FD() succeeded
In-Reply-To: <5FF312F7.1060907@cn.fujitsu.com>
References: <20210104125423.19183-1-yangx.jy@cn.fujitsu.com>
 <20210104125423.19183-2-yangx.jy@cn.fujitsu.com>
 <5FF312F7.1060907@cn.fujitsu.com>
Message-ID: <X/RrwqbiLMllZhAF@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I will change the TST_EXP_PASS as well if you approve the patch.

Please do not. The very purpose of TST_EXP_PASS() is to produce
TFAIL or TPASS.

-- 
Cyril Hrubis
chrubis@suse.cz
