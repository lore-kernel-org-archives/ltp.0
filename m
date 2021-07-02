From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Jul 2021 14:42:15 +0200
Subject: [LTP] [PATCH 2/2] fork08: Rewrite the test to a proper
 synchronization
In-Reply-To: <20210701032931.132468-3-xieziyao@huawei.com>
References: <20210701032931.132468-1-xieziyao@huawei.com>
 <20210701032931.132468-3-xieziyao@huawei.com>
Message-ID: <YN8Jp5iAVVjmU7js@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Can we please get rid of the FILE and use file descriptors instead?

Here as well the test is invalid since the whole file is read into libc
buffers on the first call to getc().

-- 
Cyril Hrubis
chrubis@suse.cz
