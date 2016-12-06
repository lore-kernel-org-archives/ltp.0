From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Tue, 6 Dec 2016 18:02:06 +0800
Subject: [LTP] [PATCH 3/5] SAFE_MACROS: Add SAFE_SYSTEM()
In-Reply-To: <20161205143320.GF22344@rei.lan>
References: <1480507955-12652-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1480507955-12652-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20161205143320.GF22344@rei.lan>
Message-ID: <58468C9E.1000908@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 12/05/2016 10:33 PM, Cyril Hrubis wrote:
> Hi!
> NACK to this one. We already have tst_run_cmd() which is way better for
> this purpose.

I got it, will use tst_run_cmd() instead, thanks very much.

Best Regards,
Guangwen Feng


