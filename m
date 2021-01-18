From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Jan 2021 13:34:31 +0100
Subject: [LTP] [RFC PATCH 0/2] kernel module detection (own implementation)
Message-ID: <20210118123433.17071-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

pre-release fix for BusyBox. It depends on modules.dep.

This implementation fails to detect built-in modules. IMHO the only
option is to run modprobe -n or modinfo from kmod:

$ modprobe -n aead; echo $?
0

$ modinfo aead
name:           aead
filename:       (builtin)
description:    Authenticated Encryption with Associated Data (AEAD)
license:        GPL
file:           crypto/aead

kmod implementation searches in /lib/modules/$(uname -r)/modules.builtin.modinfo,
thus I'll have look at that /lib/modules/$(uname -r)/modules.builtin.

But maybe we should just search for module in /lib/modules/$(uname -r)
(/system/lib/modules for android) instead expecting modules.dep + check
content of modules.builtin for built-in if file available.

@Sandeep @Steve: could you have a quick look on Android part?
Not sure if modules.dep (and modules.builtin) is available at all on AOSP.

Kind regards,
Petr

Petr Vorel (2):
  lib: Fix kernel module detection on BusyBox
  zram: Fix module detection on BusyBox

 lib/tst_kernel.c                              | 63 +++++++++++++++++--
 .../kernel/device-drivers/zram/zram_lib.sh    |  6 +-
 2 files changed, 60 insertions(+), 9 deletions(-)

-- 
2.29.2

