From: Steve Ellcey <sellcey@caviumnetworks.com>
Date: Thu, 23 Mar 2017 10:20:47 -0700
Subject: [LTP] Did it pass or did it fail
In-Reply-To: <20170323092823.GB351@rei.lan>
References: <201703222217.v2MMH5ZX029117@sellcey-dt.caveonetworks.com>
 <20170323092823.GB351@rei.lan>
Message-ID: <1490289647.19074.49.camel@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 2017-03-23 at 10:28 +0100, Cyril Hrubis wrote:
> 
> > '/sys/fs/cgroup/memory/ltp_madvise09_20474//memory.memsw.limit_in_b
> > ytes' for reading at madvise09.c:190: ENOENT
> > madvise09.c:289: BROK: Child exitted unexpectedly
> This means that the test had an internal error. Looking at the message
> it looks like memory cgroup file is missing. What kernel version do you
> have?

I was testing a 4.5 kernel (with local modifications).

Steve Ellcey
