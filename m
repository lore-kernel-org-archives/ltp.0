From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  7 May 2021 21:14:11 +0200
Subject: [LTP] [PATCH v4 0/3] IMA: Add test for dm-crypt measurement
Message-ID: <20210507191414.14795-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi, Lakshmi, Tushar,

rebased v3 [1], hope everything correct.
Could you please review and test it?

v3->v4:
* rewritten "IMA: Generalize key measurement tests"
* new commit "ima_keys.sh: Check policy only once"


Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=230766&state=*

Petr Vorel (2):
  ima_keys.sh: Check policy only once
  IMA: Generalize key measurement tests

Tushar Sugandhi (1):
  IMA: Add test for dm-crypt measurement

 .../kernel/security/integrity/ima/README.md   | 20 +++++
 .../security/integrity/ima/datafiles/Makefile |  2 +-
 .../ima/datafiles/ima_dm_crypt/Makefile       | 11 +++
 .../ima_dm_crypt/ima_dm_crypt.policy          |  1 +
 .../integrity/ima/tests/ima_dm_crypt.sh       | 47 +++++++++++
 .../security/integrity/ima/tests/ima_keys.sh  | 84 +++----------------
 .../security/integrity/ima/tests/ima_setup.sh | 76 ++++++++++++++++-
 7 files changed, 168 insertions(+), 73 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_dm_crypt/Makefile
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_dm_crypt/ima_dm_crypt.policy
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh

-- 
2.31.1

