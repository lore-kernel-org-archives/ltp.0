From: Li Wang <liwang@redhat.com>
Date: Tue, 25 Jun 2019 15:07:35 +0800
Subject: [LTP] [PATCH v3 0/2] Test for Memory Protection Key
Message-ID: <20190625070737.30408-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Change log:
  v2 --> v3
  * Merge pkey02 into pkey01
  * Add huge page in the pkey test
  * tst_* functions reprot fail with TERRNO
  * tst_res(TFAIL, ...) could print exit code

Li Wang (2):
  pkey: add syscall numbers for pkey
  pkey: add test for memory protection keys

-- 
2.20.1

