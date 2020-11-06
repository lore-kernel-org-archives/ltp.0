From: Alexander Egorenkov <egorenar@linux.ibm.com>
Date: Fri,  6 Nov 2020 14:06:22 +0100
Subject: [LTP] [PATCH 0/2] lib/tst_virt: support IBM/Z LPAR and z/VM
 virtualization environments
Message-ID: <20201106130624.454614-1-egorenar@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Support detection of virtualization environment on IBM System Z.

Alexander Egorenkov (2):
  lib/tst_virt: fix detection when systemd-detect-virt returns 1
  lib/tst_virt: support IBM/Z LPAR and z/VM virtualization environments

 include/tst_cpu.h |  3 +++
 lib/tst_virt.c    | 66 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 3 deletions(-)

-- 
2.26.2

