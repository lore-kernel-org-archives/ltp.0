From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Aug 2018 15:19:16 +0200
Subject: [LTP] [PATCH v2 2/4] Convert fcntl33 to newlib
In-Reply-To: <20180827093053.24658-2-rpalethorpe@suse.com>
References: <20180827093053.24658-1-rpalethorpe@suse.com>
 <20180827093053.24658-2-rpalethorpe@suse.com>
Message-ID: <20180827131916.GA7820@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> Also add extra checks that fcntl does not return success after trying to
> downgrade a lease on a file where it can only be removed and that it can
> downgrade a lease on a file opened as read only.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM :).


Kind regards,
Petr
