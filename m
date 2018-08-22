From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Aug 2018 17:41:37 +0200
Subject: [LTP] [PATCH v2 1/4] lib/tst_test.c: add 'needs_drivers' option
 with tst_check_drivers cmd
In-Reply-To: <1534764229-26993-1-git-send-email-alexey.kodanev@oracle.com>
References: <1534764229-26993-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180822154137.GA18305@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> The drivers are checked with modprobe. If modprobe is not available
> on the system, the checks are silently skipped.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> ---
> v2: * moved tst_check_driver() from tst_test.h to tst_kernel.h
>     * added the new option description to the doc and comment to tst_kernel.h
>     * iterating over the driver list moved out from tst_check_drivers(), the
>       function renamed accordingly.

...
> +2.2.26 Checking kernel for the driver support
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> + Someties test needs certain drivers to be available in the kernel and must
Typo Sometimes

> +end with TCONF if any are missing. For this task there is the '.needs_drivers'
> +option which accepts NULL-terminated array of the drivers names.
> +
> +Since it relies on modprobe command, the check will be skipped if the command
> +itself is not available on the system.


> +++ b/testcases/lib/tst_check_drivers.c
...
> +	if (argc < 2) {
> +		fprintf(stderr, "Please provide kernel driver list\n");
> +		return 1;
> +	}
> +
> +	for (i = 1; (name = argv[i]); ++i)
> +		if (tst_check_driver(name)) {
> +			fprintf(stderr, "%s", name);
> +			return 1;
> +		}
> +
> +	return 0;
> +}
It'd be handy to be able to load module with parameters. E.g.:
tcrypt sec=1 mode=200

We have 2 options: to name strig by spaces to b:
./tst_check_drivers "tcrypt sec=1 mode=200" other_module

Or handle in tst_check_drivers.c just one module and call it several times.

None of them is elegant.

Otherwise LGTM.


Kind regards,
Petr
