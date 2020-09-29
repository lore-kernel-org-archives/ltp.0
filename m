From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 30 Sep 2020 02:11:18 +0300
Subject: [LTP] [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
In-Reply-To: <20200929165021.11731-1-pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
Message-ID: <20200929231118.GA805493@linux.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Sep 29, 2020 at 06:50:17PM +0200, Petr Vorel wrote:
> Hi,
> 
> few more fixes, mostly touching older kernels or evmctl versions.
> Changes in 3rd and 4th commit.
> 
> Kind regards,
> Petr
> 
> Petr Vorel (4):
>   IMA: Move get_algorithm_digest(), set_digest_index() to ima_setup.sh
>   IMA: Rewrite ima_boot_aggregate.c to new API
>   ima_tpm.sh: Fix calculating boot aggregate
>   ima_tpm.sh: Fix calculating PCR aggregate
> 
>  .../integrity/ima/src/ima_boot_aggregate.c    | 113 ++++----
>  .../integrity/ima/tests/ima_measurements.sh   |  62 +---
>  .../security/integrity/ima/tests/ima_setup.sh |  70 +++++
>  .../security/integrity/ima/tests/ima_tpm.sh   | 265 ++++++++++++++----
>  4 files changed, 341 insertions(+), 169 deletions(-)
> 
> -- 
> 2.28.0
> 

Hi, is there something specific I should look at in this patch set?

/Jarkko
