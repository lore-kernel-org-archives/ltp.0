From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Aug 2018 15:18:47 +0200
Subject: [LTP] [PATCH RFC v3 3/3] move_pages12: end early if runtime
 gets close to test time
In-Reply-To: <fdf611134b15684031f7bd3e2d5fe86d49124b26.1535466715.git.jstancek@redhat.com>
References: <920f7a911d8b32c3c2e673a9c608ded2526a616d.1535466715.git.jstancek@redhat.com>
 <fdf611134b15684031f7bd3e2d5fe86d49124b26.1535466715.git.jstancek@redhat.com>
Message-ID: <20180829131847.GC30074@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	unsigned int _20_percent = (tst_timeout_remaining() / 5);

I would like to avoid variables that start with underscore if possible,
since these are reserved for libc...

Otherwise it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
