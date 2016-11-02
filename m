From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Nov 2016 15:48:35 +0100
Subject: [LTP] [PATCH 3/3] inotify06: kernel version check
In-Reply-To: <1478087824-31577-4-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478087824-31577-1-git-send-email-dejan.jovicevic@rt-rk.com>
 <1478087824-31577-4-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161102144835.GC28344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> For test inotify06, kernels prior to 4.2 have a race when inode
> is being deleted while inotify group watching that inode is being
> torn down. When the race is hit, the kernel crashes or loops. So,
> added a check to see if the kernel is >= 4.2.0, and if not, the
> test breaks with TCONF and an appropriate message.

NO.

Bringing down broken kernel is exactly the whole point of the test.
Otherwise you cannot tell if the fix was backported to your kernel or
not.

-- 
Cyril Hrubis
chrubis@suse.cz
