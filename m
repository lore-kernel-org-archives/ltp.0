From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 May 2020 16:36:40 +0200
Subject: [LTP] [PATCH v2] open_posix_testsuite: Fix compilation issues
In-Reply-To: <1585014998-27587-1-git-send-email-zou_wei@huawei.com>
References: <1585014998-27587-1-git-send-email-zou_wei@huawei.com>
Message-ID: <20200505143640.GD27810@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Fix compilation issues:
> 1. Add the '-lpthread -lrt -lm' config into LDFLAGS
> 2. Add the '-pthread' config into CFLAGS
> 3. Update makefile and locate-test script
>
> If only add -pthread to LDFLAGS and CFLAGS,
> some cases will fail to compile, such as timers/twoevtimers.c,
> need to add -lrt to compile successfully.

As discussed previously we should add the flags to the testcases that
actually needs them instead of adding them to all testcases.

-- 
Cyril Hrubis
chrubis@suse.cz
