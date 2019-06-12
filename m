From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 Jun 2019 15:59:30 +0200
Subject: [LTP] [PATCH v2] syscalls/ioctl_ns0[156]: align stack and wait
 for child
In-Reply-To: <916c20b9a379badd37a85aa1e1339566c9807d23.1560248542.git.jstancek@redhat.com>
References: <916c20b9a379badd37a85aa1e1339566c9807d23.1560248542.git.jstancek@redhat.com>
Message-ID: <20190612135929.GA3048@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Test crashes (SIGBUS) when using child stack have been observed for
> ioctl_ns01. Align stack to 64 bytes for all testcases using clone,
> which should work for any arch.

Looking at the rest of the test it seems that all of them use malloc()
to allocate the child stack and depends on the libc to align the
buffers, maybe it would be easier to change these tests to use malloc()
as well.

> Add SIGCHLD to clone flags, so that LTP library can reap all children
> and check their return code.  Also check ltp_clone() return value.
> 
> Suppress warning for unused *arg in child().

The rest is OK.

-- 
Cyril Hrubis
chrubis@suse.cz
