From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Aug 2018 14:46:57 +0200
Subject: [LTP] [PATCH v2 1/4] Convert nanosleep02 to newlib
In-Reply-To: <20180827093053.24658-1-rpalethorpe@suse.com>
References: <20180827093053.24658-1-rpalethorpe@suse.com>
Message-ID: <20180827124657.GA28216@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> Also add extra check that nanosleep exited with the expected return value and
> errno for the user's information.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
LGTM.

> V2: Removed the falls through attribute for case statements and replace it with a comment

>  .../kernel/syscalls/nanosleep/nanosleep02.c   | 123 ++++++------------
>  1 file changed, 40 insertions(+), 83 deletions(-)

Kind regards,
Petr
