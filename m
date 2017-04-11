From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Apr 2017 16:30:50 +0200
Subject: [LTP] [PATCH 1/2] syscalls/quotactl02.c: add Q_XGETNEXTQUOTA
 flag test
In-Reply-To: <1490955322-7483-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1490955322-7483-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170411143050.GA3998@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +# ifdef Q_XGETNEXTQUOTA
> +	{QCMD(Q_XSETQLIM, USRQUOTA), &set_dquota, check_qlim, Q_XGETNEXTQUOTA,
> +	"set and use Q_XGETNEXTQUOTA to get xfs disk quota limits"},
> +# endif

Can we, rather than this ifdef, define a fallback definition for the
flag (ideally in an header in lapi) and handle possible EINVAL as TCONF
in case that we run on an older kernel?

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
