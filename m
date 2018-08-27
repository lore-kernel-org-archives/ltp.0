From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Aug 2018 15:46:27 +0200
Subject: [LTP] [PATCH v2 3/4] Convert futex_wait_bitset tests to newlib
In-Reply-To: <20180827093053.24658-3-rpalethorpe@suse.com>
References: <20180827093053.24658-1-rpalethorpe@suse.com>
 <20180827093053.24658-3-rpalethorpe@suse.com>
Message-ID: <20180827134627.GB7820@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

>  .../kernel/syscalls/futex/futex_wait_bitset.h | 54 ++++++++++++-------
>  .../syscalls/futex/futex_wait_bitset01.c      | 22 ++------
>  .../syscalls/futex/futex_wait_bitset02.c      | 23 ++------
>  3 files changed, 43 insertions(+), 56 deletions(-)
LGTM.

Kind regards,
Petr
