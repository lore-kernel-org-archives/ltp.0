From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Oct 2016 17:11:01 +0200
Subject: [LTP] [PATCH] network/busy_poll: TCONF if driver doesn't
 support busy-poll feature
In-Reply-To: <1475761739-14380-1-git-send-email-alexey.kodanev@oracle.com>
References: <1475761739-14380-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20161010151059.GD1684@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +ethtool --show-features $(tst_iface) | grep -q 'busy-poll.*on' || \
> +	tst_brkm TCONF "busy poll not supported by driver"
> +

Maybe it would be better to move all the TCONF checks into a common
bussy_poll_lib.sh and source it in the scripts.

And also we should check for ethtool command with the tst_check_cmds.

-- 
Cyril Hrubis
chrubis@suse.cz
