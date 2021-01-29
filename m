From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 13:18:12 +0100
Subject: [LTP] [PATCH 0/5] zram cleanup
Message-ID: <20210129121817.12563-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this is a cleanup which began as
https://patchwork.ozlabs.org/project/ltp/patch/20210114183226.794-1-pvorel@suse.cz/

More TODO:
* sometimes timeout on zram01, when all 4 filesystems are supported.
Maybe simple LTP_TIMEOUT_MUL=$dev_num
or LTP_TIMEOUT_MUL=$((dev_num/2)) # will be 2 only for 4 filesystems

* -i parameter does not work
If we want to even bother (maybe somebody would like to stress zram
using -i), the problem is: that zram_load() and zram_cleanup() are
setup/cleanup functions, but would have to be called for each iteration.

To fix this I can change them to be normal test functions and
zram_cleanup() also a cleanup function. But it's not a first time when I
miss in our API setup and cleanup to be run in each iteration
(.setup_iterations = foo, TST_SETUP_ITERATIONS=foo).

* maybe move section with checking /proc/meminfo to setup as well?

Kind regards,
Petr

Petr Vorel (5):
  zram: Require root
  zram: Calculate dev_num variable
  zram01.sh: Check properly mkfs.* dependencies
  zram: Move zram_compress_alg() to zram02.sh
  zram: Move test specific functions out of zram_lib.sh

 .../kernel/device-drivers/zram/zram01.sh      |  99 ++++++++++++++--
 .../kernel/device-drivers/zram/zram02.sh      |  77 ++++++++++--
 .../kernel/device-drivers/zram/zram_lib.sh    | 111 +++---------------
 3 files changed, 168 insertions(+), 119 deletions(-)

-- 
2.30.0

