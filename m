From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Jan 2017 14:02:51 +0100
Subject: [LTP] [PATCH v2 2/3] ipc/msgget0*: Make use of IPC related
	macros
In-Reply-To: <1485167476-18151-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170119143903.GC9193@rei.lan>
 <1485167476-18151-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1485167476-18151-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170123130251.GB24526@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've changed these two test to include the tst_safe_sysv_ipc.h header
and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
