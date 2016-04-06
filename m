From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Apr 2016 17:20:20 +0200
Subject: [LTP] [PATCH] syscalls/fcntl: add new test for open file
 description locks
In-Reply-To: <5705261A.10803@oracle.com>
References: <1458033988-15881-1-git-send-email-alexey.kodanev@oracle.com>
 <5705261A.10803@oracle.com>
Message-ID: <20160406152020.GB10599@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > OFD lock is available since Linux 3.15 and new F_OFD_* macros
> > added to lapi/fcntl.h
> >
> > Test is based on [1] article and checks that OFD locks can
> > syncronise access to a file between multiple threads.
> >
> > [1] https://lwn.net/Articles/586904
> 
> Any comments?

Sorry I've missed this one, will have a look asap.

-- 
Cyril Hrubis
chrubis@suse.cz
