From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Sep 2020 07:53:14 +0200
Subject: [LTP] [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
In-Reply-To: <20200929231118.GA805493@linux.intel.com>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929231118.GA805493@linux.intel.com>
Message-ID: <20200930055314.GA21664@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jarkko,

> Hi, is there something specific I should look at in this patch set?

I'm sorry to bother you with LTP specific code. Can you have a quick look if I
didn't overlook anything obvious in reading PCR files (read_pcr_tpm*())?

I'm surprised that it's working on my TPM 2.0 which does not export
/sys/kernel/security/tpm0/binary_bios_measurements (using evmctl).

> /Jarkko

Kind regards,
Petr
