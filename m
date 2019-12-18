From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Dec 2019 11:39:27 +0100
Subject: [LTP] [PATCH] isofs: Convert to new library
In-Reply-To: <20191209093659.31996-1-lkml@jv-coder.de>
References: <20191209093659.31996-1-lkml@jv-coder.de>
Message-ID: <20191218103927.GA26489@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

thanks a lot for your patch, merged with few minor changes:
(mostly changing style + remove forgotten 'tst_resm TFAIL \',
use ROD_SILENT and remove commented out '# "loop,sbsector=32"').

You correctly removed getopt options: -n just set NO_CLEANUP, which is not used
any more on test.sh. Both libraries support TST_NO_CLEANUP, so we should
document it (going to send a patch).

Kind regards,
Petr
