From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Jun 2020 10:21:34 +0200
Subject: [LTP] [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot
 aggregate
In-Reply-To: <20200617204500.GB40831@glitch>
References: <20200527071434.28574-1-pvorel@suse.cz>
 <1590601280.16219.1.camel@linux.ibm.com>
 <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com>
 <20200528160527.GA27243@dell5510> <20200615194134.GF129694@glitch>
 <1592252491.11061.181.camel@linux.ibm.com>
 <20200617012148.hhpvxqov2py7fvvc@cantor>
 <20200617204500.GB40831@glitch>
Message-ID: <20200619082134.GB23036@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

...
> > > I'd appreciate if someone could send me a TPM event log, the PCRs, and
> > > the associated IMA ascii_runtime_measurements "boot_aggregate" from a
> > > system with a discrete TPM 2.0 with PCRs 8 & 9 events.


> Maybe Maurizio already have it at hand?
I'd appreciate to have these files as well.

> I can try to setup a system with grub2+tpm to get the log with pcr 8 and
> 9 filled.


> > > > > ...
> > > > > > > > The ima-evm-utils next-testing branch has code to calculate the
> > > > > > > > boot_aggregate based on multiple banks.
> > > > > > > I see, 696bf0b ("ima-evm-utils: calculate the digests for multiple TPM banks")
> > > > > > > I wonder whether it's reasonable trying to port that to ima_boot_aggregate.c or
> > > > > > > just depend on evmctl. External dependencies are sometimes complicated, but for
> > > > > > > IMA I incline to just require evmctl.

> > > > > > Unlike TPM 1.2, the TPM 2.0 device driver doesn't export the TPM PCRs.
> > > > > > ?Not only would you have a dependency on ima-evm-utils, but also on a
> > > > > > userspace application(s) for reading the TPM PCRs. ?That dependency
> > > > > > exists whether you're using evmctl to calculate the boot_aggregate or
> > > > > > doing it yourself.
> > > > > Hm, things get complicated.
> > > > > Yep I remember your patch to skip verifying TPM 2.0 PCR values
> > > > > https://patchwork.ozlabs.org/project/ltp/patch/1558041162.3971.2.camel@linux.ibm.com/
> > > > > At least thanks to Jerry Snitselaar since v5.6 we have
> > > > > /sys/class/tpm/tpm*/tpm_version_major. We could check this (+ try also
> > > > > /sys/class/tpm/tpm0/device/description for older kernels).

> > > > > BTW on my system there is also /sys/class/tpm/tpm0/ppi/version, which has 1.2,
> > > > > not sure if it indicate TPM 1.2, but I wouldn't rely on that.


> Missed this last paragraph.. but /sys/class/tpm/tpm0/ppi/version has
> relation to the Physical Presence Interface version, which is the
> communication interface between firmware and OS afaik, and doesn't
> points to the TPM version: TPM2.0 may have PPI version 1.2 or 1.3.


Kind regards,
Petr
