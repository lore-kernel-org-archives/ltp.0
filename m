From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Oct 2016 17:21:53 +0200
Subject: [LTP] [PATCH] test_net.sh: don't waste time waiting 1 sec in
 tst_ping()
In-Reply-To: <1475761814-14468-1-git-send-email-alexey.kodanev@oracle.com>
References: <1475761814-14468-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20161010152152.GE1684@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The current user of this function is 'icmp-uni-basic.sh' ipsec test
> group that includes 17 tests. Usually, it takes about 50 seconds for
> each test run. This change allows to run the same test in ~5 seconds
> because interval is 0 and default number of packets transmitted for
> each size parameter increased from 10 to 500.

Looks like a great speed up.

-- 
Cyril Hrubis
chrubis@suse.cz
