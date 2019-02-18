From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Feb 2019 16:25:22 +0100
Subject: [LTP] [PATCH v2] readdir: delete readdir02
In-Reply-To: <20190216075458.3418-1-liwang@redhat.com>
References: <20190216075458.3418-1-liwang@redhat.com>
Message-ID: <20190218152522.GD25025@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  testcases/kernel/syscalls/readdir/readdir02.c | 142 ------------------
>  1 file changed, 142 deletions(-)
>  delete mode 100644 testcases/kernel/syscalls/readdir/readdir02.c

You have to remove the runtest entry as well, otherwise this will report
error because the runltp will try to execute nonexisting test.

There is also a .gitignore entry that should be removed along with this.

Other than that this is good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
