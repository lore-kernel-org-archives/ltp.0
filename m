From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 4 May 2017 14:57:59 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] syscalls/move_pages12: Two fixes.
In-Reply-To: <20170503124233.18585-1-chrubis@suse.cz>
References: <20170503124233.18585-1-chrubis@suse.cz>
Message-ID: <959115821.7379621.1493924279254.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> * Do not multiply free ram with 1024
> 
>   - Since we get overflow even on fairly modest
>     machine with a few GB of RAM and the test
>     will always report "Not enough RAM".

This is obviously ok.

> 
> * Drop caches before the test
> 
>   - Otherwise the move_pages() syscalls may
>     fail with ENOMEM.
> 

How about we try to allocate/touch couple MB worth of pages
on node, we are going to move to (alloc_pages_on_node())?
If we can't allocate, exit with TCONF.

Otherwise we free those pages just before move_pages().
Wouldn't that give us better guarantee, there are some
free pages on target node?

Regards,
Jan
