From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Jul 2016 16:03:19 +0200
Subject: [LTP] [PATCH] madvise06: wait a bit after madvise() call
In-Reply-To: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
References: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
Message-ID: <20160718140319.GA19087@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> madvise_willneed() only schedules I/O and does not
> wait for completion, so there is possibility for this
> testcase to fail occasionally.
> 
> This patch is introducing a small delay and checks the
> effect of madvise on more pages.

Looks good.

What is the reason for using more than one page? Does that increase the
likehood of triggering the issue?

Another idea may be to utilize bitflags from /proc/self/pagemap which
would be non-destructive way to get the present/swapped information.
Then we can do a short loop that polls these flags with much shorter
sleep, but the code would likely end up more complicated than this...

-- 
Cyril Hrubis
chrubis@suse.cz
