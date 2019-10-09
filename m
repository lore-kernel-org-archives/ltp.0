From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 9 Oct 2019 09:47:16 +0200
Subject: [LTP] [PATCH] ext4-new-features: Fix paths to ffsb-config files
In-Reply-To: <20191009062112.49947-1-lkml@jv-coder.de>
References: <20191009062112.49947-1-lkml@jv-coder.de>
Message-ID: <20191009074716.GA601@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> The path to the ffsb-config files was just plain wrong (they are copied to
> $LTPROOT/testcases/data/ext4-ffsb, but searched in cwd.
> This is the same fix as in 4ae5699d, only for other tests.

> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> ---
>  .../ext4-journal-checksum/ext4_journal_checksum.sh            | 2 +-
>  .../ext4-uninit-groups/ext4_uninit_groups_test.sh             | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Thanks for your patch.
ext4_online_defrag_test.sh still contains wrong path.

I'd prefer to introduce some variable in ext4_funcs.sh, e.g.:
FFSB_CONFIG_DIR="$LTPROOT/testcases/data/ext4-ffsb"

Kind regards,
Petr
