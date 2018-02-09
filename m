From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 9 Feb 2018 17:08:42 +0100
Subject: [LTP] [PATCH] Add regression test for CVE-2017-17053
In-Reply-To: <20180209154410.aoy63rbcygw5tzn6@linux.suse>
References: <20180126143700.29609-1-mmoese@suse.de>
 <20180209153001.GA28203@rei>
 <20180209154410.aoy63rbcygw5tzn6@linux.suse>
Message-ID: <20180209160842.GB28203@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > SAFE_SIGNAL(SIGSEGV, handler) as well?
> I thought about it, but that would use signal(). Using signal should in
> general be avoided in a multithreaded programm (see man signal). 

Ah, you are right, we have to use sigaction() anyways.

I do not think that anything bad will happen if we use signal() before
we start the threads though.

And we may as well add SAFE_SIGACTION() to the test library.

-- 
Cyril Hrubis
chrubis@suse.cz
