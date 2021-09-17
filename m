From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 Sep 2021 13:16:35 +0200
Subject: [LTP] [PATCH ltp v3 1/2] IMA: Move check_policy_writable to
 ima_setup.sh and rename it
In-Reply-To: <20210914161503.97495-1-alexh@vpitech.com>
References: <20210914161503.97495-1-alexh@vpitech.com>
Message-ID: <YUR5E6eFMxieUbWA@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alex,

...
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh

As it's now a generally used function I'll add a comment:

# Because we don't grep kernel config for CONFIG_IMA_WRITE_POLICY, we just try
# to write empty string (invalid), thus policy must be repeatedly checked.
# Because after first write to policy policy will be removed on systems without
# CONFIG_IMA_WRITE_POLICY.
> +require_policy_writable()
> +{
> +	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
> +
> +	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
> +	# CONFIG_IMA_READ_POLICY
> +	echo "" 2> log > $IMA_POLICY
> +	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
> +}
> +

Kind regards,
Petr
