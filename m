From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Aug 2016 18:41:18 +0200
Subject: [LTP] [PATCH] mkswap: make the test device size is aligned to
 pagesize
In-Reply-To: <1469613519-27167-1-git-send-email-liwang@redhat.com>
References: <1469613519-27167-1-git-send-email-liwang@redhat.com>
Message-ID: <20160809164118.GA27028@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We get failures like below because of 'DEVICE_SIZE-10000' makes the
> loop device size is not aligned to system PAGE_SIZE any more.

What version of mkswap.c you have?

Looking into util-linux-2.26.2 all it does with user specified number of
blocks is:

ctl.npages = blks / (ctl.pagesize / 1024);

There is no check that blks is divideable by pagesize/1024.

-- 
Cyril Hrubis
chrubis@suse.cz
