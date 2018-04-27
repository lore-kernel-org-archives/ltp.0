From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Apr 2018 14:51:52 +0200
Subject: [LTP] [RFC PATCH v3 00/10] Rewrite tests into new API + fixes
In-Reply-To: <1524830705.3416.51.camel@linux.vnet.ibm.com>
References: <20180419195503.7194-1-pvorel@suse.cz>
 <20180427095140.y6nngyv4ldjvitc6@dell5510>
 <1524830705.3416.51.camel@linux.vnet.ibm.com>
Message-ID: <20180427125152.fbt2bvrtjrzhd2es@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mimi,

> > * ima_violations are failing on logging into /var/log/messages (without auditd):

> > tst_device.c:83: INFO: Found free device '/dev/loop0'
> > ima_violations 1 TINFO: /proc/cmdline: BOOT_IMAGE=/vmlinuz-4.10.0-rc6-kaiser root=/dev/mapp             er/debian--testing--vg-root ro quiet ima_policy=secure_boot
> > ima_violations 1 TINFO: IMA kernel config
> > ima_violations 1 TINFO: CONFIG_IMA=y
> > ima_violations 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
> > ima_violations 1 TINFO: CONFIG_IMA_LSM_RULES=y
> > ima_violations 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
> > ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> > ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA1=y
> > ima_violations 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha1"
> > ima_violations 1 TINFO: CONFIG_IMA_WRITE_POLICY=y
> > ima_violations 1 TINFO: CONFIG_IMA_READ_POLICY=y
> > ima_violations 1 TINFO: CONFIG_IMA_APPRAISE=y
> > ima_violations 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
> > ima_violations 1 TINFO: CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
> > ima_violations 1 TINFO: CONFIG_IMA_BLACKLIST_KEYRING=y
> > ima_violations 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> > ima_violations 1 TINFO: Formatting /dev/loop0 with ext3 extra opts=''
> > ima_violations 1 TINFO: using log /var/log/messages
> > ima_violations 1 TINFO: verify open writers violation
> > ima_violations 1 TINFO: open_writers not found in /var/log/messages (1/3 attempt)...
> > ima_violations 1 TINFO: open_writers not found in /var/log/messages (2/3 attempt)...
> > ima_violations 1 TINFO: open_writers not found in /var/log/messages (3/3 attempt)...
> > ima_violations 1 TFAIL: open_writers not found in /var/log/messages
> > ima_violations 2 TINFO: verify ToMToU violation
> > ima_violations 2 TINFO: ToMToU not found in /var/log/messages (1/3 attempt)...
> > ima_violations 2 TINFO: ToMToU not found in /var/log/messages (2/3 attempt)...
> > ima_violations 2 TINFO: ToMToU not found in /var/log/messages (3/3 attempt)...
> > ima_violations 2 TFAIL: ToMToU not found in /var/log/messages
> > ...
> > This is due previous test ima_policy running (when there is not
> > possible write to policy, e.g. second run of the testsuites on CONFIG_IMA_WRITE_POLICY=n
> > it's ok)

> If there isn't any policy, then these results would be expected.
No, ima_violations with /var/log/messages are failing even with tcb policy loaded (on kernels >= 4.x).

> > I wonder if we should just TCONF when logging into /var/log/messages with combination of
> > policy being writable (or TCONF when logging into /var/log/messages in any case).

> > * Check whether current policy has tbc (i.e. presence of "ima_tcb" or "tcb" being part of ima_policy in
> > /proc/cmdline) [1]. I wonder if we should TCONF all tests without tcb (some tests are
> > working

> For the case of no policy, you could still run the boot-aggregate
> test.  I'm not sure about any of the other tests.
I'll check which ones are working and not issue TCONF for them.

> Even if the system was booted with either of the "tcb" policies, it
> could still have been replaced with a custom policy.  If we're able to
> cat the policy, we could verify that the loaded policy includes the
> "tcb" policy and emit a TCONF warning message for non tcb policies.
I understand you as checking /sys/kernel/security/ima/policy (assumes
CONFIG_IMA_READ_POLICY) to have content defined in kernel ima_rule_entry
default_measurement_rules[] (from ima_policy.c from kernel).

> For now, perhaps add a general message indicating that the tests
> assume a tcb policy. 
Make sense, I'll add it now.


> > * Getting record with old kernels (tested on both deprecated ima_tbc and ima_policy=tcb):

> ^ima_tcb  

> > ima_measurements 1 TINFO: /proc/cmdline: BOOT_IMAGE=/vmlinuz-3.10.0-693.2.2.el7.x86_64 root=/dev/mapper/centos-root ro crashkernel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet ima_tbc
> > ima_measurements 1 TINFO: IMA kernel config:
> > ima_measurements 1 TINFO: CONFIG_IMA=y
> > ima_measurements 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
> > ima_measurements 1 TINFO: CONFIG_IMA_AUDIT=y
> > ima_measurements 1 TINFO: CONFIG_IMA_LSM_RULES=y
> > ima_measurements 1 TINFO: CONFIG_IMA_APPRAISE=y
> > ima_measurements 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
> > ima_measurements 1 TINFO: verify adding record to the IMA measurement list
> > ima_measurements 1 TFAIL: cannot find measurement for '/tmp/netpan-1253/LTP_ima_measurements.P2uyOze2J4/test.txt'
> > awk: cmd. line:1: (FILENAME=- FNR=1) fatal: attempt to access field -1
> > ima_measurements 1 TINFO: computing hash for sha1 digest
> > ima_measurements 1 TFAIL: hash not found
> > ima_measurements 2 TINFO: verify updating record in the IMA measurement list
> > ima_measurements 2 TCONF: XFS Filesystem >= V5 required for iversion support
> > ima_measurements 3 TINFO: verify not measuring user files
> > ima_measurements 3 TPASS: grep /tmp/netpan-1253/LTP_ima_measurements.P2uyOze2J4/user/test.txt /sys/kernel/security/ima/ascii_runtime_measurements failed as expected

> > Not sure if this is caused by different IMA behavior in old kernels or due configuration.

> Maybe just a typo - ima_tcb, not ima_tbc.
Yes, that was the reason (silly mistake). On older kernels 3.x only ima_tbc (I'll check
kernel versions and let user to know correct variable in TCONF).

> Mimi

