From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 11 Jun 2020 07:18:12 -0400 (EDT)
Subject: [LTP] [PATCH v2] Added test case to test mmap with
 MAP_FIXED_NOREPLACE flag
In-Reply-To: <20200609044641.3623-1-kushalchand@zilogic.com>
References: <20200609044641.3623-1-kushalchand@zilogic.com>
Message-ID: <433506763.15617153.1591874292012.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> This patch adds a new test case for the mmap syscall. It tests the
> MAP_FIXED_NOREPLACE flag of mmap. The code checks if MAP_FIXED_NOREPLACE
> returns with EEXIST when mapped with an already mapped address. It does
> so by allocating an available address by passing NULL to first argument
> of mmap and tries to mmap with MAP_FIXED_NOREPLACE flag at the same
> address returned by the first mmap call. This fails as expected. It also
> does the necessary changes required to run the syscall using the runltp
> command after building the LTP test suite.
> Git Hub Issue link - https://github.com/linux-test-project/ltp/issues/299
> 
> Signed-off-by: Kushal Chand <kushalchand@zilogic.com>
> Reviewed-by: Vijay Kumar B. <vijaykumar@zilogic.com>

Added include to lapi/mmap.h, slightly modified commit message and pushed.

Thanks,
Jan

