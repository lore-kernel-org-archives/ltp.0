From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 May 2018 13:08:34 +0200
Subject: [LTP] [PATCH] inotify07: Add test for kernel crash during event
 notification
In-Reply-To: <20180503152236.17488-1-jack@suse.cz>
References: <20180503152236.17488-1-jack@suse.cz>
Message-ID: <20180523110834.GA8833@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When a removal of the last mark on inode / vfsmount races with a
> notification about new event on that object, the kernel can crash. Test
> for this failure. The problem was fixed by kernel commit d90a10e2444b
> "fsnotify: Fix fsnotify_mark_connector race".

Pushed as inotify09 with following changes:

* I've changed the test to use two threads and fzsync synchronization
  library we implemented especially for triggering races between
  syscalls

* Changed the licence to GPLv2+ which is default for LTP, I hope that
  you do not mind

* Added .gitignore and runtest entries

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
