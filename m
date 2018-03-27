From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Mar 2018 11:22:47 +0200
Subject: [LTP] [RFC PATCH v2 0/4] Rewrite tests into new API + fixes
In-Reply-To: <1522103487.3541.162.camel@linux.vnet.ibm.com>
References: <20180314155731.5943-1-pvorel@suse.cz>
 <1522103487.3541.162.camel@linux.vnet.ibm.com>
Message-ID: <20180327092247.xja3b7vzwsan2kiy@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mimi,

> Hi Petr,

> On Wed, 2018-03-14 at 16:57 +0100, Petr Vorel wrote:
> > Hi,

> > this is a second attempt to rewrite IMA tests.
> > Comments and fixes are welcome.

> > Changes v1->v2:
> > * ima_measurements.sh: add support for "ima-ng" and "ima-sig" IMA
> >   measurement templates
> > * ima_measurements.sh: add support for most of hash algorithms is
> >   defined in include/uapi/linux/hash_info.h
> > * fix ima_boot_aggregate ("ima/ima_boot_aggregate: Increase MAX_EVENT_SIZE to 8k")
> > * ima_tpm.sh: fixes of TPM test ("ima/tpm: Various fixes")
> > * ima_measurements.sh: drop ima_measure and use evmctl (external dependency) instead
> > * ima_measurements.sh: check XFS version for iversion support

> > TODO
> > * ima_measurements.sh: Add support for ima_template_fmt kernel parameter.

> > * ima_policy.sh: Detect if the policy must be signed [1] (IMA_WRITE_POLICY or
> > "secure_boot" kernel parameter).

> > @Mimi: What is a best approach in case policy must be signed? measure.policy
> > and measure.policy-invalid files are not signed should we skip all tests in
> > ima_policy.sh with something like "Not supported when policy must be signed"?
> > Or running them both and expect them to fail as they're not signed?

> > As that's how I understand your related commit in kernel
> > (19f8a84713ed "ima: measure and appraise the IMA policy itself").

> If you can determine that writing the policy should fail and then
> detect that it actually did fail, the latter option is more complete. 
I'll try.

> > BTW load_policy() use old approach catting the content into sysfs policy file.
> > Maybe it'd be good to echo policy filename into sysfs policy file for kernel >
> > 4.6 (feature added in 7429b092811f "ima: load policy using path").

> Cat'ing the file doesn't work if the policy has to be signed. I
> haven't tried writing the policy pathname, when the file doesn't
> require it to be signed.  There's no reason that it wouldn't work.
Ideal testsuite would tests all combinations, but thats impossible as that's too complex
(setting kernel variables in grub and rebooting is clearly out of LTP scope).
I might try to cover more scenarios (e.g. try to cat policy when required to be signed and
detect failure before uploading policy pathname; trying to append policy for second time
when it's not allowed).

> > * ima_measurement.sh,ima_violations.sh: Avoid using tmpfs filesystem [1]. You
> > suggested using RAM block device. Would it be ok to use filesystem created on
> > loop device (/dev/loop0)? Or even create image file in $TMPDIR (mostly
> > /tmp, which can be tmpfs) and use it as a loop device?

> Yes, creating a filesystem on a loop device should work.

> eg.
> $ dd if=/dev/zero of=/tmp/test.img count=40960
> $ mkfs -t ext3 -q /tmp/test.img
> $ sudo mount -o loop=/dev/loop0 /tmp/test.img /mnt
> $ sudo cp --preserve=xattr /usr/bin/ls /mnt/
> $ getfattr -n security.ima -e hex --dump /mnt/ls

> # file: mnt/ls
> security.ima=0x0302046e6c104601001f0e4ed440b63a16bb13e68a3ae556a311047
> 57daa51bce56f505367c00ec05bbfe38a1f7b0aa56b86ff41eba7cddaca0b7522bb46e
> 00e72b63aeb81645c2e0fdf896dfc51303917bfb4c7b360ad22a85ff4a0570b2e29059
> aba6c8ddd1db84d6cbfe6bb341549b7aa5a004acb96c4a14273ead954fb3ce3bcece04
> 680cba0c763b0d122d8f358a534cb2b786ef892d3729ff56abe10694c3bbcd35909cc1
> 046cb89553bb4636bc0493362758f24bb8cbaf5c88b16c0ecbb879ef7c4a3281cb970a
> b34634923a5c73a624528f70a03ce5fbef2845e770c536a8da1cce374381a1b176a230
> d438e9fd2f16f95c6ee16f49ba107cd57120a31f18339cfe3215a69

Thanks for a complete howto :).


> > To be honnest, I'm not sure if I addressed your comment [2]:
> > These tests are for the IMA-measurement aspect only, not IMA-
> > appraisal.  Adding measurements to the measurement list won't cause
> > the system to stop working, unless keys are sealed to a particular TPM
> > PCR value.  Nobody is or should be sealing keys to PCR-10, since the
> > ordering of the measurements is non deterministic.
> > As we add IMA-appraisal tests requiring files to be signed, things
> > will fail if either the public key isn't on the IMA keyring or the
> > file isn't properly signed.  For this reason, limiting file IMA-
> > appraisal tests to a particular filesystem simplifies testing.

> Even without adding IMA-appraisal tests, updating/cleaning up the IMA-
> measurement tests is good.
I'll merge current version (note issues in TODO in commit message) and work these issues
when time allows.
Can I add you Acked-by?

> thank you!
Thanks a lot for your comments and time.

> Mimi


Kind regards,
Petr

> > [1] http://lists.linux.it/pipermail/ltp/2018-January/006970.html
> > [2] http://lists.linux.it/pipermail/ltp/2018-January/007024.html



> > Kind regards,
> > Petr


> > Petr Vorel (4):
> >   security/ima: Rewrite tests into new API + fixes
> >   security/ima: Run measurements after policy
> >   ima/ima_boot_aggregate: Increase MAX_EVENT_SIZE to 8k
> >   ima/tpm: Various fixes

> >  runtest/ima                                        |   8 +-
> >  testcases/kernel/security/integrity/.gitignore     |   1 -
> >  .../integrity/ima/src/ima_boot_aggregate.c         |   2 +-
> >  .../security/integrity/ima/src/ima_measure.c       | 219 -------------------
> >  .../integrity/ima/tests/ima_measurements.sh        | 239 +++++++++++----------
> >  .../security/integrity/ima/tests/ima_policy.sh     | 148 ++++++-------
> >  .../security/integrity/ima/tests/ima_setup.sh      | 110 ++++------
> >  .../kernel/security/integrity/ima/tests/ima_tpm.sh | 160 ++++++--------
> >  .../security/integrity/ima/tests/ima_violations.sh | 217 +++++++++----------
> >  9 files changed, 417 insertions(+), 687 deletions(-)
> >  delete mode 100644 testcases/kernel/security/integrity/ima/src/ima_measure.c
> >  mode change 100755 => 100644 testcases/kernel/security/integrity/ima/tests/ima_setup.sh


