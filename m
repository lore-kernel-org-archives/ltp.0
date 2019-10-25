From: Jerry Snitselaar <jsnitsel@redhat.com>
Date: Fri, 25 Oct 2019 07:13:45 -0700
Subject: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
In-Reply-To: <20191025085617.GA13329@x230>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510> <20191024121848.GA5908@dell5510>
 <20191024172023.GA7948@linux.intel.com>
 <20191024213842.c6cl4tlnsi56pgcy@cantor>
 <1571964420.5173.12.camel@linux.ibm.com>
 <20191025021159.dt7ifgnebnke6ca7@cantor>
 <20191025085617.GA13329@x230>
Message-ID: <20191025141345.46ifshskk2vpxi2t@cantor>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri Oct 25 19, Petr Vorel wrote:
>Hi,
>
>> /sys/kernel/security/tpmX/major_version (on fedora and rhel at least, is it elsewhere on other distros?)
>
>> versus
>
>> /sys/class/tpm/tpmX/major_version
>
>Is it more HW related (/sys/class/tpm/tpmX) or LSM related
>(/sys/kernel/security/tpmX)?
>I guess /sys/kernel/security/tpmX might be better.
>

I think it is HW related since it is describing the
TCG version that the chip implements.

>Thanks for implementing this, I'll try to test it soon.
>
>Kind regards,
>Petr

