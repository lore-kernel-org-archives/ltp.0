From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Mar 2018 16:57:27 +0100
Subject: [LTP] [RFC PATCH v2 0/4] Rewrite tests into new API + fixes
Message-ID: <20180314155731.5943-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this is a second attempt to rewrite IMA tests.
Comments and fixes are welcome.

Changes v1->v2:
* ima_measurements.sh: add support for "ima-ng" and "ima-sig" IMA
  measurement templates
* ima_measurements.sh: add support for most of hash algorithms is
  defined in include/uapi/linux/hash_info.h
* fix ima_boot_aggregate ("ima/ima_boot_aggregate: Increase MAX_EVENT_SIZE to 8k")
* ima_tpm.sh: fixes of TPM test ("ima/tpm: Various fixes")
* ima_measurements.sh: drop ima_measure and use evmctl (external dependency) instead
* ima_measurements.sh: check XFS version for iversion support

TODO
* ima_measurements.sh: Add support for ima_template_fmt kernel parameter.

* ima_policy.sh: Detect if the policy must be signed [1] (IMA_WRITE_POLICY or
"secure_boot" kernel parameter).
@Mimi: What is a best approach in case policy must be signed? measure.policy
and measure.policy-invalid files are not signed should we skip all tests in
ima_policy.sh with something like "Not supported when policy must be signed"?
Or running them both and expect them to fail as they're not signed?
As that's how I understand your related commit in kernel
(19f8a84713ed "ima: measure and appraise the IMA policy itself").
BTW load_policy() use old approach catting the content into sysfs policy file.
Maybe it'd be good to echo policy filename into sysfs policy file for kernel >
4.6 (feature added in 7429b092811f "ima: load policy using path").

* ima_measurement.sh,ima_violations.sh: Avoid using tmpfs filesystem [1]. You
suggested using RAM block device. Would it be ok to use filesystem created on
loop device (/dev/loop0)? Or even create image file in $TMPDIR (mostly
/tmp, which can be tmpfs) and use it as a loop device?

To be honnest, I'm not sure if I addressed your comment [2]:
These tests are for the IMA-measurement aspect only, not IMA-
appraisal.  Adding measurements to the measurement list won't cause
the system to stop working, unless keys are sealed to a particular TPM
PCR value.  Nobody is or should be sealing keys to PCR-10, since the
ordering of the measurements is non deterministic.
As we add IMA-appraisal tests requiring files to be signed, things
will fail if either the public key isn't on the IMA keyring or the
file isn't properly signed.  For this reason, limiting file IMA-
appraisal tests to a particular filesystem simplifies testing.

[1] http://lists.linux.it/pipermail/ltp/2018-January/006970.html
[2] http://lists.linux.it/pipermail/ltp/2018-January/007024.html


Kind regards,
Petr


Petr Vorel (4):
  security/ima: Rewrite tests into new API + fixes
  security/ima: Run measurements after policy
  ima/ima_boot_aggregate: Increase MAX_EVENT_SIZE to 8k
  ima/tpm: Various fixes

 runtest/ima                                        |   8 +-
 testcases/kernel/security/integrity/.gitignore     |   1 -
 .../integrity/ima/src/ima_boot_aggregate.c         |   2 +-
 .../security/integrity/ima/src/ima_measure.c       | 219 -------------------
 .../integrity/ima/tests/ima_measurements.sh        | 239 +++++++++++----------
 .../security/integrity/ima/tests/ima_policy.sh     | 148 ++++++-------
 .../security/integrity/ima/tests/ima_setup.sh      | 110 ++++------
 .../kernel/security/integrity/ima/tests/ima_tpm.sh | 160 ++++++--------
 .../security/integrity/ima/tests/ima_violations.sh | 217 +++++++++----------
 9 files changed, 417 insertions(+), 687 deletions(-)
 delete mode 100644 testcases/kernel/security/integrity/ima/src/ima_measure.c
 mode change 100755 => 100644 testcases/kernel/security/integrity/ima/tests/ima_setup.sh

-- 
2.16.2

