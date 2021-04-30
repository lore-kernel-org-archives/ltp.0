From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Apr 2021 15:12:28 +0200
Subject: [LTP] [PATCH 3/4] syscalls/getpgid01: Replace TINFO with TPASS
 or TFAIL
In-Reply-To: <20210429125237.31461-1-zhaogongyi@huawei.com>
References: <20210429125237.31461-1-zhaogongyi@huawei.com>
Message-ID: <YIwCPEcwpzEim3yS@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've applied the patch since ti makes the code better but the test is
still completely broken.

The problem is that the whole test is being executed in a child process
while the parent does wait() on it but it does not propagate the
failures at all as it just does exit(0) at the end of the parent
process. And there are other subtle bugs in the code.

All in all the easiest way how to fix this would be simply rewriting the
test to the new library where no result propagation has to be done.

-- 
Cyril Hrubis
chrubis@suse.cz
