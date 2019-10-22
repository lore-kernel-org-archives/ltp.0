From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Oct 2019 13:37:04 +0200
Subject: [LTP] [PATCH] thp02: simplify test to lower memory requirements
In-Reply-To: <651aa5d59504efe89ee8428afd95fe90a9bbea38.1571412608.git.jstancek@redhat.com>
References: <651aa5d59504efe89ee8428afd95fe90a9bbea38.1571412608.git.jstancek@redhat.com>
Message-ID: <20191022113704.GA13757@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Test is using 4 hugepages per allocation, and makes 4*3 allocations
> in total. This is problem for aarch64, where default huge page size
> is 512M. Systems are running into unexpected OOMs, because there
> is no check for available memory.
> 
> Simplify test by:
> - dropping 3rd allocation, it's used only for pattern comparison
> - run test function in new child process, so we don't need to worry
>   about cleaning up after mremap() and it lowers overall memory
>   requirements
> - add a simple check if there's enough memory to setup()
> - drop .needs_root, there's no need for it

Looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
