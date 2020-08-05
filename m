From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Aug 2020 17:22:44 +0200
Subject: [LTP] [PATCH 1/3] syscalls/mq_timed{send|receive}: Add test
 cases for bad address
In-Reply-To: <20200804144045.18875-2-Filip.Bozuta@syrmia.com>
References: <20200804144045.18875-1-Filip.Bozuta@syrmia.com>
 <20200804144045.18875-2-Filip.Bozuta@syrmia.com>
Message-ID: <20200805152244.GC631@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This patch introduces test cases for already existing
> tests for syscalls 'mq_timedsend()' and 'mq_timedreceive()'
> (mq_timedsend01, mq_timedreceive01). These test cases are for
> situations when bad addresses are passed for arguments 'msg_ptr'
> and 'abs_timeout' in which case errno 'EFAULT' is expected to be set.
> Value '(void *)1' is used as a bad address for these arguments.
> 
> Implementation notes:
> 
>    Structure 'struct test_case' from file 'mq_timed.h' was modified
>    with addition of two fields (bad_msg_addr and bad_ts_addr) which
>    represent indicators for the implemented testcases. They are set
>    to 1 for the new added test cases. These fileds are checked before
>    running the test to see if bad address value '(void *)1' should be
>    passed for the above mentioned arguments.

This is pretty clear from the patch itself. I'm not sure if there is
any added value in writing paragraphs that describe the obvious like
this one.

-- 
Cyril Hrubis
chrubis@suse.cz
