From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Dec 2019 11:59:20 +0100
Subject: [LTP] [PATCH] isofs: Convert to new library
In-Reply-To: <20191218103927.GA26489@dell5510>
References: <20191209093659.31996-1-lkml@jv-coder.de>
 <20191218103927.GA26489@dell5510>
Message-ID: <20191218105920.GB26489@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> You correctly removed getopt options: -n just set NO_CLEANUP, which is not used
> any more on test.sh. Both libraries support TST_NO_CLEANUP, so we should
> document it (going to send a patch).
In the end I just merged that simple doc change.
I wonder if there would be use for variable keeping $TST_TMPDIR (because it's
deleted even with $TST_NO_CLEANUP).

Kind regards,
Petr
