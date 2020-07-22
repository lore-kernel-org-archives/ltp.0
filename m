From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 22 Jul 2020 14:09:49 -0400
Subject: [LTP] [PATCH v2] IMA: Add test for kexec cmdline measurement
In-Reply-To: <20200722164040.23109-1-t-josne@linux.microsoft.com>
References: <20200722164040.23109-1-t-josne@linux.microsoft.com>
Message-ID: <1595441389.5211.1.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 2020-07-22 at 12:40 -0400, Lachlan Sneff wrote:
> IMA policy can be set to measure the command line passed in the kexec system call.
> There needs to be a test to validate this kexec command line measurement.
> 
> Add a testcase that verifies that the IMA subsystem has correctly
> measured the cmdline specified during a kexec.
> 
> Note that this test does not actually reboot.
> 
> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>

Other than the patch not applying cleanly and leading blanks,?

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
