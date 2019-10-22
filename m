From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Oct 2019 16:36:04 +0200
Subject: [LTP] EPERM failures for repeated runs
Message-ID: <20191022143604.GA18468@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Lately we started to write BPF testcases for LTP and after writing a
first few tests we found out that running more than a few in a row
causes them to fail with EPERM.

The culprit is deferred cleanup of the bpf maps that are locked in the
memory, see:

http://lists.linux.it/pipermail/ltp/2019-August/013349.html

We worked around that by bumping the limit for the tests in:

https://github.com/linux-test-project/ltp/commit/85c4e886b357f7844f6ab8ec5719168c38703a76

But it looks like this value will not scale, especially for
architectures that have larger than 4k pages, running four BPF tests in
a row still fails on ppc64le even with the increased limit.

Perhaps I'm naive but can't we check, in the kernel, if there is
deferred cleanup in progress if we fail to lock memory for a map and
retry once it's done?

Or is this intended behavior and should we retry on EPERM in userspace?

-- 
Cyril Hrubis
chrubis@suse.cz
