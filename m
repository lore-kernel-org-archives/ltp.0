From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Apr 2021 16:07:43 +0200
Subject: [LTP] [PATCH 2/2] syscalls/unshare: convert unshare02 to the
 new API
In-Reply-To: <20210419122246.7706-3-xieziyao@huawei.com>
References: <20210419122246.7706-1-xieziyao@huawei.com>
 <20210419122246.7706-3-xieziyao@huawei.com>
Message-ID: <YH2OrwsqdO231sNB@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 1. Convert unshare02 to the new API;
> 2. Check whether the returned value is correct in the child process
> instead of the parent process;
> 3. Add a test case: use the CLONE_NEWNS parameter as a non-root user
> and the expected return value is EPERM.

The EPERM check fails if the test is executed by a root. LTP tests
usually setuid() to "nobody" for EPERM tests if executed as a root.

The TC should be lowercase but that is very minor.

Apart from these it's a really good cleanup.

-- 
Cyril Hrubis
chrubis@suse.cz
