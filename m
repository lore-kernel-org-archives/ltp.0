From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed,  9 Oct 2019 08:16:17 +0200
Subject: [LTP] Add TST_USES_MODULE and tst_test_root
Message-ID: <20191009061619.48677-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In preparation of lsmod01.sh patch v4.
The test requires a module only, if no modules are loaded and
in order to load the module, root is required.


