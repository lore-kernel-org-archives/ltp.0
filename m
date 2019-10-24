From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 24 Oct 2019 20:20:23 +0300
Subject: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
In-Reply-To: <20191024121848.GA5908@dell5510>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510> <20191024121848.GA5908@dell5510>
Message-ID: <20191024172023.GA7948@linux.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 24, 2019 at 02:18:48PM +0200, Petr Vorel wrote:
> Hi all,
> 
> I wonder what to do with this patch "ima: skip verifying TPM 2.0 PCR values" [1].
> Is it a correct way to differentiate between TPM 1.2 and TPM 2.0?
> Or something else should be applied?
> 
> How is the work on TPM 2.0 Linux sysfs interface?
> But even it's done in near future, we'd still need some way for older kernels.
> 
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/patch/1100733/

version_major sysfs file would be acceptable if someone wants to proceed
and send such patch.

Also replicants for durations and timeouts files would make sense for
TPM 2.0.

/Jarkko
