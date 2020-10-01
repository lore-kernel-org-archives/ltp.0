From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 1 Oct 2020 21:31:38 +0300
Subject: [LTP] [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
In-Reply-To: <20201001120125.GE32109@dell5510>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929231118.GA805493@linux.intel.com>
 <20200930055314.GA21664@dell5510>
 <20200930115939.GB7612@linux.intel.com>
 <20201001120125.GE32109@dell5510>
Message-ID: <20201001183104.GA15664@linux.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 01, 2020 at 02:01:25PM +0200, Petr Vorel wrote:
> I'll need to keep these hacks for older kernels, but it's great that there is a
> better solution.
> 
> Other thing: do you know anybody practically uses more TPM devices in single
> machine? I'm asking that I work with tpm0 in ima_tpm.sh, but maybe I should
> allow user to redefine it to choose different device (or even run tests for all
> available devices).

You can create a proxy TPM device for a TPM emulator or a software TPM
(e.g. could be an SGX enclave) by using ioctl interface /dev/vtpmx,
provided by tpm_vtpm_proxy driver. QEMU provides a passthrough interface
from TPM devices to the VM, which can be utilized for this.

This one I know at least.

> Kind regards,
> Petr

/Jarkko
