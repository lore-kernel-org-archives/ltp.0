From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Dec 2016 15:33:20 +0100
Subject: [LTP] [PATCH 3/5] SAFE_MACROS: Add SAFE_SYSTEM()
In-Reply-To: <1480507955-12652-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1480507955-12652-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20161205143320.GF22344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
NACK to this one. We already have tst_run_cmd() which is way better for
this purpose.

-- 
Cyril Hrubis
chrubis@suse.cz
