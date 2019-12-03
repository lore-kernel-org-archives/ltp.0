From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Dec 2019 13:32:05 +0100
Subject: [LTP] ??? FAIL: Test report for kernel 5.3.14-d6885f7.cki
 (stable-queue)
In-Reply-To: <cki.37B8559E6E.L9FDDMGAEJ@redhat.com>
References: <cki.37B8559E6E.L9FDDMGAEJ@redhat.com>
Message-ID: <20191203123205.GE2844@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> We ran automated tests on a recent commit from this kernel tree:
> 
>        Kernel repo: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
>             Commit: d6885f794222 - i40e: Fix for ethtool -m issue on X722 NIC
> 
> The results of these automated tests are provided below.
> 
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>              Tests: FAILED
> 
> All kernel binaries, config files, and logs are available for download here:
> 
>   https://artifacts.cki-project.org/pipelines/319850
> 
> One or more kernel tests failed:
> 
>     ppc64le:
>      ??? LTP

This is another ppc64le failure on a driver commit, my guess is that
something is corrupting memory on ppc64le which trips on random commits
and random tests.

-- 
Cyril Hrubis
chrubis@suse.cz
