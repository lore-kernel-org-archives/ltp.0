From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 1 Mar 2021 16:45:14 +0100
Subject: [LTP] [PATCH v2 6/6] zram: Increase timeout according to used
 devices
In-Reply-To: <YD0LMzlHtms7WYEi@pevik>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-7-pvorel@suse.cz> <YBRroFhaxdqCLv2i@pevik>
 <YD0EuJtWxhis24ZX@yuki.lan> <YD0LMzlHtms7WYEi@pevik>
Message-ID: <YD0MCli+ucNvffME@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > Hi!
> > > > +	TST_TIMEOUT=$((dev_num*200))
> > > Actually on heavy loaded machine this is not enough due BTRFS.
> > > I can add something like dev_num*600 or even -1 (then previous commit would not
> > > be needed, but IMHO still useful).

> > I would still prefer if we had a timeout there, -1 is for something that
> > cannot be predicted.

> > Also we do not expect machine to be heavily loaded, in that case half of
> > LTP tests would time out.

> > So I would just measure how long the test takes, then multiply it by 5
> > or something like that and put that in as a timeout.
> Do you mean to use high enough static timeout defined before startup (working
> for maximum possible filesystems)? And create tst_set_timeout() for shell as
> independent effort?

BTW looking at the docs for C API tst_set_timeout() is expected to be run in the
setup function. Thus this patchset can be reused (just extended).

Kind regards,
Petr

> Kind regards,
> Petr
