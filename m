From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 19 Jun 2020 09:01:51 -0400
Subject: [LTP] [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot
 aggregate
In-Reply-To: <20200619100737.GB18704@dell5510>
References: <20200527071434.28574-1-pvorel@suse.cz>
 <1590601280.16219.1.camel@linux.ibm.com> <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com> <20200528160527.GA27243@dell5510>
 <20200615194134.GF129694@glitch> <1592252491.11061.181.camel@linux.ibm.com>
 <20200619100737.GB18704@dell5510>
Message-ID: <1592571711.17802.21.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 2020-06-19 at 12:07 +0200, Petr Vorel wrote:
> Hi all,
> 
> > On Mon, 2020-06-15 at 16:41 -0300, Bruno Meneguele wrote:
> > > On Thu, May 28, 2020 at 06:05:27PM +0200, Petr Vorel wrote:
> > > > Hi Mimi,
> ...
> > > > To sum that: my patch is required for any system without physical TPM with with
> > > > kernel with b59fda449cf0 + it also works for TPM 1.2 (regardless kernel
> > > > version), because TPM 1.2 supports sha1 only boot aggregate.
> 
> > > > But testing on kernel with b59fda449cf0 with TPM 2.0 is not only broken with
> > > > this patch, but also on current version in master, right? As you have
> > > > sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5 anyway.
> > > > So this patch would help at least testing on VM without vTPM.
> 
> 
> > > If we consider to delay this change until we have the ima-evm-utils
> > > released with the ima_boot_aggregate + make this test dependent on
> > > both ima-evm-utils and tsspcrread, would it be worth to SKIP the test in
> > > case a TPM2.0 sha256 bank is detected instead of FAIL? Thus we could
> > > have the test fixed for TPM1.2 && no-TPM cases until we get the full
> > > support for multiple banks?
> +1
> 
> > As long as we're dealing with the "boot_aggregate", Maurizio just
> > posted a kernel patch for including PCR 8 & 9 in the boot_aggregate.
> > ?The existing IMA LTP "boot_aggregate" test is going to need to
> > support this change.
> I'm not sure if I did something wrong, but it looks to me that 'evmctl
> ima_boot_aggregate' does not provide backward compatibility with TPM 1.2.
> Or am I wrong?

Calculating the "boot_aggregate" - "evmctl ima_boot_aggregate" - for
TPM 1.2 should work. ?Reading the code, it looks like it assumes that
the crypto library supports SHA1 and SHA256. ?That assumption needs to
be addressed.

The tests/boot_aggregate.test logs are TPM 2.0. ?The test is failing
on systems with a TPM 1.2. ?I'm working on a fix for this.

Mimi
