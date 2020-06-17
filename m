From: Maurizio Drocco <mdrocco@linux.vnet.ibm.com>
Date: Wed, 17 Jun 2020 18:19:05 -0400
Subject: [LTP] [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot
 aggregate
In-Reply-To: <20200617204500.GB40831@glitch>
References: <20200527071434.28574-1-pvorel@suse.cz>
 <1590601280.16219.1.camel@linux.ibm.com> <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com> <20200528160527.GA27243@dell5510>
 <20200615194134.GF129694@glitch> <1592252491.11061.181.camel@linux.ibm.com>
 <20200617012148.hhpvxqov2py7fvvc@cantor> <20200617204500.GB40831@glitch>
Message-ID: <8b9bfe78-86ce-77aa-c84e-821ea69b4c86@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


On 6/17/2020 4:45 PM, Bruno Meneguele wrote:
> On Tue, Jun 16, 2020 at 06:21:48PM -0700, Jerry Snitselaar wrote:
>> On Mon Jun 15 20, Mimi Zohar wrote:
>>> On Mon, 2020-06-15 at 16:41 -0300, Bruno Meneguele wrote:
>>>> On Thu, May 28, 2020 at 06:05:27PM +0200, Petr Vorel wrote:
>>>>> Hi Mimi,
>>>>> ...
>>>>>>>> With just this change, the ima_tpm.sh test is failing. ?I assume it is
>>>>>>>> failing because it is reading the SHA1 TPM bank, not the SHA256 bank
>>>>>>>> to calculate the boot_aggregate hash.
>>>>>>> First question: is it correct to take sha256? Because on my test below it's
>>>>>>> reading sha1, because that's the content of /sys/kernel/security/ima/ascii_runtime_measurements
>>>>>>> I thought just kernel commit: 6f1a1d103b48 ima: ("Switch to ima_hash_algo for
>>>>>>> boot aggregate") from current linux-integrity tree is needed, but I tested it on
>>>>>>> b59fda449cf0 ("ima: Set again build_ima_appraise variable") (i.e. having all
>>>>>>> Robeto's ima patches,  missing just last 2 commits from next-integrity head).
>>>>>>> What is needed to get your setup?
>>>>>> This isn't a configuration problem, but an issue of reading PCRs and
>>>>>> calculating the TPM bank appropriate boot_aggregate. ?If you're
>>>>>> calculating a sha256 boot_aggregate, then the test needs to read and
>>>>>> calculate the boot_aggregate by reading the SHA256 TPM bank.
>>>>> OK, I tested it on TPM 1.2 (no TPM 2.0 available atm).
>>>>> I guess you have TPM 2.0, that's why I didn't spot this issue.
>>>>>
>>>>> To sum that: my patch is required for any system without physical TPM with with
>>>>> kernel with b59fda449cf0 + it also works for TPM 1.2 (regardless kernel
>>>>> version), because TPM 1.2 supports sha1 only boot aggregate.
>>>>>
>>>>> But testing on kernel with b59fda449cf0 with TPM 2.0 is not only broken with
>>>>> this patch, but also on current version in master, right? As you have
>>>>> sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5 anyway.
>>>>> So this patch would help at least testing on VM without vTPM.
>>>>>
>>>> If we consider to delay this change until we have the ima-evm-utils
>>>> released with the ima_boot_aggregate + make this test dependent on
>>>> both ima-evm-utils and tsspcrread, would it be worth to SKIP the test in
>>>> case a TPM2.0 sha256 bank is detected instead of FAIL? Thus we could
>>>> have the test fixed for TPM1.2 && no-TPM cases until we get the full
>>>> support for multiple banks?
>>> As long as we're dealing with the "boot_aggregate", Maurizio just
>>> posted a kernel patch for including PCR 8 & 9 in the boot_aggregate.
>>>  ?The existing IMA LTP "boot_aggregate" test is going to need to
>>> support this change.
>>>
>>> I'd appreciate if someone could send me a TPM event log, the PCRs, and
>>> the associated IMA ascii_runtime_measurements "boot_aggregate" from a
>>> system with a discrete TPM 2.0 with PCRs 8 & 9 events.
>>>
> Maybe Maurizio already have it at hand?
> I can try to setup a system with grub2+tpm to get the log with pcr 8 and
> 9 filled.

Hi Bruno, I confirm I have a couple of systems on where 8 & 9 and the 
IMA list are filled at boot (already shared with Mimi), now I am 
figuring out how to produce TPM event logs as well.

