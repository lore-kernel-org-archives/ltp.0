From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 May 2021 18:49:19 +0200
Subject: [LTP] LTP Release
In-Reply-To: <205dc258-12fa-ba43-8a77-15fe0a08a430@suse.cz>
References: <YJOYgZNL7/qp5YCN@yuki> <YJPo4L0QnXHU7xks@pevik>
 <YJVPP64LuDK7O564@pevik> <YJj4wftakLE7PECd@yuki>
 <YJlHfa/E+eNchQQE@pevik> <YJlJ+ZV6zxqPO8Ed@yuki>
 <205dc258-12fa-ba43-8a77-15fe0a08a430@suse.cz>
Message-ID: <YJlkD2QjJfn9b3YG@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 10. 05. 21 16:58, Cyril Hrubis wrote:
> >> I suppose you're going to merge Martin's (rt)netlink patchset [1]
> >> (I'd prefer to get it merged).

> > That one is stalled by my question if we can do more active polling
> > instead of the sleep and unless we get a reply soon it's not going to
> > get in...

> That question only applies to patch 6. You don't need to wait with
> merging patches 1-5. It won't break any tests since the new code will be
> unused anyway.
Yep, I'd vote for merging 1-5.

Kind regards,
Petr
