From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Jan 2019 14:27:45 +0100
Subject: [LTP] [PATCH] [COMMITTED] syscalls/fadvise: Fix regression
In-Reply-To: <20190111132049.32121-1-chrubis@suse.cz>
References: <20190111132049.32121-1-chrubis@suse.cz>
Message-ID: <20190111132745.GB32178@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> These test were disabled from execution without _FILE_OFFSET_BITS != 64
> since their conversion into the new library. The problem is that we
> didn't copied the original condition correctly. Originally the tests
> were disabled in case of:
> 
> if ((_FILE_OFFSET_BITS != 64) && (__NR_fadvise64 == 0))
> 
> While after the change they were disabled in case of:

If you are wonder if there is something missing here, yes it is,
apparently I've been biten by the fact that git removes all lines
starting with hash (#) from commit messages.

So the line missing here is:

#if (_FILE_OFFSET_BITS != 64)

-- 
Cyril Hrubis
chrubis@suse.cz
