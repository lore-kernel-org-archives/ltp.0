From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Apr 2021 15:31:35 +0200
Subject: [LTP] [PATCH 2/2] syscalls/sendfile: Convert sendfile07 to the
 new API
In-Reply-To: <20210426084215.259071-3-xieziyao@huawei.com>
References: <20210426084215.259071-1-xieziyao@huawei.com>
 <20210426084215.259071-3-xieziyao@huawei.com>
Message-ID: <YIbAtwDn4YGukFGE@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've simplified the code a bit and pushed, thanks.

* The socketpair() can be opened with SOCKET_NONBLOCK
* Made use of tst_fill_file()
* Moved tst_brk() out of the for() loop
* Fixed some typos and simplified the doc comment

-- 
Cyril Hrubis
chrubis@suse.cz
