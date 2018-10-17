From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Oct 2018 14:50:47 +0200
Subject: [LTP] [PATCH] syscalls/keyctl02: wait for last key to be
 garbage collected
In-Reply-To: <8c5e9f341253ee647314805639d3133617283edd.1539779861.git.jstancek@redhat.com>
References: <8c5e9f341253ee647314805639d3133617283edd.1539779861.git.jstancek@redhat.com>
Message-ID: <20181017125047.GA31018@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	/*
> +	 * Kernel should start garbage collect when last reference to key
> +	 * is removed (see key_put()). Since we are adding keys with identical
> +	 * description and type, each replacement should schedule a gc run,
> +	 * see comment at __key_link().
> +	 *
> +	 * We create extra key here, to remove reference to last revoked key.
> +	 */
> +	key_inv = add_key("user", "ltptestkey", "foo", 3,
> +		KEY_SPEC_PROCESS_KEYRING);
> +	if (key_inv == -1)
> +		tst_brk(TBROK | TERRNO, "Failed to add key");
> +#ifdef KEYCTL_INVALIDATE
> +	/*
> +	 * If we have invalidate, we can drop extra key immediately as well,
> +	 * which also schedules gc.
> +	 */
> +	if (keyctl(KEYCTL_INVALIDATE, key_inv))
> +		tst_brk(TBROK | TERRNO, "Failed to invalidate key");

We should probably handle the situation where someone compiles this code
on newer userspace and runs it on older kernel than 3.5, I suppose that
we will get -1 with EINVAL or EOPNOTSUPP here.

And if that is handled we can also drop the ifdef in favor of fallback
definition.


Otherwise this looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
