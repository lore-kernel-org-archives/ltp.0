From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Apr 2020 17:18:53 +0200
Subject: [LTP] [PATCH v2 3/3] testcases/kernel/syscalls/ioctl: Add test
 for RTC ioctls used to turn on/off RTC interrupts
In-Reply-To: <20200423150626.12672-4-fbozuta1@gmail.com>
References: <20200423150626.12672-1-fbozuta1@gmail.com>
 <20200423150626.12672-4-fbozuta1@gmail.com>
Message-ID: <20200430151853.GB3299@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The same comments apply for the next two tests as well.

Also looking closer what these tests do miss compared to the old rtc01.c
tests are checks that alarm actuall fires and that the update interrupts
are propagated as well. Can we please implement these two cases in these
tests as well and get rid of the old test after that?

-- 
Cyril Hrubis
chrubis@suse.cz
