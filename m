From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Jun 2020 15:01:40 +0200
Subject: [LTP] [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot
 aggregate
In-Reply-To: <1592570638.17802.8.camel@linux.ibm.com>
References: <1590601280.16219.1.camel@linux.ibm.com>
 <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com>
 <20200528160527.GA27243@dell5510> <20200615194134.GF129694@glitch>
 <1592252491.11061.181.camel@linux.ibm.com>
 <20200617012148.hhpvxqov2py7fvvc@cantor>
 <20200617204500.GB40831@glitch> <20200619082134.GB23036@dell5510>
 <1592570638.17802.8.camel@linux.ibm.com>
Message-ID: <20200619130140.GA30256@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi,

> > ...
> > > > > I'd appreciate if someone could send me a TPM event log, the PCRs, and
> > > > > the associated IMA ascii_runtime_measurements "boot_aggregate" from a
> > > > > system with a discrete TPM 2.0 with PCRs 8 & 9 events.


> > > Maybe Maurizio already have it at hand?
> > I'd appreciate to have these files as well.

> > > I can try to setup a system with grub2+tpm to get the log with pcr 8 and
> > > 9 filled.

> Both RHEL 8 and Ubuntu 20.04 LTS have PCRs 8 & 9. ?I'll include one as
> another example for the tests/boot_aggregate.test.
Thank you!

Kind regards,
Petr
