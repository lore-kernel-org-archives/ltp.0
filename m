From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 4 Sep 2018 14:40:32 +0200
Subject: [LTP] [PATCH v7 1/4] Testing statx syscall
In-Reply-To: <20180903121631.3652-1-vaishnavi.d@zilogic.com>
References: <20180903121631.3652-1-vaishnavi.d@zilogic.com>
Message-ID: <20180904124032.GA5625@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've further split this patch into one that adds the configure checks
and fallback headers and another that adds the first test.

And also did following adjustements:

* The right configure check for structure existence is AC_CHECK_TYPES()

  Also things break badly if you check for the structure in the
  linux/stat.h but include sys/stat.h in the lapi fallback header, so we
  have to check for the sys/stat.h in the configure check as well.

* The statx() wrapper has to use tst_syscall() so that you get correct
  response when the syscall number is not defined on the system or in
  the fallback file

* Removed the full GPLv2 from the lapi headers, it's not needed when the
  SPDX identifier has been added, also since that is a machine readable
  string it has to be exactly SPDX-License-Identifier: GPL-2.0-or-later

And for the statx01:

* Added the newly added .needs_defs flag so that the test works fine on
  systems with /tmp mounted with nodev

* Changed the test to close the fd in the test setup, there is no reason
  to keep it open until cleanup

* Changed the SAFE_WRITE(0, ...) to SAFE_WRITE(1, ...) since we need to
  make sure the whole buffer has been written prior the test

* Remove the word "obtained" from the test messages as it was only
  making the messages unnecessarily longer

* The check for stx_block was bogus, after thinking about it we create
  file that contains 256 bytes so the number of blocks has to be
  reasonably small number. Btrfs tends to allocate page_size blocks,
  which means that the reported size there would be 128 which I suppose
  is good enough upper bound. So we now check that the reported number
  of blocks is > 0 and <= 128, which I guess is the best without
  dwelling into filesystem details.

* Removed the full GPLv2 from the lapi headers, it's not needed when the
  SPDX identifier has been added, also since that is a machine readable
  string it has to be exactly SPDX-License-Identifier: GPL-2.0-or-later

And pushed the resulting two patches, thanks!

-- 
Cyril Hrubis
chrubis@suse.cz
