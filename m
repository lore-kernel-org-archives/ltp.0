From: xieziyao <xieziyao@huawei.com>
Date: Fri, 23 Apr 2021 10:14:38 +0000
Subject: [LTP] [PATCH] syscalls/sendfile: Delete unnecessary loop logic
 in do_child()
References: <20210420133839.145408-1-xieziyao@huawei.com>
 <YIAcC1DaWciwSypB@yuki> 
Message-ID: <6ff9d783d70a4c4f91fe3dca0a948833@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Cyril,

I just made changes to sendfile04 and sendfile05 on your suggestions:
1. Convert sendfile04 to the new API;
2. Remove the socket code of server/client and use SAFE_SOCKETPAIR() instead, which can simplify the code logic.

And I think the other testcases of the sendfile testsuite have the same problem. Can we please modify other testcases in the same way?

Please see: https://patchwork.ozlabs.org/project/ltp/list/?series=240489

Best Regards,
Ziyao

-----Original Message-----
From: xieziyao 
Sent: Thursday, April 22, 2021 3:13 PM
To: 'Cyril Hrubis' <chrubis@suse.cz>
Cc: ltp@lists.linux.it
Subject: RE: [LTP] [PATCH] syscalls/sendfile: Delete unnecessary loop logic in do_child()

Of course, I'm interested in modifying the testcases that way, and I'll submit another version to fix the problem.

Thanks for your review, Cyril.

Best Regards,
Ziyao

-----Original Message-----
From: Cyril Hrubis [mailto:chrubis@suse.cz] 
Sent: Wednesday, April 21, 2021 8:35 PM
To: xieziyao <xieziyao@huawei.com>
Cc: ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] syscalls/sendfile: Delete unnecessary loop logic in do_child()

Hi!
Looking at the code the sendfile04 and sendfile05 does not need 99% of the code in the tests, as a matter of fact it even breaks the tests with sufficiently large -i parameter.

Can we please instead remove all the server and socket code from
sendfile04 and sendfile05? We can just easily pass in_fd and out_fd pointing to a regular files to the sendfile() syscall instead.

--
Cyril Hrubis
chrubis@suse.cz
