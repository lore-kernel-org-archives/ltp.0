From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 May 2017 21:20:08 +0200
Subject: [LTP] [PATCH v2 04/10] Test for uname26 exploit CVE-2012-0957
In-Reply-To: <20170522121341.4663-5-rpalethorpe@suse.com>
References: <20170522121341.4663-1-rpalethorpe@suse.com>
 <20170522121341.4663-5-rpalethorpe@suse.com>
Message-ID: <20170526192008.GB16233@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void try_leak_bytes(void)
> +{
> +	struct utsname buf;
> +
> +	if (uname(&buf))
> +		tst_brk(TBROK | TERRNO, "Call to uname failed");
> +
> +#define CHECK_FIELD(field_name) \
> +	(check_field(buf.field_name, ARRAY_SIZE(buf.field_name), #field_name))
> +
> +	if (!(CHECK_FIELD(release) |
> +	    CHECK_FIELD(sysname) |
> +	    CHECK_FIELD(nodename) |
> +	    CHECK_FIELD(version) |
> +	    CHECK_FIELD(machine) |
> +#ifdef _GNU_SOURCE
> +	    CHECK_FIELD(domainname) |
> +#endif

The _GNU_SOURCE does not get defined automatically, unless you include a
header defines it. So I guess that we should better do a configure check
if the field is present when _GNU_SOURCE is defined. Define _GNU_SOURCE
at the start of this file and ifdef around macro that has been defined
by the configure script here. Or we can simply avoid checking the
domainname, since I guess that all the fields are filled with the same
function anyway.

> +		    0)) {
> +		tst_res(TPASS, "All fields zeroed after string terminator");
> +	}
> +#undef CHECK_FIELD
> +}
> +
> +static void run(unsigned int test_nr)
> +{
> +	if (!test_nr) {
> +		tst_res(TINFO, "Calling uname with default personality");
> +		try_leak_bytes();
> +	} else {
> +		if (personality(PER_LINUX | UNAME26) < 0)
> +			tst_brk(TCONF | TERRNO,
> +				"Could not change personality to UNAME26");
> +		tst_res(TINFO, "Calling uname with UNAME26 personality");
> +		try_leak_bytes();
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.tid = "cve-2012-0957",
> +	.test = run,
> +	.tcnt = 2,
> +};
> -- 
> 2.12.2
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
