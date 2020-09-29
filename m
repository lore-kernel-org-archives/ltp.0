From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 29 Sep 2020 17:56:15 -0400
Subject: [LTP] [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
In-Reply-To: <20200929165330.GA11939@dell5510>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929165330.GA11939@dell5510>
Message-ID: <48cbcb6c03d0938a2e6e97a5b8ca08cac9b706a8.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Tue, 2020-09-29 at 18:53 +0200, Petr Vorel wrote:
> Hi Mimi, Lakshmi,
> 
> sorry for late version. FYI Cyril is planning to release LTP tomorrow evening,
> thus To get it into this release require review and testing till tomorrow lunch
> or something.
> Thus understand if you don't have time for it.
> 
> NOTE: crazy support for old versions was important to get support for older SLES
> versions.

Thank you so much for updating the ima_tpm.sh test.  Of all the
comments, it would be nice to re-verify the measurement list with "
--ignore-violations" to provide more context.  Anyone running with just
the ima_policy=tcb, would have violations.  You should be able to test
that yourself with the logs, PCRs, and directions,  I sent you.

In terms of supporting the "ima" template, I think it would only be for
old, existing systems, but then I doubt they would be running ltp.  
The "boot_aggregate" to "sha1" change works on a system with TPM 1.2.

Mimi


