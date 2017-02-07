From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Feb 2017 16:12:43 +0100
Subject: [LTP] [lkp-robot] [fs] 99f64a2676: ltp.creat08.fail &
 ltp.open10.fail
In-Reply-To: <20170206025942.GC21111@yexl-desktop>
References: <20170206025942.GC21111@yexl-desktop>
Message-ID: <20170207151219.GA3595@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> FYI, we noticed the following commit:
> 
> commit: 99f64a2676f0bec4ad32e39fc76eb0914ee091b8 ("fs: Harden against open(..., O_CREAT, 02777) in a setgid directory")
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git vfs/suid
> 
> in testcase: ltp
> with following parameters:
> 
> 	test: ltplite
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/

Looking at the testcases in question these are testing exactly the
corner case the patch is fixing.

So the tests needs to be fixed once this patch hits mainline. And the
best fix is to expect the SGID flag to be cleared on newer kernels.

-- 
Cyril Hrubis
chrubis@suse.cz
