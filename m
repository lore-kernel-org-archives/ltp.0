From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Dec 2019 14:28:48 +0100
Subject: [LTP] [PATCH 1/1] shell: TST_NEEDS_DEVICE imply TST_TMPDIR
In-Reply-To: <20191210104106.GA29288@rei.lan>
References: <20191209203248.2427967-1-pvorel@suse.cz>
 <20191210104106.GA29288@rei.lan>
Message-ID: <20191210132848.GA11148@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > instead of requiring to be set.
> > This is a sync with C API (previous commit).

> Looks good, acked.
Thanks merged.

BTW any objections to related shell tst_mount()/tst_umount() fix?
https://patchwork.ozlabs.org/patch/1206399/


Kind regards,
Petr
