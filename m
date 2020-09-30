From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Sep 2020 18:02:10 +0200
Subject: [LTP] [PATCH v4 0/4]	TPM 2.0 fixes in IMA tests
Message-ID: <20200930160214.29358-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi, Lakshmi,

changes v3->v4:

test1:
* require 1.3.1 instead of 1.3 (simplification)

test2
* use --ignore-violations if evmctl >= 1.3.1 available
* check error only for 1.3.1, for others check only the result
* check for ima_policy=tcb (or ima_tcb) and require 1.3.1 if used
(to get --ignore-violations)

Kind regards,
Petr

Petr Vorel (4):
  IMA: Move get_algorithm_digest(), set_digest_index() to ima_setup.sh
  IMA: Rewrite ima_boot_aggregate.c to new API
  ima_tpm.sh: Fix calculating boot aggregate
  ima_tpm.sh: Fix calculating PCR aggregate

 .../integrity/ima/src/ima_boot_aggregate.c    | 113 ++++---
 .../integrity/ima/tests/ima_measurements.sh   |  62 +---
 .../security/integrity/ima/tests/ima_setup.sh |  84 +++++-
 .../security/integrity/ima/tests/ima_tpm.sh   | 284 ++++++++++++++----
 4 files changed, 371 insertions(+), 172 deletions(-)

-- 
2.28.0

