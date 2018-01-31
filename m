From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Wed, 31 Jan 2018 20:31:45 +0530
Subject: [LTP] [RFC PATCH 0/2] IMA: Rewrite tests into new API + fixes
In-Reply-To: <20180126175110.boaepz6dqe3uojq6@dell5510>
References: <20180111202821.31639-1-pvorel@suse.cz>
 <1516815417.3686.55.camel@linux.vnet.ibm.com>
 <20180125203057.mzzpilp6i43xftka@dell5510>
 <1516919365.6513.72.camel@linux.vnet.ibm.com>
 <20180126175110.boaepz6dqe3uojq6@dell5510>
Message-ID: <e43e61d6-72a0-f7cd-fd7a-e1f3cf7acc54@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



On 01/26/2018 11:21 PM, Petr Vorel wrote:
>
>> Until the IMA-measurement list supports TPM 2.0 hash agility, the
>> template name defines the old ("ima") vs. new formats.  The builtin
>> new template formats are "ima-ng" and "ima-sig", but custom formats
>> can be defined (eg. ima_template_fmt="d-ng|n-ng|sig") on the boot
>> command line.  "d-ng|n-ng|sig" is the definition for ima-sig.
> OK, we cannot rely on the default format. I'll fix it :-).
>
>>>> ima_boot_aggregate.c defines the BIOS MAX_EVENT_SIZE BIOS size as 500,
>>>> but I'm currently seeing BIOS events larger than 4k.
>>> So, what is the recommended size?
>>> Any reference to it?
>> According to Kenneth Goldman, the maximum BIOS event entry for TPM 1.2
>> is undefined.  For TPM 2.0 this was corrected.  The spec says, "For
>> software parsing the event log, the parser can choose an arbitrary
>> maximum size, but this specification recommends a maximum value for
>> the TCG_PCR_EVENT2.eventSize field of 1MB."
> Great, thanks for info. Just for a record links to the specification [1].
>
>> I think the BIOS event log is currently only exported via sysfs for
>> TPM 1.2.
> This commit 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event log")
> adds security [1]. And indeed structs tcg_pcr_event and tcg_pcr_event2 defined
> in [2] on pages 15 and 16 were added in this commit and used in TPM 2.0 related
> functions calc_tpm2_event_size(), tpm2_bios_measurements_start() and
> tpm2_bios_measurements_next().

Unlike TPM 1.2, TPM 2.0 support for firmware event log exports only 
binary_bios_measurements to securityfs. The binary file can be parsed to 
generate the ascii format.

The initial commit added support to retrieve the TPM 2.0 event log for 
device tree based platforms. Similar support for EFI is being upstreamed 
in this open window for Linux 4.16(https://lkml.org/lkml/2018/1/8/199)

Thanks & Regards,
     - Nayna


>
>>>> Since these tests were first written, Roberto's IMA templates and
>>>> Dmitry's support for larger digests were upstreamed.  With the new
>>>> template format, the file hash is prefixed with the hash algorithm.
>>>>   Before comparing the calculated boot aggregate with the value in the
>>>> IMA measurement list, the hash algorithm needs to be removed.
>>> Do you mean entries in /sys/kernel/security/ima/ascii_runtime_measurements ?
>>> system with config CONFIG_IMA_DEFAULT_HASH_SHA256=y
>>> 10 4814642f7955ad7a9c7b47785d002374b34902fd ima-ng sha256:f20cec9d158c4c453899f97595c40257c2518a40a310a550a1cd26a63e7fff7a /usr/lib64/libsha1detectcoll.so.1.0.0
>>> system with config CONFIG_IMA_DEFAULT_HASH_SHA1=y
>>> 10 2990cfe74ff309268e4fb928102574c28f9bb876 ima-ng sha1:71b543ad6af36b0976d0e3f71fed4ce0954eda0c /var/log/messages
>> Exactly.  The following code snippet strips off the hash algorithm,
>> before doing the hash comparison.  I'm sure there are better ways of
>> doing it.
>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
>> @@ -39,7 +39,7 @@ test1()
>>          # IMA boot aggregate
>>          read line < $ima_measurements
>> -       ima_aggr=$(expr substr "${line}" 49 40)
>> +       ima_aggr=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)
>
>>> As it's done with grep it shouldn't be needed:
>>> grep -q '^CONFIG_IMA_DEFAULT_HASH_SHA256=y' /boot/config-$(uname -r) && \
>>> 		HASH_COMMAND="sha256sum"
>>> I kept sha1sum as the default command for checking and I'm detecting with
>>> CONFIG_IMA_DEFAULT_HASH_SHA256 whether to use sha256:
>>> This is not enough, I'll add checks for CONFIG_IMA_DEFAULT_HASH_SHA512 and
>>> CONFIG_IMA_DEFAULT_HASH_WP512.
>> The list of supported hash algorithms is defined in
>> include/uapi/linux/hash_info.h.
> I see. And constants I take into account are values for ima template.
>
>> The first entry, the boot aggregate, is always sha1.  The rest of the
>> measurements will be the same hash algorithm, either as Kconfig
>> defined or as specified on the boot command line "ima_hash=" option,
>> per boot.
>> With the support for carrying the IMA-measurement list across kexec,
>> the measurement list might contain entries with different hash
>> algorithms.
> OK, I'll detect correct hash algorithm and check it.
>
>>>>   
>>>> For the new template format measurement lists, walking the measurement
>>>> list, re-calculating the PCRs and comparing them with the HW or vTPM
>>>> PCRs fail.  The ima-evm-utils package has a working version.  Invoke
>>>> "evmctl" with the "ima_measurement" option.
>>> So you mean that src/ima_measure.c is broken and should be replaced by evmctl from your
>>> repository on sf.net [4]? Fortunately this package is on all major distros [5] (except
>>> Debian, but Ubuntu package is installable on Debian), so we don't need to include your
>>> repository as submodule.
>> Fantastic!  So we'll concentrate on extending ima-evm-utils.
> There might be problem in old distros, where users will have to compile it themselves.
> It'd be more comfortable for users to have all the source codes in LTP tree, so if they
> report problems to us we might copy your source to LTP git or use it as submodule. But
> I'll try to avoid it.
>
>> thanks,
> Thanks a lot for your help!
>
>> Mimi
>
> Kind regards,
> Petr
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.15-rc9&id=4d23cc323cdbee1cbcd8a7f059fff9ef2b0c473d
> [2] https://www.trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specification-rev9-150513_Public-Review.pdf
>

