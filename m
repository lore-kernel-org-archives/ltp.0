From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Jun 2019 16:55:07 +0200
Subject: [LTP] [PATCH v2 3/3] syscalls/bind01: convert to new library.
In-Reply-To: <20190610002610.2187-4-sspatil@android.com>
References: <20190610002610.2187-1-sspatil@android.com>
 <20190610002610.2187-4-sspatil@android.com>
Message-ID: <20190613145507.GD29926@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

However the test fails with -i 2 after this patch since on second
iteration since the socket is already bind for the possitive test
because we no longer close the socket after each iteration. Looking at
the bind tests we should move this one into a separate testcase and add
a few more positive tests as well we seem to test only AF_INET,
SOCK_STREAM combination which does not even cover ipv4 nor we attemp to
connect to the socket that have been bind.

> +// SPDX-License-Identifier: GPL-2.0

Changed this to GPL-2.0-or-later to match the original license.

And removed the NULL parameter from the TST_GET_UNUSED_PORT(), since
newlib variant does not have the cleanup callback parameter.


-- 
Cyril Hrubis
chrubis@suse.cz
