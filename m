From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 9 Oct 2019 08:57:20 +0200
Subject: [LTP] [PATCH 2/2] tst_test.sh: Add public tst_test_root command
In-Reply-To: <20191009065225.GA27854@dell5510>
References: <20191009061619.48677-1-lkml@jv-coder.de>
 <20191009061619.48677-3-lkml@jv-coder.de> <20191009065225.GA27854@dell5510>
Message-ID: <fa4c146c-2916-2b65-449d-daf12838ce35@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,


> You need to replace s/_tst_require_root/tst_test_root/ in other library files
> (tst_net.sh, tst_security.sh).
Sorry, did not expect functions with _ to be used in other files.
I'll check it next time

J?rg
