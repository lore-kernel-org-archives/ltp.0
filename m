From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Fri, 12 Jun 2020 10:38:40 -0400
Subject: [LTP] [PATCH v2 0/2] IMA: Key Measurement + Certificate Measurement
 Tests
Message-ID: <20200612143842.3993-1-t-josne@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changeslog:

v2:
* Un-linebreak a few strings
* Enforce that some commands are available before running
* Move compute_digest function to ima_setup.sh
* Fix file permissions on ima_key.sh
* Move IMA_POLICY variable to ima_setup.sh
* Add keycheck.policy datafile

Lachlan Sneff (2):
  IMA: Add a test to verify measurment of keys
  IMA: Add a test to verify importing a certificate into keyring

 runtest/ima                                   |   1 +
 .../integrity/ima/datafiles/keycheck.policy   |   1 +
 .../security/integrity/ima/tests/ima_keys.sh  | 106 ++++++++++++++++++
 .../integrity/ima/tests/ima_measurements.sh   |  36 +-----
 .../integrity/ima/tests/ima_policy.sh         |   1 -
 .../security/integrity/ima/tests/ima_setup.sh |  35 ++++++
 6 files changed, 144 insertions(+), 36 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/keycheck.policy
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_keys.sh

-- 
2.25.1

