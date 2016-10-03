From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 3 Oct 2016 16:58:35 +0200
Subject: [LTP] new shell library
Message-ID: <20161003145835.GD7583@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've played bit with the shell test library in order to make it more
aligned with the C library, have a look at:

https://github.com/metan-ucw/ltp

So far I've converted all testcases in commands/ directory, you can have
a look at last 12 commits in the repo to see how the new shell library
and testcases looks like. I would love to get someone to review the code
before I attempt to convert more testcases.

-- 
Cyril Hrubis
chrubis@suse.cz
