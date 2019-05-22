From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 May 2019 16:56:07 +0200
Subject: [LTP] [PATCH v2] syscalls/bdflush01: delete bdflush test
In-Reply-To: <20190519233327.249118-1-sspatil@android.com>
References: <20190519003808.47425-5-sspatil@android.com>
 <20190519233327.249118-1-sspatil@android.com>
Message-ID: <20190522145607.GA25727@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The manual says the system call is deprecated since Linux 2.6
> and does nothing. So, remove the test.

Applied, thanks.

And actually looking into the kernel sources the syscall stub is still
there on a subset of architectures, i.e. these that Linux was ported to
before 2.6 with a comment that it will be removed see fs/buffer.c. Maybe
it's a time to remove that stub as well...

-- 
Cyril Hrubis
chrubis@suse.cz
