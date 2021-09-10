From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 10 Sep 2021 11:14:15 +0200
Subject: [LTP] [PATCH 1/2] rtc01: add space to beginning of comments
In-Reply-To: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
References: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
Message-ID: <YTsh5wcAbNDjJQpi@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Improve readability of comments - no functional change.

Actually some of the comments are really commenting the obvious so it
would be better just to remove most.

For instance this:

	/* Read and alarm tests */
	read_alarm_test();

How does the comment here add any value?

And I would say that it's mostly the same for the ioclt() calls as well,
the constants do have reasonable names so I guess that in cases like
this:

	/* Read current alarm time */
	ret = ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm);

it's kind of obvious that we do read the alarm even without the comment.

-- 
Cyril Hrubis
chrubis@suse.cz
