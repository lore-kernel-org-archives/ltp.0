From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 4 May 2017 15:38:48 +0200
Subject: [LTP] [RFC PATCH v5 0/3] Simplify network setup
In-Reply-To: <9bcd22dc-ba31-8423-8f93-fc856905a83b@oracle.com>
References: <20170503160751.1634-1-pvorel@suse.cz>
 <20170504132747.3d799242@linux-v3j5>
 <9bcd22dc-ba31-8423-8f93-fc856905a83b@oracle.com>
Message-ID: <20170504133848.shqxjkj2ru5kks6k@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey, Richard,

> >> BTW: I probably have source lines > 80 chars. My Vim doesn't highlight
> >> anything, but checkpatch.pl complain. I might have wrong vim configuration.
> > Are you using checkpatch.pl from kernel 4.11? It was recently changed to
> > follow the actual style guidelines which say lines over 80 chars are
> > preferable to strings being split over multiple lines. Maybe Vim is aware of
> > that?

> Or may be vim's configuration has wrong tab size, should be 8 characters
> for Linux coding style.
I'm using recent version of checkpatch.pl.
My fault, I've installed linuxsty plugin [1], but default is off, so I had these options:
tabstop=4 softtabstop=4 shiftwidth=4

[1]: https://github.com/vivien/vim-linux-coding-style/blob/master/plugin/linuxsty.vim

Thank you both for tips!

Petr
