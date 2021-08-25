From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Aug 2021 16:36:57 +0200
Subject: [LTP] [PATCH 7/7] syscalls/clone07: Remove the testcase
In-Reply-To: <20210813072731.22500-1-zhanglianjie@uniontech.com>
References: <20210813072731.22500-1-zhanglianjie@uniontech.com>
Message-ID: <YSZViQMSzkSe9bCf@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -static int do_child(void)
> -{
> -	return 0;
> -}

As far as I can tell this test is asserting that return from the
do_child() function exits the child, which is not done in any other
tests where we do exit the child with _exit(0).

-- 
Cyril Hrubis
chrubis@suse.cz
