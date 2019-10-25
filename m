From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 Oct 2019 15:25:27 +0200
Subject: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
In-Reply-To: <20191025125202.GA1966@mail.hallyn.com>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510> <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
 <20191024213842.c6cl4tlnsi56pgcy@cantor>
 <1571964420.5173.12.camel@linux.ibm.com>
 <20191025021159.dt7ifgnebnke6ca7@cantor>
 <20191025085617.GA13329@x230>
 <20191025125202.GA1966@mail.hallyn.com>
Message-ID: <20191025132527.GB13329@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > /sys/kernel/security/tpmX/major_version (on fedora and rhel at least, is it elsewhere on other distros?)

> > > versus

> > > /sys/class/tpm/tpmX/major_version

> > Is it more HW related (/sys/class/tpm/tpmX) or LSM related
> > (/sys/kernel/security/tpmX)?
> > I guess /sys/kernel/security/tpmX might be better.

> This is purely about whether the phsyical TPM chip is 1.2 or 2.,
> right?  /sys/class/tpm/tpmX is where I would expect to find that.
+1

> > Thanks for implementing this, I'll try to test it soon.

> Yes, it's been a pain point, and someone (..., I) should have done this years
> ago - thanks!

Kind regards,
Petr
