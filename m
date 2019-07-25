From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Jul 2019 15:48:02 +0200
Subject: [LTP] [PATCH v1] timers/timer_create: Add test for
 CVE-2017-18344
In-Reply-To: <20190725115724.30055-1-camann@suse.com>
References: <20190725115724.30055-1-camann@suse.com>
Message-ID: <20190725134802.GB23135@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In kernels prior to 4.14.8 (missing commit cef31d9af908)
> the sigevent.sigev_notify field is not properly checked
> when creating a timer using timer_create(2).
> This can be used to read arbitrary kernel memory.

This is fine but I would like to move the timers into the syscalls
directory before we start to add new testcases. Should I do the move or
will you send a patch?

-- 
Cyril Hrubis
chrubis@suse.cz
