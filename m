From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 14 Sep 2017 11:00:11 +0200
Subject: [LTP] [PATCH] cve/cve-2016-10044.c: Fix compilation without
 READ_IMPLIES_EXEC
In-Reply-To: <1505349920-4620-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1505349920-4620-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170914090011.GA3467@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Compilation failed on some older distributions(e.g. RHEL5.11) due to
> undefined READ_IMPLIES_EXEC in <sys/personality.h>, so we fix it.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
