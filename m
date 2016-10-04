From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 4 Oct 2016 13:50:15 +0200
Subject: [LTP] new shell library
In-Reply-To: <254451816.211402.1475574875165.JavaMail.zimbra@redhat.com>
References: <20161003145835.GD7583@rei.suse.cz>
 <2007222752.190298.1475569383933.JavaMail.zimbra@redhat.com>
 <20161004084532.GA29418@rei.lan>
 <1484818671.202716.1475571733691.JavaMail.zimbra@redhat.com>
 <20161004093549.GC29418@rei.lan>
 <254451816.211402.1475574875165.JavaMail.zimbra@redhat.com>
Message-ID: <20161004115014.GD29418@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I somehow find it more clear to define all the variables that the
> > library script uses before we source it. IMHO that is better than having
> > them scattered all around the script, at this point both the old test.sh
> > and tst_test.sh scripts enforce that by doing sanity checks on the
> > variables when the library script is sourced.
> > 
> > Are any advantages for doing the sanity checks in the tst_run function?
> 
> Can't think of any. You (and old test.sh) convinced me to go with your
> example. Let's give it couple days, if anyone else wants to weigh in.

FYI I've changed the code at [1] accordingly to our discussion as it was
easy enough, mostly just shuffling code around.

[1] https://github.com/metan-ucw/ltp/commits/master

-- 
Cyril Hrubis
chrubis@suse.cz
