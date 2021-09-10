From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 10 Sep 2021 16:33:06 +0200
Subject: [LTP] [PATCH 4/8] syscalls/setresgid02: Convert to new API
In-Reply-To: <20210909155126.2720-4-mdoucha@suse.cz>
References: <20210909155126.2720-1-mdoucha@suse.cz>
 <20210909155126.2720-4-mdoucha@suse.cz>
Message-ID: <YTtsomf8YXHThm6t@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've pushed patches up to this point, thanks.

For the rest it has to be decided if we will use TST_EXP_FAIL() or not.

I've also did a minor changes to this patch, see below.

> +/*\
> + * [Description]
> + *
> + * Verify that setresgid() will successfully set the expected GID when called
> + * by root with the following combinations of arguments:
> + * 1. setresgid(-1, -1, -1)
> + * 2. setresgid(-1, -1, other)
> + * 3. setresgid(-1, other, -1)
> + * 4. setresgid(other, -1, -1)
> + * 5. setresgid(root, root, root)
> + * 6. setresgid(root, main, main)
> + */

I've reformatted this part so that it rendes as a list in the asciidoc
syntax.

>  struct test_case_t {		/* test case structure */
> -	uid_t *rgid;		/* real GID */
> -	uid_t *egid;		/* effective GID */
> -	uid_t *sgid;		/* saved GID */
> -	struct passwd *exp_rgid;	/* Expected real GID */
> -	struct passwd *exp_egid;	/* Expected effective GID */
> -	struct passwd *exp_sgid;	/* Expected saved GID */
> +	gid_t *rgid;		/* real GID */
> +	gid_t *egid;		/* effective GID */
> +	gid_t *sgid;		/* saved GID */
> +	gid_t *exp_rgid;	/* Expected real GID */
> +	gid_t *exp_egid;	/* Expected effective GID */
> +	gid_t *exp_sgid;	/* Expected saved GID */
>  	char *desc;		/* Test description */
>  };

And also got rid of these useless comments, that were commenting the
obvious.

-- 
Cyril Hrubis
chrubis@suse.cz
