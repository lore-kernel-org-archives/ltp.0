From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Nov 2016 09:56:17 +0100
Subject: [LTP] [PATCH] syscalls/getpriority01: exclude default priority
 check for PRIO_USER.
In-Reply-To: <1479362570-12526-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1479362570-12526-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20161122085616.GB7048@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The current user priority is various when testing,
> we should not check it as default value.

What system does this happen on? It should probably be mentioned in the
commit message.

And we should probably as well just revert the change I've did and check
only that errno wasn't set since the value may be set even to -1.

-- 
Cyril Hrubis
chrubis@suse.cz
