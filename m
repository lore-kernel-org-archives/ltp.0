From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Jan 2020 14:08:46 +0100
Subject: [LTP] [iomap] 3af5053534:
 WARNING:at_fs/iomap/buffered-io.c:#iomap_readpages
In-Reply-To: <20191219134725.GE2760@shao2-debian>
References: <20191219134725.GE2760@shao2-debian>
Message-ID: <20200102130846.GF32710@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looks like FALLOC_FL_ZERO_RANGE fails, at least that's where the test
reports wrong bytes in the file.

The source code of the test:

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fallocate/fallocate04.c#L157


-- 
Cyril Hrubis
chrubis@suse.cz
