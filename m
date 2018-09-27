From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Sep 2018 15:35:24 +0200
Subject: [LTP] [PATCH] syscalls/getcpu01: support Android
In-Reply-To: <20180912173208.131065-1-smuckle.linux@gmail.com>
References: <20180912173208.131065-1-smuckle.linux@gmail.com>
Message-ID: <20180927133523.GA18835@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Android platforms have the required support for this test.

This is getting way too ugly with all the ifdefs...

And actually we do have a fallback implementation for the CPU_* macros.
I guess that it would be cleaner if we moved the sched_setaffinity.h
from syscalls/sched_setaffinity/ to include/lapi/ so that we can use it
here, that should eliminate most of the ugliness.

-- 
Cyril Hrubis
chrubis@suse.cz
