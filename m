From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Apr 2018 17:41:43 +0200
Subject: [LTP] [PATCH] syscalls/inotify06: bump timeout
In-Reply-To: <96166bd70a154ff7a440a8fabb8cb3395d6f5ce3.1523629313.git.jstancek@redhat.com>
References: <96166bd70a154ff7a440a8fabb8cb3395d6f5ce3.1523629313.git.jstancek@redhat.com>
Message-ID: <20180413154143.GB25041@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> After migrating this test to newlib, there's now
> a default timeout and it's not enough for some
> systems.

I would consider that obvious enough to go directly to the git,
acked nevertheless.

-- 
Cyril Hrubis
chrubis@suse.cz
