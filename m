From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Mar 2019 13:28:52 +0100
Subject: [LTP] [PATCH RFC] lib: invoke do_cleanup if failed to kill test
 processes
In-Reply-To: <20190315061733.24938-1-liwang@redhat.com>
References: <20190315061733.24938-1-liwang@redhat.com>
Message-ID: <20190318122851.GC10187@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> LTP liabary should invoke do_cleanup function promptly when killing
> test process doesn't work, especially useful to testcase do mount or
> format devices in their setup phase. Otherwise, that abnormal broken
> will effect the testcase which LTP is preparing to execute in next.

Actually this code should be executed only if the test process got stuck
in the kernel and in such case I doubt that there is a value in doing
the cleanup as the cleanup code will likely get stuck there as well.

The rationale is that if process that uses particular mount point is
stuck in the kernel the umount() will likely get stuck there as well and
there is no point in doing anything else than rebooting the machine.

-- 
Cyril Hrubis
chrubis@suse.cz
