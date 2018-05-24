From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 May 2018 17:41:51 +0200
Subject: [LTP] [PATCH 0/6] network/tcp_cc: add new tests bbr01 and bbr02
In-Reply-To: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
References: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180524154151.6fxejmfqvkwoaa3e@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> The patches are adding two new tests for BBR congestion control
> algorithm.

> * bbr01 test is a simple one and similar to dctcp01 but not using
>   ECN when emulating packet loss.

> * bbr02 test, in addition to packet loss emulation with ECN, is using
>   delay, reorder and corrupt features of 'tc'. And also iterates the
>   different queueing disciplines.
Whole patchset looks good to me. I hope to have deeper look tomorrow or on Monday (if you
don't merge it before).

> The last test, I guess, should use TST_TEST_DATA for passing queueing
> disciplines.
Yes.


Kind regards,
Petr
