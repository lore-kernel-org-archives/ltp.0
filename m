From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Oct 2019 14:18:48 +0200
Subject: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
In-Reply-To: <20190517150456.GA11796@dell5510>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
 <20190517150456.GA11796@dell5510>
Message-ID: <20191024121848.GA5908@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

I wonder what to do with this patch "ima: skip verifying TPM 2.0 PCR values" [1].
Is it a correct way to differentiate between TPM 1.2 and TPM 2.0?
Or something else should be applied?

How is the work on TPM 2.0 Linux sysfs interface?
But even it's done in near future, we'd still need some way for older kernels.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1100733/
