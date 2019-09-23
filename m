From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Sep 2019 18:11:32 +0200
Subject: [LTP] [PATCH 1/2] Update syscalls/bind02 to new API
In-Reply-To: <20190919145911.22278-2-mdoucha@suse.cz>
References: <20190919145911.22278-1-mdoucha@suse.cz>
 <20190919145911.22278-2-mdoucha@suse.cz>
Message-ID: <20190923161131.GA4779@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Apart from unimportant nit style formatting which can be changed
by maintainer before import this is nice.

Although it'd be perfectly safe to merge it I guess we wait after LTP release.

>  testcases/kernel/syscalls/bind/bind02.c | 153 +++++++-----------------
...
> +	if (!TST_RET) {
> +		tst_res(TFAIL, "bind() succeeded unexpectedly.");
Please, don't use dot.
> +	} else if (TST_ERR == EACCES) {
> +		tst_res(TPASS, "bind() failed as expected");
> +	} else {
> +		tst_res(TFAIL | TERRNO, "Unexpected error");
>  	}
> -
>  }

> -int main(int argc, char *argv[])
> +void setup(void)
>  {
> -	char *username = "nobody";
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> +	struct passwd *pw;
> +	struct group *gr;

> -	tst_require_root();
> +	pw = SAFE_GETPWNAM(TEST_USERNAME);
> +	gr = SAFE_GETGRGID(pw->pw_gid);

> -	if ((pw = getpwnam(username)) == NULL) {
> -		tst_brkm(TBROK, 0, "Username - %s - not found", username);
> -	}
> -
> -	if ((gr = getgrgid(pw->pw_gid)) == NULL) {
> -		tst_brkm(TBROK | TERRNO, 0, "getgrgid(%u) failed", pw->pw_gid);
> -	}
> -
> -	uid = pw->pw_uid;
> -	gid = gr->gr_gid;
> -
> -	tst_resm(TINFO, "Socket will try to be bind by user: %s, group: %s",
> -		 pw->pw_name, gr->gr_name);
> +	tst_res(TINFO, "Switching credentials to user: %s, group: %s",
> +		pw->pw_name, gr->gr_name);
> +	SAFE_SETEGID(gr->gr_gid);
> +	SAFE_SETEUID(pw->pw_uid);
> +}

> -	try_bind();
> -	tst_exit();
> +void cleanup(void) {
Bracket should be on separate line.
> +	SAFE_SETEGID(0);
> +	SAFE_SETEUID(0);
>  }


Kind regards,
Petr
