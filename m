From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Nov 2020 12:51:46 +0100
Subject: [LTP] [PATCH v3 2/2] syscalls/iopl,
 ioperm: Check for SecureBoot lockdown
In-Reply-To: <20201109164605.25965-2-mdoucha@suse.cz>
References: <20201109164605.25965-1-mdoucha@suse.cz>
 <20201109164605.25965-2-mdoucha@suse.cz>
Message-ID: <20201110115146.GC10788@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> SecureBoot implies integrity lockdown even if tst_lockdown_enabled() cannot
> check lockdown status directly. Udpate skip condition in ioperm() and iopl()
> tests.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +	/* ioperm() is restricted under kernel lockdown. */
> +	if (tst_lockdown_enabled() || tst_secureboot_enabled() > 0)
> +		tst_brk(TCONF, "Kernel is locked down, skip this test");
> +
I wonder if this could be interesting for docparse to have this functionality
exposed as a struct tst_test flag:
.tst_lockdown_restricted = 1

Kind regards,
Petr
