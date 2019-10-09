From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 9 Oct 2019 09:53:10 +0200
Subject: [LTP] [PATCH 2/2] tst_test.sh: Add public tst_test_root command
In-Reply-To: <fa4c146c-2916-2b65-449d-daf12838ce35@jv-coder.de>
References: <20191009061619.48677-1-lkml@jv-coder.de>
 <20191009061619.48677-3-lkml@jv-coder.de>
 <20191009065225.GA27854@dell5510>
 <fa4c146c-2916-2b65-449d-daf12838ce35@jv-coder.de>
Message-ID: <20191009075309.GA641@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi J?rg,

> > You need to replace s/_tst_require_root/tst_test_root/ in other library files
> > (tst_net.sh, tst_security.sh).
> Sorry, did not expect functions with _ to be used in other files.
> I'll check it next time
No problem :). Yes, they cannot be used in tests. But new shell API library is spread in 3 files.
I added a patch to document library itself from developer perspective [1].

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1166786/
