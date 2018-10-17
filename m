From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 Oct 2018 09:32:37 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscalls/keyctl02: wait for last key to be
 garbage collected
In-Reply-To: <20181017132528.GB31018@rei>
References: <79fc54a1540ed236a5539d9f848cc18045aa6c4d.1539781539.git.jstancek@redhat.com>
 <20181017132528.GB31018@rei>
Message-ID: <22181421.58966566.1539783157977.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> >  static void do_test(void)
> >  {
> > -	int i;
> > -	key_serial_t key;
> > +	int i, ret;
> > +	key_serial_t key, key_inv;
> >  	pthread_t pth[4];
> >  
> >  	for (i = 0; i < LOOPS; i++) {
> > @@ -94,13 +95,45 @@ static void do_test(void)
> >  		SAFE_PTHREAD_JOIN(pth[3], NULL);
> >  	}
> >  
> > +	/*
> > +	 * Kernel should start garbage collect when last reference to key
> > +	 * is removed (see key_put()). Since we are adding keys with identical
> > +	 * description and type, each replacement should schedule a gc run,
> > +	 * see comment at __key_link().
> > +	 *
> > +	 * We create extra key here, to remove reference to last revoked key.
> > +	 */
> > +	key_inv = add_key("user", "ltptestkey", "foo", 3,
> > +		KEY_SPEC_PROCESS_KEYRING);
> > +	if (key_inv == -1)
> > +		tst_brk(TBROK | TERRNO, "Failed to add key");
> > +
> > +	/*
> > +	 * If we have invalidate, we can drop extra key immediately as well,
> > +	 * which also schedules gc.
> > +	 */
> > +	if (keyctl(KEYCTL_INVALIDATE, key_inv) == -1 && errno != EOPNOTSUPP)
> > +		tst_brk(TBROK | TERRNO, "Failed to invalidate key");
> > +
> > +	/*
> > +	 * At this point we are quite confident that gc has been scheduled,
> > +	 * so we wait and periodically check for last test key to be removed.
> > +	 */
> > +	for (i = 0; i < MAX_WAIT_FOR_GC_MS; i += 100) {
> > +		ret = keyctl(KEYCTL_REVOKE, key);
> > +		if (ret == -1 && errno == ENOKEY)
> > +			break;
> > +		usleep(100*1000);
> > +	}
> > +
> > +	tst_res(TINFO, "waiting for key gc took: %d ms", i);
> 
> Minor enhancement may be:
> 
> 	if (i)
> 		tst_res(TINFO, "waiting for key gc took: %d ms", i);
> 
> 
> Anyways, the patch looks good, acked.

Pushed with "if (i)" above.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
