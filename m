From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 Aug 2018 11:34:55 +0200
Subject: [LTP] [PATCH ltp] syscalls/bind03: Add version compare
 according to behaviour difference.
In-Reply-To: <5B8900ED.6050003@cn.fujitsu.com>
References: <20180831132453.6461-1-junchi.chen@intel.com>
 <20180831083713.GA11320@dell5510> <5B8900ED.6050003@cn.fujitsu.com>
Message-ID: <20180831093455.GC16417@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> According to bind(2) manpge, bind() should return EINVAL when the socket 
> is already
> bound to an address.  Commit 0fb4455 actually change the errno to 
> EADDRINUSE, but
> i am not sure if this change is a expeceted behavior.

As Michal Kubecek writes in the commit message of the patch I've linked,
the kernel has changed the order of checks which returns different errno
than it used to for no good reason. I would like to be conservative in
this case and have the previous behavior restored, but I suppose that's
up to kernel guys to decide.

-- 
Cyril Hrubis
chrubis@suse.cz
