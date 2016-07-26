From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jul 2016 16:11:51 +0200
Subject: [LTP] [PATCH 1/2] network/tcp_cmds/rwho: fix/cleanup test
In-Reply-To: <1467033461-18797-1-git-send-email-alexey.kodanev@oracle.com>
References: <1467033461-18797-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160726141151.GF11679@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +for i in $(seq 1 $TST_TOTAL); do
> +	do_test
> +	tst_resm TPASS "Test $i/$TST_COUNT complete"
> +done

I do not understand why we run the test in a loop now 25 times,
otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
