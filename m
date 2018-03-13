From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Mar 2018 11:55:41 +0100
Subject: [LTP] [PATCH] cve-2015-3290: Handle 16-bit segments being
 disabled
In-Reply-To: <20180313102931.27897-1-rpalethorpe@suse.com>
References: <20180313102931.27897-1-rpalethorpe@suse.com>
Message-ID: <20180313105541.GB14611@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	TEST(tst_syscall(__NR_modify_ldt, 1, &data_desc, sizeof(data_desc)));
> +	TEST_ERRNO = -(int)TEST_RETURN;

We do have TRERRNO if we changed the test library to ignore the sign bit
we may was well get rid of this ugly hack and use TRERRNO in the
tst_brk() below.

> +	if (TEST_RETURN == -EINVAL) {
> +		tst_brk(TCONF | TTERRNO,
> +			"modify_ldt: 16-bit data segments are probably disabled");
> +	} else if (TEST_RETURN != 0) {
> +		tst_brk(TBROK | TTERRNO, "modify_ldt");
> +	}
>  }


-- 
Cyril Hrubis
chrubis@suse.cz
