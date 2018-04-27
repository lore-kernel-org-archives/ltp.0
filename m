From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 27 Apr 2018 08:05:05 -0400
Subject: [LTP] [RFC PATCH v3 00/10] Rewrite tests into new API + fixes
In-Reply-To: <20180427095140.y6nngyv4ldjvitc6@dell5510>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180427095140.y6nngyv4ldjvitc6@dell5510>
Message-ID: <1524830705.3416.51.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Fri, 2018-04-27 at 11:51 +0200, Petr Vorel wrote:
> Hi,
> 
> > changes v2->v3:
> > * Fixed some of errors caused by test order.
> 
> > * ima_boot_aggregate
> >   - max event size is now 1MB according to spec
> 
> > * ima_mmap
> >   - reduce sleep + log it
> >   - rewritten into new API
> 
> > * ima_measurements.sh
> >   - don't require iversion for kernel >= 4.16
> >   - avoid using tmpfs
> 
> > * ima_policy.sh
> >   - improved detection of policy writability
> >   - merge test2 and test3
> 
> > * ima_violations.sh
> >   - avoid using tmpfs
> >   - improved grepping logs (no sleep is needed)
> 
> > * ima_tpm.sh
> >   - Improve error messages
> 
> > TODO:
> > * fix problems with violations tests (see patch 02/10).
> > * detect whether policy must be signed (currently tests assume the
> > policy does not need to be signed):
> > https://lists.linux.it/pipermail/ltp/2018-April/007702.html
> > http://lists.linux.it/pipermail/ltp/2018-January/006970.html
> 
> Merged. See diff against v3, if interested.
> Thanks a lot Mimi for your comments, tips and review.

Thank you for working on this and cleaning it up!

> 
> TODO:
> 
> * detect whether policy must be signed (currently tests assume the
> policy does not need to be signed):
> https://lists.linux.it/pipermail/ltp/2018-April/007702.html
> http://lists.linux.it/pipermail/ltp/2018-January/006970.html
> 
> * ima_violations are failing on logging into /var/log/messages (without auditd):
> 
> tst_device.c:83: INFO: Found free device '/dev/loop0'
> ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/vmlinuz-4.10.0-rc6-kaiser root=/dev/mapp             er/debian--testing--vg-root ro quiet ima_policy=secure_boot
> ima_violations 1 TINFO: IMA kernel config
> ima_violations 1 TINFO: CONFIG_IMA=y
> ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
> ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=y
> ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA1=y
> ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha1"
> ima_violations 1 TINFO: CONFIG_IMA_WRITE_POLICY=y
> ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=y
> ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=y
> ima_violations 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
> ima_violations 1 TINFO: CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
> ima_violations 1 TINFO: CONFIG_IMA_BLACKLIST_KEYRING=y
> ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> ima_violations 1 TINFO: Formatting /dev/loop0 with ext3 extra opts=''
> ima_violations 1 TINFO: using log /var/log/messages
> ima_violations 1 TINFO: verify open writers violation
> ima_violations 1 TINFO: open_writers not found in /var/log/messages (1/3 attempt)...
> ima_violations 1 TINFO: open_writers not found in /var/log/messages (2/3 attempt)...
> ima_violations 1 TINFO: open_writers not found in /var/log/messages (3/3 attempt)...
> ima_violations 1 TFAIL: open_writers not found in /var/log/messages
> ima_violations 2 TINFO: verify ToMToU violation
> ima_violations 2 TINFO: ToMToU not found in /var/log/messages (1/3 attempt)...
> ima_violations 2 TINFO: ToMToU not found in /var/log/messages (2/3 attempt)...
> ima_violations 2 TINFO: ToMToU not found in /var/log/messages (3/3 attempt)...
> ima_violations 2 TFAIL: ToMToU not found in /var/log/messages
> ...
> This is due previous test ima_policy running (when there is not
> possible write to policy, e.g. second run of the testsuites on CONFIG_IMA_WRITE_POLICY=n
> it's ok)

If there isn't any policy, then these results would be expected.

> I wonder if we should just TCONF when logging into /var/log/messages with combination of
> policy being writable (or TCONF when logging into /var/log/messages in any case).
> 
> * Check whether current policy has tbc (i.e. presence of "ima_tcb" or "tcb" being part of ima_policy in
> /proc/cmdline) [1]. I wonder if we should TCONF all tests without tcb (some tests are
> working

For the case of no policy, you could still run the boot-aggregate
test.  I'm not sure about any of the other tests.

Even if the system was booted with either of the "tcb" policies, it
could still have been replaced with a custom policy.  If we're able to
cat the policy, we could verify that the loaded policy includes the
"tcb" policy and emit a TCONF warning message for non tcb policies.

For now, perhaps add a general message indicating that the tests
assume a tcb policy. 

> 
> * Getting record with old kernels (tested on both deprecated ima_tbc and ima_policy=tcb):

^ima_tcb  

> ima_measurements 1 TINFO: /proc/cmdline: BOOT_IMAGE=/vmlinuz-3.10.0-693.2.2.el7.x86_64 root=/dev/mapper/centos-root ro crashkernel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet ima_tbc
> ima_measurements 1 TINFO: IMA kernel config:
> ima_measurements 1 TINFO: CONFIG_IMA=y
> ima_measurements 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
> ima_measurements 1 TINFO: CONFIG_IMA_AUDIT=y
> ima_measurements 1 TINFO: CONFIG_IMA_LSM_RULES=y
> ima_measurements 1 TINFO: CONFIG_IMA_APPRAISE=y
> ima_measurements 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
> ima_measurements 1 TINFO: verify adding record to the IMA measurement list
> ima_measurements 1 TFAIL: cannot find measurement for '/tmp/netpan-1253/LTP_ima_measurements.P2uyOze2J4/test.txt'
> awk: cmd. line:1: (FILENAME=- FNR=1) fatal: attempt to access field -1
> ima_measurements 1 TINFO: computing hash for sha1 digest
> ima_measurements 1 TFAIL: hash not found
> ima_measurements 2 TINFO: verify updating record in the IMA measurement list
> ima_measurements 2 TCONF: XFS Filesystem >= V5 required for iversion support
> ima_measurements 3 TINFO: verify not measuring user files
> ima_measurements 3 TPASS: grep /tmp/netpan-1253/LTP_ima_measurements.P2uyOze2J4/user/test.txt /sys/kernel/security/ima/ascii_runtime_measurements failed as expected
> 
> Not sure if this is caused by different IMA behavior in old kernels or due configuration.

Maybe just a typo - ima_tcb, not ima_tbc.

Mimi

