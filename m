From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Mar 2016 17:15:46 +0100
Subject: [LTP] [PATCH] lib/tst_rmdir.c: close TESTDIR files before
	rmobj()
In-Reply-To: <1458228954-28372-1-git-send-email-alexey.kodanev@oracle.com>
References: <1458228954-28372-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160317161546.GB31815@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> NFS creates special .nfs* files when test file was removed and
> left open. In that case, tst_rmdir() fails to remove test dirs:

This is the reason why we state in test writing guidelines that all open
file descriptors should be closed in the cleanup() function.

I'm not sure that it's a good idea to close them in the library this
way.

-- 
Cyril Hrubis
chrubis@suse.cz
