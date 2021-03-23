From: Heiko Carstens <hca@linux.ibm.com>
Date: Tue, 23 Mar 2021 22:58:16 +0100
Subject: [LTP] [PATCH 0/3] s390 vdso fixes
In-Reply-To: <YFmUrVOyX4q+8Dy9@osiris>
References: <YFmUrVOyX4q+8Dy9@osiris>
Message-ID: <20210323215819.4161164-1-hca@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Li Wang reported that clock_gettime(CLOCK_MONOTONIC_RAW, ...) does not
work correctly on s390 via vdso. Debugging this also revealed an
unrelated bug (first patch).

The second patch fixes the problem: the tod clock steering parameters
required by __arch_get_hw_counter() are only present within the first
element of the _vdso_data array and not at all within the _timens_data
array.

Instead of working around this simply provide an s390 specific vdso
data page which contains the tod clock steering parameters.

This allows also to remove ARCH_HAS_VDSO_DATA again.

Heiko Carstens (3):
  s390/vdso: fix tod clock steering
  s390/vdso: fix arch_data access for __arch_get_hw_counter()
  lib/vdso: remove struct arch_vdso_data from vdso data struct

 arch/Kconfig                              |  3 ---
 arch/s390/Kconfig                         |  1 -
 arch/s390/include/asm/vdso.h              |  4 +++-
 arch/s390/include/asm/vdso/data.h         | 13 ------------
 arch/s390/include/asm/vdso/datapage.h     | 17 +++++++++++++++
 arch/s390/include/asm/vdso/gettimeofday.h | 11 ++++++++--
 arch/s390/kernel/time.c                   |  5 +++--
 arch/s390/kernel/vdso.c                   | 25 ++++++++++++++++++++---
 arch/s390/kernel/vdso64/vdso64.lds.S      |  3 ++-
 include/vdso/datapage.h                   | 10 ---------
 10 files changed, 56 insertions(+), 36 deletions(-)
 delete mode 100644 arch/s390/include/asm/vdso/data.h
 create mode 100644 arch/s390/include/asm/vdso/datapage.h

-- 
2.25.1

