From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 May 2018 12:30:42 +0200
Subject: [LTP] [PATCH] read_all: Drop privileges
In-Reply-To: <20180515095118.26282-1-rpalethorpe@suse.com>
References: <20180515095118.26282-1-rpalethorpe@suse.com>
Message-ID: <20180515103042.GB7220@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void maybe_drop_privs(void)
> +{
> +	struct passwd *nobody;
> +
> +	if (!drop_privs)
> +		return;
> +
> +	nobody = SAFE_GETPWNAM("nobody");
> +
> +	TEST(setgid(nobody->pw_gid));
> +	if (TEST_RETURN < 0 && TEST_ERRNO != EPERM)
> +		tst_res(TBROK | TTERRNO, "Failed to use nobody gid");
                ^
		Shouldn't this be tst_brk()?

> +	TEST(setuid(nobody->pw_uid));
> +	if (TEST_RETURN < 0 && TEST_ERRNO != EPERM)
> +		tst_res(TBROK | TTERRNO, "Failed to use nobody uid");
                ^
		And here as well?

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
