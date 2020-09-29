From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Sep 2020 18:53:30 +0200
Subject: [LTP] [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
In-Reply-To: <20200929165021.11731-1-pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
Message-ID: <20200929165330.GA11939@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi, Lakshmi,

sorry for late version. FYI Cyril is planning to release LTP tomorrow evening,
thus To get it into this release require review and testing till tomorrow lunch
or something.
Thus understand if you don't have time for it.

NOTE: crazy support for old versions was important to get support for older SLES
versions.

Kind regards,
Petr

> Hi,

> few more fixes, mostly touching older kernels or evmctl versions.
> Changes in 3rd and 4th commit.

> Kind regards,
> Petr

> Petr Vorel (4):
>   IMA: Move get_algorithm_digest(), set_digest_index() to ima_setup.sh
>   IMA: Rewrite ima_boot_aggregate.c to new API
>   ima_tpm.sh: Fix calculating boot aggregate
>   ima_tpm.sh: Fix calculating PCR aggregate

>  .../integrity/ima/src/ima_boot_aggregate.c    | 113 ++++----
>  .../integrity/ima/tests/ima_measurements.sh   |  62 +---
>  .../security/integrity/ima/tests/ima_setup.sh |  70 +++++
>  .../security/integrity/ima/tests/ima_tpm.sh   | 265 ++++++++++++++----
>  4 files changed, 341 insertions(+), 169 deletions(-)
