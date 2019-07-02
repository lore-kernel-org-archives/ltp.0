From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Jul 2019 15:05:13 +0200
Subject: [LTP] [PATCH] scenario_groups/default: run the kernel_misc test
 after the cve test
In-Reply-To: <5D19A7E1.10607@cn.fujitsu.com>
References: <20190628103900.10113-1-po-hsu.lin@canonical.com>
 <5D19A7E1.10607@cn.fujitsu.com>
Message-ID: <20190702130513.GB11122@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Your patch just workarounds the issue for now, because it still happens 
> if a new test designed to taint
> kernel is added to the group before cve group in future.

Unfortunately there is no better solution for this, so I pushed the
patch.

-- 
Cyril Hrubis
chrubis@suse.cz
