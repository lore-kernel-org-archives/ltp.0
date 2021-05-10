From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 May 2021 16:47:25 +0200
Subject: [LTP] LTP Release
In-Reply-To: <YJj4wftakLE7PECd@yuki>
References: <YJOYgZNL7/qp5YCN@yuki> <YJPo4L0QnXHU7xks@pevik>
 <YJVPP64LuDK7O564@pevik> <YJj4wftakLE7PECd@yuki>
Message-ID: <YJlHfa/E+eNchQQE@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > > also solving Shell API timeout sleep orphan processes would be good [1]
> > > There is already C patch [2] + Li suggested to fix the shell implementation
> > > using trap in subshell [3].
> > OK there is shell implementation to fix orphan processes [4] from Joerg, which
> > would be worth do fix it, Li already did a review, I'll look into it today.

> I would like to get to a git freeze soon. I will have a look as well but
> if it's not ready in the first half of this week I would just postpone
> it rather than rush it.

> > I'd like to rebase and send to ML IMA dm-crypt test for testing. If Mimi, Tushar
> > or Lakshmi find time to test it, I'd like to have it in the release.

> Here as well, if things are tested and ready soon enough then go ahead
> and apply it.
I was wrong, the last bit has not been upstreamed, thus only first commit can be
merged.

> I would like to freeze the git and start pre release testing, if
> possible, in the second half of this week. If there is anything else
> that should be fixed please speak up now.
Good to know.

I suppose you're going to merge Martin's (rt)netlink patchset [1]
(I'd prefer to get it merged).

My netns_netlink rewrite + fix for recent ip [2] would be nice to get merged.
In the future I'll add a check for that prehistoric iproute 100519.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=242146
[2] https://patchwork.ozlabs.org/project/ltp/patch/20210401141210.9536-1-pvorel@suse.cz/
