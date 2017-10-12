From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Oct 2017 15:14:45 +0200
Subject: [LTP] [PATCH 0/2] Updates to pthread_{barrier,cond}_destroy()
In-Reply-To: <20171009101824.17251-1-rpalethorpe@suse.com>
References: <20171009101824.17251-1-rpalethorpe@suse.com>
Message-ID: <20171012131445.GA21253@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> These tests do naturally include race conditions and waste time in calls to
> sleep, we could mitigate them by using another synchronisation mechanism (e.g
> TST_CHECKPOINT or fzsync), but not remove them completely. I'm not sure whether
> introducing LTP library functions into the POSIX tests is a good idea or not.

We try to avoid any Linux specific code in the Open Posix Testsuite and
generally try to stick only to POSIX APIs there. This is not always
possible though, so we have some code in include/ that is not portable
and has to be reimplemented per each Unix platform, for instance the
affinity.h. But we try to avoid that as much as we can, hence we do not
make use any of the LTP test library here, since quite a lot of the code
we have in there is Linux specific.

-- 
Cyril Hrubis
chrubis@suse.cz
