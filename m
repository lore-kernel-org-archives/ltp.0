From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 May 2021 16:58:01 +0200
Subject: [LTP] LTP Release
In-Reply-To: <YJlHfa/E+eNchQQE@pevik>
References: <YJOYgZNL7/qp5YCN@yuki> <YJPo4L0QnXHU7xks@pevik>
 <YJVPP64LuDK7O564@pevik> <YJj4wftakLE7PECd@yuki>
 <YJlHfa/E+eNchQQE@pevik>
Message-ID: <YJlJ+ZV6zxqPO8Ed@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Here as well, if things are tested and ready soon enough then go ahead
> > and apply it.
> I was wrong, the last bit has not been upstreamed, thus only first commit can be
> merged.
> 
> > I would like to freeze the git and start pre release testing, if
> > possible, in the second half of this week. If there is anything else
> > that should be fixed please speak up now.
> Good to know.
> 
> I suppose you're going to merge Martin's (rt)netlink patchset [1]
> (I'd prefer to get it merged).

That one is stalled by my question if we can do more active polling
instead of the sleep and unless we get a reply soon it's not going to
get in...

> My netns_netlink rewrite + fix for recent ip [2] would be nice to get merged.
> In the future I'll add a check for that prehistoric iproute 100519.

I will have a look.

-- 
Cyril Hrubis
chrubis@suse.cz
