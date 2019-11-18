From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Nov 2019 17:19:31 +0100
Subject: [LTP] [PATCH] fallocate05: increase FALLOCATE_SIZE
In-Reply-To: <d8ad4bab26557fdf70e7ebc3f771bbb37ae889d7.1574093242.git.jstancek@redhat.com>
References: <d8ad4bab26557fdf70e7ebc3f771bbb37ae889d7.1574093242.git.jstancek@redhat.com>
Message-ID: <20191118161931.GB20740@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> write() returning ENOSPC doesn't guarantee that filesystem after
> some internal book-keeping, flushing, finishing transactions, etc.
> won't still find some extra space.
> 
> Increase FALLOCATE_SIZE to minimize chance of hitting sporadic
> failures when that happens.
> 
> Thanks to Carlos Maiolino and Eric Sandeen for their comments
> and suggestions.

Acked.

-- 
Cyril Hrubis
chrubis@suse.cz
