From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Aug 2020 15:09:12 +0200
Subject: [LTP] [PATCH v3 0/4] IMA: verify measurement of certificate
 imported into a keyring
Message-ID: <20200817130916.27634-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi, Lakshmi,

changes v2->v3:
fixed regression in my third commit.
(please verify it on installed LTP, or at least run make install in
testcases/kernel/security/integrity/ima/datafiles/ima_keys/)

Kind regards,
Petr

Lachlan Sneff (1):
  IMA: Add a test to verify measurement of certificate imported into a
    keyring

Petr Vorel (3):
  IMA/ima_keys.sh: Fix policy content check usage
  IMA: Refactor datafiles directory
  IMA/ima_keys.sh: Enhance policy checks

 .../kernel/security/integrity/ima/README.md   |  12 +-
 .../security/integrity/ima/datafiles/Makefile |  10 +-
 .../ima/datafiles/ima_kexec/Makefile          |  11 ++
 .../datafiles/{ => ima_kexec}/kexec.policy    |   0
 .../integrity/ima/datafiles/ima_keys/Makefile |  11 ++
 .../datafiles/{ => ima_keys}/keycheck.policy  |   2 +-
 .../ima/datafiles/ima_keys/x509_ima.der       | Bin 0 -> 650 bytes
 .../ima/datafiles/ima_policy/Makefile         |  11 ++
 .../datafiles/{ => ima_policy}/measure.policy |   0
 .../{ => ima_policy}/measure.policy-invalid   |   0
 .../security/integrity/ima/tests/ima_keys.sh  | 104 +++++++++++++++---
 11 files changed, 133 insertions(+), 28 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_kexec/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_kexec}/kexec.policy (100%)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_keys/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_keys}/keycheck.policy (59%)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_keys/x509_ima.der
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_policy/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_policy}/measure.policy (100%)
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_policy}/measure.policy-invalid (100%)

-- 
2.28.0

