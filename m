From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Jan 2018 13:24:59 +0100
Subject: [LTP] [lkp-robot] [sched/deadline] e0367b1267:
 WARNING:at_kernel/sched/sched.h:#assert_clock_updated
In-Reply-To: <20180125112013.GA6110@localhost.localdomain>
References: <20180125062839.GM5185@yexl-desktop>
 <20180125112013.GA6110@localhost.localdomain>
Message-ID: <20180125122458.GB3420@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hummm, wondering how LTP sched tests could trigger this, since a quick
> grep into ltp didn't show DEADLINE usage.

See kernel/syscalls/sched_setattr/sched_setattr01.c

-- 
Cyril Hrubis
chrubis@suse.cz
