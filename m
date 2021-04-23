From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 23 Apr 2021 15:32:14 +0200
Subject: [LTP] [PATCH] syscalls/sendfile: Delete unnecessary loop logic
 in do_child()
In-Reply-To: <6ff9d783d70a4c4f91fe3dca0a948833@huawei.com>
References: <20210420133839.145408-1-xieziyao@huawei.com>
 <YIAcC1DaWciwSypB@yuki>
 <6ff9d783d70a4c4f91fe3dca0a948833@huawei.com>
Message-ID: <YILMXkSAGkWvgocy@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> And I think the other testcases of the sendfile testsuite have the
> same problem. Can we please modify other testcases in the same way?

Yes please, at least sendfile03, sendfile07 should be cleand up the same
way as the sendfile04 and sendfile05 were.

The rest of the tests seems to actually transfer data, but the code is
really messy so they should be cleaned up and converted to new library
as well.

-- 
Cyril Hrubis
chrubis@suse.cz
