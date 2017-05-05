From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 5 May 2017 14:55:39 +0200
Subject: [LTP] [RFC] [PATCH] syscalls/move_pages12: Two fixes.
In-Reply-To: <959115821.7379621.1493924279254.JavaMail.zimbra@redhat.com>
References: <20170503124233.18585-1-chrubis@suse.cz>
 <959115821.7379621.1493924279254.JavaMail.zimbra@redhat.com>
Message-ID: <20170505125539.GC16729@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > * Do not multiply free ram with 1024
> > 
> >   - Since we get overflow even on fairly modest
> >     machine with a few GB of RAM and the test
> >     will always report "Not enough RAM".
> 
> This is obviously ok.

I've pushed this part.

> > 
> > * Drop caches before the test
> > 
> >   - Otherwise the move_pages() syscalls may
> >     fail with ENOMEM.
> > 
> 
> How about we try to allocate/touch couple MB worth of pages
> on node, we are going to move to (alloc_pages_on_node())?
> If we can't allocate, exit with TCONF.
> 
> Otherwise we free those pages just before move_pages().
> Wouldn't that give us better guarantee, there are some
> free pages on target node?

Sounds reasonable, I will look into this.

-- 
Cyril Hrubis
chrubis@suse.cz
