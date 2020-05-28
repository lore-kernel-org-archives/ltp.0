From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 May 2020 13:05:52 +0200
Subject: [LTP] [RFC PATCH 0/2] LVM: Drop legacy scripts and runtest files
Message-ID: <20200528110554.10179-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I guess there is no doubt, that new implementation is better thus no
need for legacy version. I hope that dropping legacy fs is ok (if not we
should support them in new API).

Kind regards,
Petr

Petr Vorel (2):
  LVM: Don't require root for generate_lvm_runfile.sh
  LVM: Drop legacy scripts and runtest files

 doc/ltp-run-files.txt                      |   4 +-
 runtest/lvm.part1                          | 217 ---------------------
 runtest/lvm.part2                          |  72 -------
 testcases/misc/lvm/generate_lvm_runfile.sh |   1 -
 testscripts/ltpfslvm.sh                    | 200 -------------------
 testscripts/ltpfsnolvm.sh                  | 150 --------------
 6 files changed, 1 insertion(+), 643 deletions(-)
 delete mode 100644 runtest/lvm.part1
 delete mode 100644 runtest/lvm.part2
 delete mode 100755 testscripts/ltpfslvm.sh
 delete mode 100755 testscripts/ltpfsnolvm.sh

-- 
2.26.2

