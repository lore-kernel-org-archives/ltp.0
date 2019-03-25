From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 Mar 2019 15:20:45 +0100
Subject: [LTP] [PATCH v3 2/2] syscalls/select04: Test four syscall
 variants
In-Reply-To: <20190322171134.899-3-chrubis@suse.cz>
References: <20190322171134.899-1-chrubis@suse.cz>
 <20190322171134.899-3-chrubis@suse.cz>
Message-ID: <20190325142045.GA26747@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

>  testcases/kernel/syscalls/select/select04.c   |  7 +-
...
> +static void select_info(void)
> +{
> +	switch (tst_variant) {
> +	case 0:
> +		tst_res(TINFO, "Testing glibc select()");
nit: I'd use 'libc' instead of 'glibc'.

> +	break;
> +	case 1:
> +		tst_res(TINFO, "Testing SYS_select syscall");
> +	break;
> +	case 2:
> +		tst_res(TINFO, "Testing SYS_pselect6 syscall");
> +	break;
> +	case 3:
> +		tst_res(TINFO, "Testing SYS__newselect syscall");
> +	break;

Kind regards,
Petr
