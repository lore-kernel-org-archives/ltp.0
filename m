From: Mimi Zohar <zohar@kernel.org>
Date: Wed, 22 Jul 2020 14:32:01 -0400
Subject: [LTP] [PATCH v2] IMA: Add test for kexec cmdline measurement
In-Reply-To: <1595441389.5211.1.camel@linux.ibm.com>
References: <20200722164040.23109-1-t-josne@linux.microsoft.com>
 <1595441389.5211.1.camel@linux.ibm.com>
Message-ID: <1595442721.5211.7.camel@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 2020-07-22 at 14:09 -0400, Mimi Zohar wrote:
> On Wed, 2020-07-22 at 12:40 -0400, Lachlan Sneff wrote:
> > IMA policy can be set to measure the command line passed in the kexec system call.
> > There needs to be a test to validate this kexec command line measurement.
> > 
> > Add a testcase that verifies that the IMA subsystem has correctly
> > measured the cmdline specified during a kexec.
> > 
> > Note that this test does not actually reboot.
> > 
> > Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> 
> Other than the patch not applying cleanly and leading blanks,?
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Oops, the kexec load is using the '-s' option, similarly the unload
should use it too. ?Please change all the "kexec -u" occurences to
"kexec -su".

+    if ! kexec -sl $IMAGE --reuse-cmdline; then
> +        tst_res TCONF "kexec failed: $?"
> +        
> +        local sb_status="$(bootctl status 2>/dev/null | grep 'Secure Boot' \
> +            | tr -d ' ' | sed 's/SecureBoot:*//')"
> +        
> +        if [ "$sb_status" = "enabled" ]; then
> +            tst_res TINFO "secure boot is enabled, the specified kernel image may not be signed"
> +        fi
> +
> +        return
> +    fi
> +
> +    kexec -u
> +
> +    if ! measure "$cmdline"; then
> +        tst_res TFAIL "unable to find a correct entry in the IMA log"
> +        
> +        if [ ! -r $IMA_POLICY ]; then
> +            tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required) to give contextual information"
> +        fi
> +
> +        if ! grep "measure func=KEXEC_CMDLINE" $IMA_POLICY >/dev/null; then
> +            tst_brk TCONF "The IMA policy does not specify 'measure func=KEXEC_CMDLINE', see IMA test README"
> +        fi
> +
> +        return
> +    fi
> +
> +    cmdline="foo"cmldine
> +    if ! kexec -sl $IMAGE --append=$cmdline; then
> +        tst_brk TCONF "kexec failed: $?"
> +    fi
> +
> +    kexec -u
