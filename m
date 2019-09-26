From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Sep 2019 14:17:44 +0200
Subject: [LTP] [PATCH] syscalls/bpf: auto bump RLIMIT_MEMLOCK
In-Reply-To: <a9fc2ff0c27317ae8ac2d56a819eeac5a281dd86.1569496399.git.jstancek@redhat.com>
References: <a9fc2ff0c27317ae8ac2d56a819eeac5a281dd86.1569496399.git.jstancek@redhat.com>
Message-ID: <20190926121744.GC13769@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> eBPF tests may fail (-EPERM) if max locked memory limit is too low.
> User-space tools such as perf started increasing MELOCK limit to
> avoid this problem.
> 
> LTP follows same approach and will attempt to raise RLIMIT_MEMLOCK
> if possible, otherwise prints an info message.
> 
> Link: http://lists.linux.it/pipermail/ltp/2019-August/013349.html
> Link: https://lkml.org/lkml/2019/7/17/714
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Looks good, acked.

Also have you had a look at the eBPF regression test?

Do you mind if I push that before the release (with added call to adjust
the memlock limit)?

-- 
Cyril Hrubis
chrubis@suse.cz
