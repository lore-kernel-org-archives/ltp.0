From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Jul 2017 13:42:35 +0200
Subject: [LTP] [PATCH 2/3] commands/keyctl01: Fix getting key serial
 number
In-Reply-To: <42df2a59-d9de-30dd-2aa7-486dba24452e@cn.fujitsu.com>
References: <1494483656-15971-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <1494483656-15971-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170707130827.GC28534@rei.lan>
 <50b2e9a3-bf31-1765-c2e8-9487f7d09fa3@cn.fujitsu.com>
 <ffc2e37b-0464-f2f5-4757-a4378b48f501@cn.fujitsu.com>
 <42df2a59-d9de-30dd-2aa7-486dba24452e@cn.fujitsu.com>
Message-ID: <20170717114235.GB11059@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Can we just use "keyctl show" to match "inaccessible" when this
> happens?

Sure, if there is no better way let's go with the original version.

-- 
Cyril Hrubis
chrubis@suse.cz
