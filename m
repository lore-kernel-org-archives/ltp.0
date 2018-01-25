From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Thu, 25 Jan 2018 17:29:25 -0500
Subject: [LTP] [RFC PATCH 0/2] IMA: Rewrite tests into new API + fixes
In-Reply-To: <20180125203057.mzzpilp6i43xftka@dell5510>
References: <20180111202821.31639-1-pvorel@suse.cz>
 <1516815417.3686.55.camel@linux.vnet.ibm.com>
 <20180125203057.mzzpilp6i43xftka@dell5510>
Message-ID: <1516919365.6513.72.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, 2018-01-25 at 21:30 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> > Hi Petr,
> 
> > [Cc'ing Roberto]
> 
> > On Thu, 2018-01-11 at 21:28 +0100, Petr Vorel wrote:
> > > Hi,
> 
> > > I rewrote IMA tests to use new API + add small fixes.
> > > I haven't tested ima_tpm.sh as I have no TPM :-(.
> 
> > > Comments are welcomed.
> 
> > The LTP tests are quite dated, and need some major rework.  I really
> > appreciate your addressing some of the issues.  Below are some
> > additional ones.
> Thanks a lot for your comments. As you didn't report any regression in my patch-set, I'm
> for merging it as it's an improvement. But I see there is more work to be done.

Sounds good.

> Your comments or patches are always welcomed.

Thank you.

> Is there more recent version of testcases/kernel/security/integrity/ima/README [1] ?

Ok, I'll take a look.


> > Tests "ima02 ima_measurement.sh" and "ima04 ima_violations.sh" assume
> > files are created on a filesystem in policy.  The "measure.policy"
> > excludes tmpfs, yet TMPDIR defaults to a tmpfs filesystem.  There are
> > a couple of ways of resolving this problem (eg. removing tmpfs from
> > the "measure.policy", use a RAM block device instead of tmpfs, etc).
> >  Since the builtin "ima_policy=tcb" also excludes tmpfs, not using a
> > tmpfs filesystem would be preferable.

> OK, I'll try to implement test using RAM block device.

It would be nice to be able to define policies that limit testing to a
specific filesystem/device.  Without being able to limit IMA-appraisal 
testing to specific devices, things might stop working rather quickly.

> 
> > Originally IMA allowed a builtin policy to be replaced with a custom
> > policy, by simply cat'ing a file into the securityfs IMA policy file.
> > Currently, if new rules can be added to the custom policy (Kconfig
> > IMA_WRITE_POLICY enabled), the policy file must be signed.  Similarly,
> > if the builtin "secure-boot" policy is defined on the boot command
> > line, the custom policy must be signed.  Test "ima01 ima_policy.sh"
> > should first detect if the policy must be signed, before running the
> > tests.

> Right, I'll check it. Is there other way how to detect it than reading
> /boot/config-$(uname -r) or /proc/config.gz ? I'm asking because IMA might be using on
> embedded devices (guessing from [2], [3]), which might not have either of them.

Until the IMA-measurement list supports TPM 2.0 hash agility, the
template name defines the old ("ima") vs. new formats.  The builtin
new template formats are "ima-ng" and "ima-sig", but custom formats
can be defined (eg. ima_template_fmt="d-ng|n-ng|sig") on the boot
command line.  "d-ng|n-ng|sig" is the definition for ima-sig.

> > ima_boot_aggregate.c defines the BIOS MAX_EVENT_SIZE BIOS size as 500,
> > but I'm currently seeing BIOS events larger than 4k.
> So, what is the recommended size?

> Any reference to it?

According to Kenneth Goldman, the maximum BIOS event entry for TPM 1.2
is undefined.  For TPM 2.0 this was corrected.  The spec says, "For
software parsing the event log, the parser can choose an arbitrary
maximum size, but this specification recommends a maximum value for
the TCG_PCR_EVENT2.eventSize field of 1MB."

I think the BIOS event log is currently only exported via sysfs for
TPM 1.2.


> > Since these tests were first written, Roberto's IMA templates and
> > Dmitry's support for larger digests were upstreamed.  With the new
> > template format, the file hash is prefixed with the hash algorithm.
> >  Before comparing the calculated boot aggregate with the value in the
> > IMA measurement list, the hash algorithm needs to be removed.

> Do you mean entries in /sys/kernel/security/ima/ascii_runtime_measurements ?
> system with config CONFIG_IMA_DEFAULT_HASH_SHA256=y
> 10 4814642f7955ad7a9c7b47785d002374b34902fd ima-ng sha256:f20cec9d158c4c453899f97595c40257c2518a40a310a550a1cd26a63e7fff7a /usr/lib64/libsha1detectcoll.so.1.0.0
> system with config CONFIG_IMA_DEFAULT_HASH_SHA1=y
> 10 2990cfe74ff309268e4fb928102574c28f9bb876 ima-ng sha1:71b543ad6af36b0976d0e3f71fed4ce0954eda0c /var/log/messages

Exactly.  The following code snippet strips off the hash algorithm,
before doing the hash comparison.  I'm sure there are better ways of
doing it.

+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -39,7 +39,7 @@ test1()
 
        # IMA boot aggregate
        read line < $ima_measurements
-       ima_aggr=$(expr substr "${line}" 49 40)
+       ima_aggr=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)


> As it's done with grep it shouldn't be needed:
> grep -q '^CONFIG_IMA_DEFAULT_HASH_SHA256=y' /boot/config-$(uname -r) && \
> 		HASH_COMMAND="sha256sum"
> 
> I kept sha1sum as the default command for checking and I'm detecting with
> CONFIG_IMA_DEFAULT_HASH_SHA256 whether to use sha256:
> This is not enough, I'll add checks for CONFIG_IMA_DEFAULT_HASH_SHA512 and
> CONFIG_IMA_DEFAULT_HASH_WP512.

The list of supported hash algorithms is defined in
include/uapi/linux/hash_info.h.

The first entry, the boot aggregate, is always sha1.  The rest of the
measurements will be the same hash algorithm, either as Kconfig
defined or as specified on the boot command line "ima_hash=" option,
per boot. 

With the support for carrying the IMA-measurement list across kexec,
the measurement list might contain entries with different hash
algorithms.

> >  
> > For the new template format measurement lists, walking the measurement
> > list, re-calculating the PCRs and comparing them with the HW or vTPM
> > PCRs fail.  The ima-evm-utils package has a working version.  Invoke
> > "evmctl" with the "ima_measurement" option.
> So you mean that src/ima_measure.c is broken and should be replaced by evmctl from your
> repository on sf.net [4]? Fortunately this package is on all major distros [5] (except
> Debian, but Ubuntu package is installable on Debian), so we don't need to include your
> repository as submodule.

Fantastic!  So we'll concentrate on extending ima-evm-utils.

thanks,

Mimi

