From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 6 Jun 2018 16:39:47 +0200
Subject: [LTP] [PATCH 1/3] syscalls/fchmod.h: Move common macros to
 fchmod.h
In-Reply-To: <1522407404-6877-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1522407404-6877-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180606143947.u7kziec3mvudbto4@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jinhui,

> Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/fchmod/fchmod.h   | 26 ++++++++++++++++++++++++++
>  testcases/kernel/syscalls/fchmod/fchmod02.c |  7 +------
>  testcases/kernel/syscalls/fchmod/fchmod03.c |  5 +----
>  testcases/kernel/syscalls/fchmod/fchmod04.c |  8 +-------
>  testcases/kernel/syscalls/fchmod/fchmod05.c | 15 +++++++--------
>  testcases/kernel/syscalls/fchmod/fchmod07.c |  4 +---
>  6 files changed, 37 insertions(+), 28 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/fchmod/fchmod.h
Pushed, thanks!
I just use SPDX-License-Identifier: GPL-2.0-or-later


Kind regards,
Petr
