From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Jul 2017 13:29:39 +0200
Subject: [LTP] [PATCH v2] lib/tst_timer_test.c: fix unsigned int
 overflow on RHEL5.11GA
In-Reply-To: <1500543514-5800-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170720091359.GA27245@rei>
 <1500543514-5800-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170720112939.GC32092@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've changed the patch to silence some unsigned vs signed comparsion
warnings it introduced and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
