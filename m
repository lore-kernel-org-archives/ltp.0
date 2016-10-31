From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 31 Oct 2016 12:26:02 +0100
Subject: [LTP] [PATCH 1/3] syscalls/umask01: Cleanup && Convert to new
	API
In-Reply-To: <1477882478-30693-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1477882478-30693-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20161031112602.GG30590@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I guess that this test should be just removed since umask() cannot fail
at all.

To cite the manual page:

...

RETURN VALUE
       This system call always succeeds and the previous value of the
       mask is returned.

...


-- 
Cyril Hrubis
chrubis@suse.cz
