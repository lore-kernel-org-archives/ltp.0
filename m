From: Javier Martinez Canillas <javierm@redhat.com>
Date: Mon, 5 Feb 2018 14:34:49 +0100
Subject: [LTP] Hidden TPM questions in the LTP IMA posts
In-Reply-To: <1517820147.7570.4.camel@linux.intel.com>
References: <1516978199.29187.43.camel@linux.vnet.ibm.com>
 <20180131133241.rbxy252l6p5rqlh2@linux.intel.com>
 <1517416161.3469.142.camel@linux.vnet.ibm.com>
 <1517820147.7570.4.camel@linux.intel.com>
Message-ID: <3279a223-a638-a21d-aa24-1879cf20df4c@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

Sorry for the long email. But I also had issues understanding the TPM
Event Log from the spec in the past, so I wanted to share my notes in
case someone finds them useful.

On 02/05/2018 09:42 AM, Jarkko Sakkinen wrote:
> On Wed, 2018-01-31 at 11:29 -0500, Mimi Zohar wrote:
>> On Wed, 2018-01-31 at 15:32 +0200, Jarkko Sakkinen wrote:
>>> Hi
>>>
>>> On Fri, Jan 26, 2018 at 09:49:59AM -0500, Mimi Zohar wrote:
>>>> Hi Jarkko,
>>>>
>>>> There are a few TPM questions for the fixing the IMA Linux Test
>>>> Program (LTP) tests:
>>>>
>>>> - The maximum size of the TPM 1.2 event record is unspecified.  What
>>>> is the expected maximum size?

Do you mean for a single record or for the complete PCR measurement logs?

In any case, event records have a dynamic size because they also contain
the data that was measured. The EventSize is an u32 so I think is useful
to know the event data size but not to be used as a maximum size.

The kernel does know the event log sizes though, so if that information is
useful for tests, I guess it could be exported to user-space (i.e: sysfs)?

>>>> - Is there a way of knowing the location of the TPM 1.2 PCRs without
>>>> grepping for them?
>>
>> I responded (in the original thread) to my own question:
>>
>> Commit 313d21e "tpm: device class for tpm" moved the TPM sysfs
>> location from /sys/class/misc/tpmX/device/ to
>> /sys/class/tpm/tpmX/device/.
> 
> I was wondering what you meant by "location". That was the reason why I
> postponed my response in the first place. I did not understand that you
> were talking about the sysfs path. The only location I know for PCRs is
> that they are inside the TPM.
> 
> For the first question, I don't think there is a hard coded limit but I
> could be wrong. In the area of event log I think the TCG documentation
> is just utter shit.
> 
> There is some documentation in EFI platform and protocol specifications
> but it quite lacking.
> 
> It is awkward that this stuff is in EFI specifications in the first
> place when with TPM 1.2 you access the log through ACPI and on some
> platforms the event log is available through DT. It is hard to find
> answers even to simple questions like what is put into the event log,
> which is a very basic question that I do not have to day a definitive
> answer.
> 

I agree that the documentation isn't great when it comes to the Eveng Log.

This is my understanding (please correct me if I got something wrong), for
TPM 1.2 the Event Log is stored on an ACPI table with signature 'TCPA' in
the field LASA (Log Area Start Address) that "contains the 64-bit physical
address of the start of the system's pre-boot TCG event log area".

The size of the log area can be found in the field LAML (Log Area Minimum
Length), so log area ranges from address LASA to LASA + (LAML - 1). Why it
is called minimum length instead of just length I honestly don't know.

The log area is an array of logs in the EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2
log format version. In the kernel this is (include/linux/tpm_eventlog.h):

struct tcpa_event {
	u32 pcr_index;
	u32 event_type;
	u8 pcr_value[20];	/* SHA1 */
	u32 event_size;
	u8 event_data[0];
};

This log format is also referred in the spec doc as TPM 1.2 (SHA1) format.

For TPM 2.0 is more complicated, as you said the spec didn't mention that
the logs could be taken from an ACPI table, and instead the EFI spec says
that could be taken from an EFI configuration table with GUID TPMEventLog.

In this case there isn't a log area size field but instead the addresses
of the start of the event log (EventLogLocation) and start of the last
entry (EventLogLastEntry) are provided. So the log area size in this case
is EventLogLastEntry - EventLogLocation + LastEntrySize.

The event log format for TPM 2.0 is EFI_TCG2_EVENT_LOG_FORMAT_TCG_2, that
is also called TPM 2.0 (crypto agile) format in the spec. But not all TPM
2.0 may support that format, and some still use the TPM 1.2 (SHA1) format.

So there's an EFI GetCapability() service to query the SupportedEventLogs
on a particular TPM 2.0 device.

Support for reading from EFI is what landed for this release, but only the
TPM 1.2 (SHA1) format is supported, there's still not support for TPM 2.0
(crypto agile). You can see that in drivers/firmware/efi/libstub/tpm.c:

void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
{
...
	status = efi_call_proto(efi_tcg2_protocol, get_event_log, tcg2_protocol,
				EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2,
				&log_location, &log_last_entry, &truncated);
...
}

void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table_arg)
{
	/* Only try to retrieve the logs in 1.2 format. */
	efi_retrieve_tpm2_eventlog_1_2(sys_table_arg);
}

But all the bits for TPM 2.0 (crypto agile) support seems to already be in
drivers/char/tpm/tpm2_eventlog.c, are only missing in the EFI stub AFAICT.

The crypto agile log format is also defined in include/linux/tpm_eventlog.h:

struct tcg_event_field {
        u32 event_size;
        u8 event[0];
} __packed;

struct tpm2_digest {
        u16 alg_id;
        u8 digest[SHA512_DIGEST_SIZE];
} __packed;

struct tcg_pcr_event2 {
        u32 pcr_idx;
        u32 event_type;
        u32 count;
        struct tpm2_digest digests[TPM2_ACTIVE_PCR_BANKS];
        struct tcg_event_field event;
} __packed;

The data structures for both log formats are listed in the TCG PC Client
Platform Firmware Profile Specification [0], in section 9 "Event Logging".

Now, on latest TCG ACPI Specification (Revision 8, August 18, 2017) [1],
the spec does mention that the ACPI table with signature 'TPM2' can have
the LASA and LAML as optional fields. This is mentioned in section 7.3
"ACPI Table for TPM 2.0".

In this case the event logs can be taken from ACPI and there's no need to
get them from the EFI config table (or are mutually exclusive? can't tell).

It's not clear to me though when/why the firmware should use either option
and how the kernel could know from where it should take the TPM event logs.

We don't have support for this option yet, but some patches were posted a
long time ago [2] by Petr Vandrovec when that version was still a draft.

[0]: https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientSpecific_Platform_Profile_for_TPM_2p0_Systems_v51.pdf
[1]: https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf
[2]: https://patchwork.kernel.org/project/tpmdd-devel/list/?submitter=7143

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
