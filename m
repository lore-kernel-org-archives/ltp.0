From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Jul 2019 12:14:13 +0200
Subject: [LTP] [PATCH] zram/zram_lib.sh: fix local variable assignment
In-Reply-To: <20190701113705.2758-1-po-hsu.lin@canonical.com>
References: <20190701113705.2758-1-po-hsu.lin@canonical.com>
Message-ID: <20190702101412.GB32529@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The compression algorithm was stored into a local variable "algs",
> however the variable name "zram_algs" was used in the for loop later.
>
> Unify them with "zram_algs", and use sed to get rid of the square
> brackets that indicates the compression algorithm currently in use.
>     $ cat /sys/block/zram0/comp_algorithm
>     [lzo] lz4 lz4hc 842 zstd

The test that calls the zram_compress_alg() function defines the
zram_algs variable and the length must match the number of created
devices in zram_load otherwise the test would fail to write to
non-existing sys_path in case that there is more than 4 algorithms.

I guess that deeper changes to the test would be needed in order to be
able to support testing all available compression algorithms.

> Also, the /bin/sh was symbolically link to dash in Ubuntu.
> This is making the one-liner local variable assignment not working [1]:
>     /opt/ltp/testcases/bin/zram01.sh: 102: local: 842: bad variable name
> 
> Break it into two lines to solve this issue.
> 
> [1] https://wiki.ubuntu.com/DashAsBinSh#local

This change is obviously correct, can you please send a patch only with
this change so that it can be commited? Then we can figure something
out about the compression algorithms.

-- 
Cyril Hrubis
chrubis@suse.cz
