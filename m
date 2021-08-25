From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Aug 2021 09:17:26 +0200
Subject: [LTP] [PATCH v7,
 4/4] Make argument to tst_umount an absolute path
In-Reply-To: <YSTvNANtOqYxNZSe@yuki>
References: <YSTj7CB6PdG2HZsQ@ubuntu02>
 <YSTvNANtOqYxNZSe@yuki>
Message-ID: <YSXuhovPqvZiZ4VL@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Leo,

> Hi!
> >  	[ "$mounted" ] || return
> > -	tst_umount $MNTDIR
> > +	tst_umount $PWD/$MNTDIR

> I guess that we should have the $PWD/$MNTDIR inside of double quotes
> just to be extra careful.
Thanks for catching problems, updated and merged.

I also post yet additional update of docs (TST_MNTPOINT should be full path).

Kind regards,
Petr
