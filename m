From: Mimi Zohar <zohar@kernel.org>
Date: Thu, 30 Jul 2020 15:58:51 -0400
Subject: [LTP] [PATCH v6 4/4] IMA: Add test for kexec cmdline measurement
In-Reply-To: <20200728001301.31121-1-pvorel@suse.cz>
References: <20200728001301.31121-1-pvorel@suse.cz>
Message-ID: <1596139131.25003.14.camel@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 2020-07-28 at 02:13 +0200, Petr Vorel wrote:
> From: Lachlan Sneff <t-josne@linux.microsoft.com>
> 
> IMA policy can be set to measure the command line passed in the kexec
> system call. Add a testcase that verifies that the IMA subsystem
> correctly measure the cmdline specified during a kexec.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> [ pvorel: improved setup, various LTP API cleanup ]
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, really nice.

Missing is a short comment explaining the reason for the multiple
tests.

> +test()
> +{
> +	case $1 in
> +	1) kexec_test '--reuse-cmdline';;
> +	2) kexec_test '--append' 'foo';;
> +	3) kexec_test '--command-line' 'bar';;
> +	esac
> +}
> +
> +tst_run

