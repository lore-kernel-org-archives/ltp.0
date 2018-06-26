From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jun 2018 13:35:47 +0200
Subject: [LTP] [PATCH] syscalls/shmctl05: new test for IPC file
 use-after-free bug
In-Reply-To: <20180518132536.GB32299@rei>
References: <20180513012325.877-1-ebiggers3@gmail.com>
 <20180518132536.GB32299@rei>
Message-ID: <20180626113547.GG24288@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Have you considered using the fuzzy sync library here?
> 
> https://github.com/linux-test-project/ltp/blob/master/include/tst_fuzzy_sync.h

I've tried to rewrite the test so that it uses the fuzzy sync library to
synchronize the remap_file_page syscall againts the IPC_RMID but for
some reason that does not seem to trigger the issues for me, while the
original reproducer triggers it just fine. There must be some subtle
difference, maybe we need to train branch predictor with the loop that
calls the remap_file_pages, maybe it's something else.

So I guess that the best solution would be merging the testcase as it
is, however for me the test timeouts on broken kernel as the test
process just hangs there which produces misleading test error message.
Maybe we just need to add .timeout_is_failure flag to the test structure
for these kind of testcases so that the test library will hint the
tester that this timeout likely means that the kernel bug has been
reproduced.

-- 
Cyril Hrubis
chrubis@suse.cz
