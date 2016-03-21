From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Mar 2016 14:04:39 +0100
Subject: [LTP] [PATCH] syscalls: close open files in cleanup
In-Reply-To: <1458309428-16300-1-git-send-email-alexey.kodanev@oracle.com>
References: <1458309428-16300-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160321130439.GA1022@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> NFS creates special .nfs* files when test file was removed and
> left open. In that case, tst_rmdir() fails to remove test dirs.
> 
> Close left open files in cleanup and replace some of safe_open()
> calls with safe_file_printf() ones for test files which fd won't
> be used in a test.

I would be closing the file descriptors only if they were initialized
with value > 0, since otherwise there would be misleading failing close
in the strace in case that some setup step prior to the SAFE_OPEN()
failed.

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
