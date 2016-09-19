From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Sep 2016 11:37:55 +0200
Subject: [LTP] [PATCH] readahead02: fix path for read_ahead_kb on raw
 partitions
In-Reply-To: <dcf8a988ac73c339e05a9f3e326c596065ce5d02.1473860921.git.jstancek@redhat.com>
References: <dcf8a988ac73c339e05a9f3e326c596065ce5d02.1473860921.git.jstancek@redhat.com>
Message-ID: <20160919093755.GA6220@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Path to read_ahead_kb is not consistent for all block devices,
> for example for LVM it's:
>   /sys/dev/block/$maj:$min/queue/read_ahead_kb
> but for raw partitions "queue" is only in "parent" device:
>   /sys/dev/block/$maj:$min/../queue/read_ahead_kb
> 
> This patch checks both types and reads first one it can find.
> Tested on LVM and raw partitions with 4.7.3.

Fixes the problem for me as well (minus the Btrfs anonymous block
devices that has to be fixed).

Acked.

-- 
Cyril Hrubis
chrubis@suse.cz
