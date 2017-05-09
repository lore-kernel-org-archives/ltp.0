From: Liu, Wenlong <liuwl.fnst@cn.fujitsu.com>
Date: Tue, 9 May 2017 01:27:38 +0000
Subject: [LTP] About the testcase "dma_thread_diotest" of LTP
Message-ID: <F40213214988A94A9DDBFC5F7146FC5E0121D2EC1F@G08CNEXMBPEKD01.g08.fujitsu.local>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Ping, thanks.

> Hello all,
>
> I am doing the LTP test for aarch64 platform.
> But there is something troubled me recently, which is mainly about the dma_thread_diotest.
> Those testcases were failed on the target board(Board: Renesas M3 Starter Kit Pro), which has 2 CPUs.
>
> I have seen the description of this testcase, and someone told me that:
> This test suite was created by this LTP commit:https://github.com/linux-test-project/ltp/commit/52de6e2616951ddafc760138f99a1195295bbfdc. 
> Once there was already a discussion in kernel mm community in 2008, please see this url:http://thread.gmane.org/gmane.linux.file-systems/27358.
> But unfortunately this bug was not fixed and it still exists in the latest upstream kernel. Some engineers from mm community think it's one whose fix would cause more troulbe than it's worth and MADV_DONTFORK is a good enough workaround. I will follow up this discussion to try to reach a conclusion whether it's worth to fix this issue.
>
> But I wonder whether this bug have been fixed and what I can do except‘don't do this test’.
> Looking for your reply at your convenience.
> Thanks in advance.

B.R.
Liu



