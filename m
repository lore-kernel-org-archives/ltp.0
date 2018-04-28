From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 28 Apr 2018 15:59:19 +0200
Subject: [LTP] [PATCH 0/2] Proper fix of vxlan03.sh tests.
Message-ID: <20180428135921.9622-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey, Cyril,

Alexey, can you please review this fix?

Cyril, I'd like to merge this fix before release.

Kind regards,
Petr

Petr Vorel (2):
  Revert "network/vxlan03: Fix getopts parameters passed to virt_lib.sh"
  network/vxlan: Fix getopts parameters passed from vxlan03 to
    virt_lib.sh

 testcases/network/virt/geneve01.sh  | 2 --
 testcases/network/virt/gre01.sh     | 3 ---
 testcases/network/virt/ipvlan01.sh  | 2 --
 testcases/network/virt/macvlan01.sh | 2 --
 testcases/network/virt/macvtap01.sh | 2 --
 testcases/network/virt/virt_lib.sh  | 3 +--
 testcases/network/virt/vlan01.sh    | 2 --
 testcases/network/virt/vlan02.sh    | 2 --
 testcases/network/virt/vlan03.sh    | 2 --
 testcases/network/virt/vxlan01.sh   | 2 --
 testcases/network/virt/vxlan02.sh   | 2 --
 testcases/network/virt/vxlan03.sh   | 3 ---
 12 files changed, 1 insertion(+), 26 deletions(-)

-- 
2.16.3

