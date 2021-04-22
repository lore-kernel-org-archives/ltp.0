From: xieziyao <xieziyao@huawei.com>
Date: Thu, 22 Apr 2021 07:13:07 +0000
Subject: [LTP] [PATCH] syscalls/sendfile: Delete unnecessary loop logic
 in do_child()
In-Reply-To: <YIAcC1DaWciwSypB@yuki>
References: <20210420133839.145408-1-xieziyao@huawei.com>
 <YIAcC1DaWciwSypB@yuki>
Message-ID: <6a0e879465f943fb8f2f09af3326adfc@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

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
