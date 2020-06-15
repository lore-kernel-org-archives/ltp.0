From: Bruno Meneguele <bmeneg@redhat.com>
Date: Mon, 15 Jun 2020 16:41:34 -0300
Subject: [LTP] [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot
 aggregate
In-Reply-To: <20200528160527.GA27243@dell5510>
References: <20200527071434.28574-1-pvorel@suse.cz>
 <1590601280.16219.1.camel@linux.ibm.com>
 <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com>
 <20200528160527.GA27243@dell5510>
Message-ID: <20200615194134.GF129694@glitch>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 28, 2020 at 06:05:27PM +0200, Petr Vorel wrote:
> Hi Mimi,
> ...
> > > > With just this change, the ima_tpm.sh test is failing. ?I assume it is
> > > > failing because it is reading the SHA1 TPM bank, not the SHA256 bank
> > > > to calculate the boot_aggregate hash.
> > > First question: is it correct to take sha256? Because on my test below it's
> > > reading sha1, because that's the content of /sys/kernel/security/ima/ascii_runtime_measurements
> 
> > > I thought just kernel commit: 6f1a1d103b48 ima: ("Switch to ima_hash_algo for
> > > boot aggregate") from current linux-integrity tree is needed, but I tested it on
> > > b59fda449cf0 ("ima: Set again build_ima_appraise variable") (i.e. having all
> > > Robeto's ima patches,  missing just last 2 commits from next-integrity head).
> > > What is needed to get your setup?
> 
> > This isn't a configuration problem, but an issue of reading PCRs and
> > calculating the TPM bank appropriate boot_aggregate. ?If you're
> > calculating a sha256 boot_aggregate, then the test needs to read and
> > calculate the boot_aggregate by reading the SHA256 TPM bank.
> OK, I tested it on TPM 1.2 (no TPM 2.0 available atm).
> I guess you have TPM 2.0, that's why I didn't spot this issue.
> 
> To sum that: my patch is required for any system without physical TPM with with
> kernel with b59fda449cf0 + it also works for TPM 1.2 (regardless kernel
> version), because TPM 1.2 supports sha1 only boot aggregate.
> 
> But testing on kernel with b59fda449cf0 with TPM 2.0 is not only broken with
> this patch, but also on current version in master, right? As you have
> sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5 anyway.
> So this patch would help at least testing on VM without vTPM.
> 

If we consider to delay this change until we have the ima-evm-utils
released with the ima_boot_aggregate + make this test dependent on
both ima-evm-utils and tsspcrread, would it be worth to SKIP the test in
case a TPM2.0 sha256 bank is detected instead of FAIL? Thus we could
have the test fixed for TPM1.2 && no-TPM cases until we get the full
support for multiple banks?

> ...
> > > > The ima-evm-utils next-testing branch has code to calculate the
> > > > boot_aggregate based on multiple banks.
> > > I see, 696bf0b ("ima-evm-utils: calculate the digests for multiple TPM banks")
> > > I wonder whether it's reasonable trying to port that to ima_boot_aggregate.c or
> > > just depend on evmctl. External dependencies are sometimes complicated, but for
> > > IMA I incline to just require evmctl.
> 
> > Unlike TPM 1.2, the TPM 2.0 device driver doesn't export the TPM PCRs.
> > ?Not only would you have a dependency on ima-evm-utils, but also on a
> > userspace application(s) for reading the TPM PCRs. ?That dependency
> > exists whether you're using evmctl to calculate the boot_aggregate or
> > doing it yourself.
> Hm, things get complicated.
> Yep I remember your patch to skip verifying TPM 2.0 PCR values
> https://patchwork.ozlabs.org/project/ltp/patch/1558041162.3971.2.camel@linux.ibm.com/
> At least thanks to Jerry Snitselaar since v5.6 we have
> /sys/class/tpm/tpm*/tpm_version_major. We could check this (+ try also
> /sys/class/tpm/tpm0/device/description for older kernels).
> 
> BTW on my system there is also /sys/class/tpm/tpm0/ppi/version, which has 1.2,
> not sure if it indicate TPM 1.2, but I wouldn't rely on that.
> 

IIUC 'tpm_version_major' should be the only safe reference of the actual
TCG spec version being implemented by the hw TPM, in a sysfs standard
output.

> ...
> > > > There's also a new test to verify the boot_aggregate.
> 
> > > > $ VERBOSE=1 make check TESTS=boog_aggregate.test
> > > BTW I got some errors
> > > ...
> > > make  check-TESTS
> > > make[2]: Entering directory '/home/foo/ima-evm-utils/tests'
> > > make[3]: Entering directory '/home/foo/ima-evm-utils/tests'
> > > make[4]: Entering directory '/home/foo/ima-evm-utils/tests'
> > > make[4]: Nothing to be done for 'boog_aggregate.log'.
> > > make[4]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > fatal: making test-suite.log: failed to create boog_aggregate.trs
> > > fatal: making test-suite.log: failed to create boog_aggregate.log
> > > make[3]: *** [Makefile:516: test-suite.log] Error 1
> > > make[3]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > make[2]: *** [Makefile:625: check-TESTS] Error 2
> > > make[2]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > make[1]: *** [Makefile:692: check-am] Error 2
> > > make[1]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > make: *** [Makefile:514: check-recursive] Error 1
> 
> > [Cc'ing Vitaly]
> 
> > The boot_aggregate.trs and boot_aggregate.log files are being created
> > in the tests/ directory. ?Is that directory read-only?
> Yes, drwxr-xr-x. Testing on fresh clone and issue persists.
> 

Yes, same thing here.. but didn't really check the reason for that. Will
take a time later to see what's happening.

> > > > Both need some review and testing before being released.
> > > Any estimation when code is released?
> 
> > Probably not before the next open window, but definitely before it is
> > released.
> Thanks for info.
> 

-- 
bmeneg 
PGP Key: http://bmeneg.com/pubkey.txt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200615/c866967e/attachment-0001.sig>
