From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Mar 2020 18:44:27 +0100
Subject: [LTP] [PATCHv2 1/3] zram/zram_lib.sh: fix variable name and
 algorithm retrieval
In-Reply-To: <CAMy_GT9VC5KvgCL68fVXVfKwErwKqiNab0s8SwPw9BZxMuLReg@mail.gmail.com>
References: <20190710072305.25806-1-po-hsu.lin@canonical.com>
 <20190710072305.25806-2-po-hsu.lin@canonical.com>
 <20200221055936.GA13261@dell5510>
 <CAMy_GT9VC5KvgCL68fVXVfKwErwKqiNab0s8SwPw9BZxMuLReg@mail.gmail.com>
Message-ID: <20200317174427.GA11295@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Po-Hsu,

> thanks for the reply, and sorry for the late response too, need some
> time to throw myself back in time.

> To my understanding, the zram_algs="lzo lzo lzo lzo" in zram01.sh is a
> dummy mapping (placeholder?) for 4 compression algorithms with 4
> different setup, one for (zram_sizes=26214400, zram_mem_limits=25M,
> zram_filesystems=ext3), and one for (zram_sizes=26214400,
> zram_mem_limits=25M, zram_filesystems=ext4) and so on.

> With this patch the test will be more comprehensive, as it's not
> trying to set the algorithm to "lzo" 4 times (as defined in zram_algs
> from zram01.sh), but try to switch to all supported algorithm reported
> back from  /sys/block/zram0/comp_algorithm

> So yes, this zram_algs in zram01.sh will not be used at all after
> applying my patch here, maybe it can be removed but I am not sure if
> we should keep it there as a placeholder.

Also sorry for the delay. I rebased and merged these 2 commits, removed
$zram_algs (as it's was not used any more).
Although this and second commit should be probably as a single commit (to be an
atomic change), I kept them separate.

Thanks for your contributions.

Kind regards,
Petr
