From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jul 2016 16:22:26 +0200
Subject: [LTP] [PATCH 2/2] network/xinetd: fix/cleanup test
In-Reply-To: <1467033461-18797-2-git-send-email-alexey.kodanev@oracle.com>
References: <1467033461-18797-1-git-send-email-alexey.kodanev@oracle.com>
 <1467033461-18797-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160726142225.GG11679@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +setup()
> +{
> +	[ -f "/usr/lib/systemd/system/telnet.socket" ] && \
> +		tst_brkm TCONF "xinetd doesn't manage telnet"

Hmm, there are still major distributions that were released in
pre-systemd times and will be maintained a few more years.

-- 
Cyril Hrubis
chrubis@suse.cz
