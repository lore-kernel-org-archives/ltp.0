From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 24 Jul 2020 08:01:51 -0400
Subject: [LTP] [PATCH v4 2/2] IMA: Add test for kexec cmdline measurement
In-Reply-To: <20200724070038.29491-2-pvorel@suse.cz>
References: <20200724070038.29491-1-pvorel@suse.cz>
 <20200724070038.29491-2-pvorel@suse.cz>
Message-ID: <1595592111.5211.246.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 2020-07-24 at 09:00 +0200, Petr Vorel wrote:
> From: Lachlan Sneff <t-josne@linux.microsoft.com>
> 
> IMA policy can be set to measure the command line passed in the kexec
> system call. Add a testcase that verifies that the IMA subsystem
> correctly measure the cmdline specified during a kexec.
> 
> Note that this test does not actually reboot.
> 
> Ideally, test shouldn't even require an image, since it doesn't actually
> reboot, but the IMA cmdline measurement occurs after the image is parsed
> and verified, so we must pass a valid kernel image.
> 
> There is a possibility of putting together a dummy kernel image that has
> the right headers and appears to be signed correctly, but doesn't
> actually contain any code, but, after investigating that possibility, it
> appears to be quite difficult (and would require a dummy kernel for each
> arch).

This test attempts to kexec the existing running kernel image. ?To
kexec a different kernel image export IMA_KEXEC_IMAGE=<pathname>.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> sent version with few my fixes.
> @Mimi: could you please have a quick look? (I know you reviewed previous
> version.)

Thanks, Petr.  Just a couple of comments ...

 
<snip>

> +# Test that the kexec cmdline is measured correctly.
> +# NOTE: This does *not* actually reboot.
> +test1() {
> +	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
> +		tst_brk TCONF "Kernel image not found ('$IMA_KEXEC_IMAGE'), specify it in \$IMA_KEXEC_IMAGE"
> +	fi
> +
> +	# Strip the `BOOT_IMAGE=...` part from the cmdline.
> +	local cmdline="$(sed 's/BOOT_IMAGE=[^ ]* //' /proc/cmdline)"
> +
> +	if ! kexec -sl $IMA_KEXEC_IMAGE --reuse-cmdline; then
> +		tst_res TCONF "kexec failed: $?"
> +
> +		local sb_status="$(bootctl status 2>/dev/null | grep 'Secure Boot' \
> +			| tr -d ' ' | sed 's/SecureBoot:*//')"
> +
> +		if [ "$sb_status" = "enabled" ]; then
> +			tst_res TINFO "secure boot is enabled, the specified kernel image may not be signed"
> +		fi

Independently of the secure boot status, the IMA policy itself could require a signature.

For example, a recent software update is preventing one of my test
laptops from booting with secure boot enabled, but the custom IMA
policy still requires the kexec kernel image to be signed.

Search the IMA policy for an appraise "func=KEXEC_KERNEL_CHECK" policy
rule.

> +
> +		return
> +	fi
> +
> +	kexec -su
> +
> +	if ! measure "$cmdline"; then
> +		tst_res TFAIL "unable to find a correct entry in the IMA log"
> +
> +		check_policy_readable
> +
> +		if ! grep "measure func=KEXEC_CMDLINE" $IMA_POLICY >/dev/null; then
> +			tst_brk TCONF "The IMA policy does not specify 'measure func=KEXEC_CMDLINE', see IMA test README"
> +		fi
> +

Other than the policy "action" - measure/dont_measure,
audit/dont_audit, appraise/dont_appraise - being the first keyword,
the ordering of the policy options and flags is flexible. ?Most
policies do provide the "func" option immediately following the
"action". ?This would normally work.


> +		return
> +	fi
> +
> +	cmdline="foo"
> +	if ! kexec -sl $IMA_KEXEC_IMAGE --append=$cmdline; then
> +		tst_brk TCONF "kexec failed: $?"
> +	fi
> +

The error messages are exactly the same here and below. ?Should a hint
be provided as to which one failed?

Mimi

> +	kexec -su
> +
> +	if ! measure "$cmdline"; then
> +		tst_brk TFAIL "unable to find a correct entry in the IMA log"
> +	fi
> +
> +	cmdline="bar"
> +	if ! kexec -sl $IMA_KEXEC_IMAGE --command-line=$cmdline; then
> +		tst_brk TCONF "kexec failed: $?"
> +	fi
> +
> +	kexec -su
> +
> +	if ! measure "$cmdline"; then
> +		tst_brk TFAIL "unable to find a correct entry in the IMA log"
> +	fi
> +
> +	tst_res TPASS "kexec cmdline was measured correctly"
> +}
> +
> +tst_run

