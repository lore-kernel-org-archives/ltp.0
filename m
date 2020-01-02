From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Jan 2020 13:57:59 +0100
Subject: [LTP] [PATCH COMMITTED] tst_device: do sync() before reading
 test block device stat file
In-Reply-To: <20200102015236.7400-1-liwang@redhat.com>
References: <20200102015236.7400-1-liwang@redhat.com>
Message-ID: <20200102125759.GE32710@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> To avoid FS deferred IO metadata/cache interferes test result, so we
> do sync simply before the tst_dev_bytes_written invocation.

Can we do fsync() on the fd instead of full sync()? That should be
slightly faster.

-- 
Cyril Hrubis
chrubis@suse.cz
