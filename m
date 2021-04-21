From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Apr 2021 14:35:23 +0200
Subject: [LTP] [PATCH] syscalls/sendfile: Delete unnecessary loop logic
 in do_child()
In-Reply-To: <20210420133839.145408-1-xieziyao@huawei.com>
References: <20210420133839.145408-1-xieziyao@huawei.com>
Message-ID: <YIAcC1DaWciwSypB@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looking at the code the sendfile04 and sendfile05 does not need 99% of
the code in the tests, as a matter of fact it even breaks the tests with
sufficiently large -i parameter.

Can we please instead remove all the server and socket code from
sendfile04 and sendfile05? We can just easily pass in_fd and out_fd
pointing to a regular files to the sendfile() syscall instead.

-- 
Cyril Hrubis
chrubis@suse.cz
