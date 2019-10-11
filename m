From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 11 Oct 2019 10:39:58 +0200
Subject: [LTP] [PATCH 2/2] tst_test.sh: Add public tst_test_root command
In-Reply-To: <20191011083612.GA1315@dell5510>
References: <20191009061619.48677-1-lkml@jv-coder.de>
 <20191009061619.48677-3-lkml@jv-coder.de> <20191009113919.GB7561@rei.lan>
 <64bb824c-d577-86e5-bfa5-17a8cfbf4174@jv-coder.de>
 <20191009114854.GC7561@rei.lan>
 <22bc4865-295c-3147-8e26-f258fac472f8@jv-coder.de>
 <20191009122802.GB7677@rei.lan> <20191011083612.GA1315@dell5510>
Message-ID: <378952ff-60a0-ebc4-da31-528d379a74b1@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


>> @Jan @Peter what do you think?
> We already did rename once (0567a8958 shell: Rename
> s/tst_check_cmds/tst_test_cmds/), but even if we didn't;
> I'm for renaming tst_test_* to tst_require_* - clear names are important
> (consistency with names as well).
That's two (and me) in favor of renaming tst_test_.
I will submit a patch for it.
