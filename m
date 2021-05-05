From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 May 2021 22:20:49 +0200
Subject: [LTP] [PATCH v3 4/6] Add rtnetlink helper library
In-Reply-To: <YJKMpOi9Ei9z2cpy@yuki>
References: <20210505081845.7024-1-mdoucha@suse.cz>
 <20210505081845.7024-4-mdoucha@suse.cz> <YJKA9LQsiFDeuPUT@pevik>
 <YJKMpOi9Ei9z2cpy@yuki>
Message-ID: <YJL+IXKEq4ruFbyK@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > > +int tst_rtnl_add_message(const char *file, const int lineno,
> > > +	struct tst_rtnl_context *ctx, const struct nlmsghdr *header,
> > > +	const void *payload, size_t payload_size)
> > > +{
> > > +	size_t size;
> > > +	unsigned int extra_flags = 0;
> > > +
> > > +	if (!tst_rtnl_grow_buffer(file, lineno, ctx, NLMSG_SPACE(payload_size)))
> > Shouldn't there be an error message?
> > Or maybe at tst_rtnl_grow_buffer() on if (!buf)

> As far as I can tell we will get error message from the safe_realloc()
Right, thanks for info!

Kind regards,
Petr

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Nice code, thanks!

> > Kind regards,
> > Petr
