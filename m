From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 Sep 2020 19:44:35 +0200
Subject: [LTP] [PATCH 0/4] TPM 2.0 fixes in IMA tests
Message-ID: <20200925174439.9534-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

finally managed to fix most of the problems with TPM 2.0 and non-sha1
algorithms supported by 6f1a1d103b48 ima: ("Switch to ima_hash_algo for
boot aggregate") from v5.8-rc1.

I still have problem with boot aggregate (test1) which fails with TPM
2.0 on kernel < v5.8-rc1.

Any idea what's wrong?

Otherwise I'm quite confident with changes, I'd prefer to get it merge
to this release. But that'd require to be reviewed and tested ASAP
(ideally during Monday).

Kind regards,
Petr

Petr Vorel (4):
  IMA: Move get_algorithm_digest(), set_digest_index() to ima_setup.sh
  IMA: Rewrite ima_boot_aggregate.c to new API
  ima_tpm.sh: Fix calculating boot aggregate
  ima_tpm.sh: Fix calculating PCR aggregate

 .../integrity/ima/src/ima_boot_aggregate.c    | 110 ++++----
 .../integrity/ima/tests/ima_measurements.sh   |  62 +----
 .../security/integrity/ima/tests/ima_setup.sh |  70 ++++++
 .../security/integrity/ima/tests/ima_tpm.sh   | 238 +++++++++++++-----
 4 files changed, 311 insertions(+), 169 deletions(-)

-- 
2.28.0

