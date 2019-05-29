From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 May 2019 12:12:27 +0200
Subject: [LTP] [PATCH 2/5] syscalls/adjtimex02: Convert to new library
In-Reply-To: <20190519003808.47425-3-sspatil@android.com>
References: <20190519003808.47425-1-sspatil@android.com>
 <20190519003808.47425-3-sspatil@android.com>
Message-ID: <20190529101227.GB26685@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	buff = tim_save;
> +	buff.modes = SET_MODE;
> +	switch (nr) {
> +	case 0:
> +		break;
> +	case 1:
> +		buff.tick = 900000 / hz - 1;
> +		break;
> +	case 2:
> +		buff.tick = 1100000 / hz + 1;
> +		break;
> +	case 3:
> +		/* Switch to nobody user for correct error code collection */
> +		ltpuser = SAFE_GETPWNAM("nobody");
> +		SAFE_SETEUID(ltpuser->pw_uid);
> +		break;
> +	case 4:
> +		buff.offset = 512000L + 1;
> +		break;
> +	case 5:
> +		buff.offset = (-1) * (512000L) - 1;
> +		break;
> +	default:
> +		tst_brk(TFAIL, "Invalid test case %u ", nr);
> +	}


What I do not like about this is that half of the data is now in the
structure with errnos while the other half is encoded in this switch and
we depend on the order of the structure.

In this case I think that the cleaner option would be getting rid of the
structure and set the expected errno in the switch. That way all the
data would be in a single place at least.

> -	tst_exit();
> +	TEST(adjtimex(tcase->buffp));
> +	if ((TST_RET == -1) && (TST_ERR == tcase->exp_errno)) {
> +		tst_res(TPASS | TTERRNO,
> +				"adjtimex() error %u ", tcase->exp_errno);
> +	} else {
> +		tst_res(TFAIL | TTERRNO,
> +				"Test Failed, adjtimex() returned %ld",
> +				TST_RET);
> +	}
>  
> +	/* clean up after ourselves */
> +	if (nr == 3)
> +		SAFE_SETEUID(0);
>  }

-- 
Cyril Hrubis
chrubis@suse.cz
