From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Aug 2016 18:12:23 +0200
Subject: [LTP] [PATCH V2 2/4] waitpid07: use the new API
In-Reply-To: <1468940141-4342-2-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <20160718130536.GC18221@rei.suse.cz>
 <1468940141-4342-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1468940141-4342-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160803161223.GA32474@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (reap_children(-1, WNOHANG, fork_kid_pid, MAXKIDS)) {
> +		tst_res(TFAIL, "reap_children() failed");
> +		return;

Same applies here, the TFAIL here is redundant.

The rest looks good and the same applies to the rest of the patches.

-- 
Cyril Hrubis
chrubis@suse.cz
