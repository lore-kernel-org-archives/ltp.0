From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Thu, 25 Jun 2020 22:11:24 -0400
Subject: [LTP] [PATCH v4 0/2] IMA: Verify measurement of certificates
Message-ID: <20200626021126.56760-1-t-josne@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The IMA subsystem is capable of importing and measuring certificates. This
set of patches adds tests for verifying that keys are imported and measured
correctly.

Apologies to Mimi Zohar for the late reply.

Changelog:

v4
- Clarify documentation about required certificate.
- Fix case where multiple KEY_CHECK rules are present.

v3
- Document requirements for running the ima key tests and provide resources
  for generating keys.

v2
- Un-linebreak a few strings
- Enforce that some commands are available before running
- Move compute_digest function to ima_setup.sh
- Fix file permissions on ima_key.sh
- Move IMA_POLICY variable to ima_setup.sh
- Add keycheck.policy datafile

v1
- The following patchsets should be applied in that order.
- Add tests that verify measurement of keys and importing certificates.


*** BLURB HERE ***

Lachlan Sneff (2):
  IMA: Add a test to verify measurment of keys
  IMA: Add a test to verify importing a certificate into keyring

 runtest/ima                                   |   1 +
 .../kernel/security/integrity/ima/README.md   |  22 ++++
 .../integrity/ima/datafiles/keycheck.policy   |   1 +
 .../security/integrity/ima/tests/ima_keys.sh  | 112 ++++++++++++++++++
 .../integrity/ima/tests/ima_measurements.sh   |  36 +-----
 .../integrity/ima/tests/ima_policy.sh         |   1 -
 .../security/integrity/ima/tests/ima_setup.sh |  35 ++++++
 7 files changed, 172 insertions(+), 36 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/keycheck.policy
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_keys.sh

-- 
2.25.1

