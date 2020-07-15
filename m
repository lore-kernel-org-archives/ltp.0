From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 14 Jul 2020 21:41:49 -0400
Subject: [LTP] [PATCH 2/2] IMA: Verify IMA buffer passing through the
 kexec barrier
In-Reply-To: <20200702153545.3126-3-t-josne@linux.microsoft.com>
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
 <20200702153545.3126-3-t-josne@linux.microsoft.com>
Message-ID: <1594777309.12900.237.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 2020-07-02 at 11:35 -0400, Lachlan Sneff wrote:
> Add a testcase that verifies that kexec correctly passes
> the IMA buffer through the soft reboot.
> 
> This test must be run standalone, since it runs kexec.
> 
> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>

Depending on the policy, the measurement list could be exactly the
same from one boot to the next. ?This test simply checks that the
first N number of measurements are the same. ?It doesn't verify that
there are additional measurements, nor does it check that there is an
additional "boot_aggregate" after the kexec. ?At minimum the test
should verify the existence of multiple "boot_aggregate" values in the
measurement list.

A more complete test would walk the measurement list, re-calculating
the PCR digests, and then compare the recalculated PCRS against the
TPM PCRs. ?If all the measurements were properly carried across the
kexec, the PCR digests should match.

Mimi
