From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Apr 2021 14:23:33 +0200
Subject: [LTP] [PATCH 3/3 v2] syscalls/close: Convert close08 to the new
 API
In-Reply-To: <20210426125224.150268-4-xieziyao@huawei.com>
References: <20210426125224.150268-1-xieziyao@huawei.com>
 <20210426125224.150268-4-xieziyao@huawei.com>
Message-ID: <YIgCRbFZ81vX4KfA@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Isn't this test just the same as close01.c?

I think that we can just remove close08.c since it does not add any more
coverage over close01.

Also we can add all kind of other file descriptor to the close01.c test
as well. We should add at least a few different socket fds there as well.

-- 
Cyril Hrubis
chrubis@suse.cz
