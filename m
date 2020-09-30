From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 30 Sep 2020 14:59:39 +0300
Subject: [LTP] [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
In-Reply-To: <20200930055314.GA21664@dell5510>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929231118.GA805493@linux.intel.com>
 <20200930055314.GA21664@dell5510>
Message-ID: <20200930115939.GB7612@linux.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 30, 2020 at 07:53:14AM +0200, Petr Vorel wrote:
> Hi Jarkko,
> 
> > Hi, is there something specific I should look at in this patch set?
> 
> I'm sorry to bother you with LTP specific code. Can you have a quick look if I
> didn't overlook anything obvious in reading PCR files (read_pcr_tpm*())?
> 
> I'm surprised that it's working on my TPM 2.0 which does not export
> /sys/kernel/security/tpm0/binary_bios_measurements (using evmctl).

Thank you, this was actually really important remark and reminder.

OK so I think James' patch is stuck because of me, i.e.

https://lore.kernel.org/linux-integrity/20200911114820.GB6877@linux.intel.com/

I'm sorry about this. The final final conclusion is that the way it
exports PCRs is just fine.

Can you test this version?

https://patchwork.kernel.org/patch/11759729/

I can then add reviewd-by and apply it and you don't have to do any sort
of stupid hacks.

/Jarkkko
