From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 9 Oct 2019 08:52:25 +0200
Subject: [LTP] [PATCH 2/2] tst_test.sh: Add public tst_test_root command
In-Reply-To: <20191009061619.48677-3-lkml@jv-coder.de>
References: <20191009061619.48677-1-lkml@jv-coder.de>
 <20191009061619.48677-3-lkml@jv-coder.de>
Message-ID: <20191009065225.GA27854@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

...
>  testcases/lib/tst_test.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

...
> -_tst_require_root()
> -{
> -	if [ "$(id -ru)" != 0 ]; then
> -		tst_brk TCONF "Must be super/root for this test!"
> -	fi
> -}
You need to replace s/_tst_require_root/tst_test_root/ in other library files
(tst_net.sh, tst_security.sh).
...

Kind regards,
Petr
