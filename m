From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Nov 2017 15:38:11 +0100
Subject: [LTP] About the testcase "dma_thread_diotest" of LTP
In-Reply-To: <F40213214988A94A9DDBFC5F7146FC5E0121D2EC1F@G08CNEXMBPEKD01.g08.fujitsu.local>
References: <F40213214988A94A9DDBFC5F7146FC5E0121D2EC1F@G08CNEXMBPEKD01.g08.fujitsu.local>
Message-ID: <20171101143811.GC11108@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I have seen the description of this testcase, and someone told me that:
> > This test suite was created by this LTP commit:https://github.com/linux-test-project/ltp/commit/52de6e2616951ddafc760138f99a1195295bbfdc. 
> > Once there was already a discussion in kernel mm community in 2008, please see this url:http://thread.gmane.org/gmane.linux.file-systems/27358.
> > But unfortunately this bug was not fixed and it still exists in the latest upstream kernel. Some engineers from mm community think it's one whose fix would cause more troulbe than it's worth and MADV_DONTFORK is a good enough workaround. I will follow up this discussion to try to reach a conclusion whether it's worth to fix this issue.
> >
> > But I wonder whether this bug have been fixed and what I can do except???don't do this test???.
> > Looking for your reply at your convenience.

Well the test is not enabled by default (the runtest file is not part of
the default scenario), which basically means that it should not be used
unless you want to experiment and try to figure out if it's worth to be
fixed/added to default run, etc.

I guess that the underlying issue in kernel will never be fixed and we
may as well drop the test.

-- 
Cyril Hrubis
chrubis@suse.cz
