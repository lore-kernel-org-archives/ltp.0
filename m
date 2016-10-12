From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 Oct 2016 17:06:15 +0200
Subject: [LTP] new shell library
In-Reply-To: <1527497475.514457.1476284084454.JavaMail.zimbra@redhat.com>
References: <20161003145835.GD7583@rei.suse.cz>
 <1484818671.202716.1475571733691.JavaMail.zimbra@redhat.com>
 <20161004093549.GC29418@rei.lan>
 <254451816.211402.1475574875165.JavaMail.zimbra@redhat.com>
 <20161012100806.GA24231@rei.lan>
 <1175646125.448517.1476268354007.JavaMail.zimbra@redhat.com>
 <20161012123602.GB24231@rei.lan> <20161012131726.GC24231@rei.lan>
 <1527497475.514457.1476284084454.JavaMail.zimbra@redhat.com>
Message-ID: <20161012150615.GA18860@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Looks OK, chances of someone making MYTST_VARIABLE is quite small,
> and we can always improve that regex if needed.

:)

> Couple notes:
> - these seem to be missing: TST_DEVICE, TST_MODPATH, TST_CHECKPOINT_*, TST_NEEDS_CHECKPOINTS

Right, added the TST_DEVICE and TST_MODPATH and updated the git repo.
The checkpoints are not implemented in the tst_test.sh yet, I will add
them later on.

> - doc page mentions "TST_NEEDS_CMD" and "TST_NEEDS_CMDS", the latter looks like typo.

It's TST_NEEDS_CMDS since you can pass string of commands separated by
whitespaces. I've fixed the typo, added an example to the documentation
and updated the repo.

-- 
Cyril Hrubis
chrubis@suse.cz
