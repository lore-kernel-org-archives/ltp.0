From: xieziyao <xieziyao@huawei.com>
Date: Tue, 27 Apr 2021 02:07:43 +0000
Subject: [LTP] [PATCH 2/2] syscalls/sendfile: Convert sendfile07 to the
 new API
In-Reply-To: <YIbAtwDn4YGukFGE@yuki>
References: <20210426084215.259071-1-xieziyao@huawei.com>
 <20210426084215.259071-3-xieziyao@huawei.com> <YIbAtwDn4YGukFGE@yuki>
Message-ID: <469bfcb3d03f4380859b8bb3b0dfcc64@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Cyril,

Nice modification, thank you. I'll look at this type of interface function and pay attention next time.

Best Regards,
Ziyao

-----Original Message-----
From: Cyril Hrubis [mailto:chrubis@suse.cz] 
Sent: Monday, April 26, 2021 9:32 PM
To: xieziyao <xieziyao@huawei.com>
Cc: ltp@lists.linux.it
Subject: Re: [LTP][PATCH 2/2] syscalls/sendfile: Convert sendfile07 to the new API

Hi!
I've simplified the code a bit and pushed, thanks.

* The socketpair() can be opened with SOCKET_NONBLOCK
* Made use of tst_fill_file()
* Moved tst_brk() out of the for() loop
* Fixed some typos and simplified the doc comment

-- 
Cyril Hrubis
chrubis@suse.cz
