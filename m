From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Sep 2018 14:28:47 +0200
Subject: [LTP] [PATCH] syscalls/mmap15: relax condition a bit
In-Reply-To: <1fbbf1d06b0e08fc2b078c0ad24f2dd2111348c3.1536827409.git.jstancek@redhat.com>
References: <1fbbf1d06b0e08fc2b078c0ad24f2dd2111348c3.1536827409.git.jstancek@redhat.com>
Message-ID: <20180913122847.GB18036@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> High address is arch specific, and it also occasionally changes
> as can be seen in history of this test.
> 
> Relax the condition and accept both ENOMEM and EINVAL
> as expected outcome.
> 
> Fixes: #390

I've already acked that on GitHub...

But just for a clarity, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
