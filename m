From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Jan 2017 15:57:34 +0100
Subject: [LTP] [PATCH 3/3] netstress.c: convert to new library API
In-Reply-To: <1482154595-4641-3-git-send-email-alexey.kodanev@oracle.com>
References: <1482154595-4641-1-git-send-email-alexey.kodanev@oracle.com>
 <1482154595-4641-3-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20170123145734.GC25788@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	shutdown(*fd, SHUT_WR);
> -	SAFE_CLOSE(cleanup, *fd);
> +	SAFE_CLOSE(*fd);
>  	*fd = -1;

FYI the SAFE_CLOSE() already sets fd to -1.

Otherwise it looks pretty much straightforward. I was concerned about
the cleanup, i.e. if the rest of the threads should be stopped before we
run it, but it looks like the worst case is 'use after free' in the
short period after of the threads enters cleanup via tst_brk() and
before it calls exit(), which does not sound that bad considering
something has failed anyway since we are most likely exitting with TBROK.

In short, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
