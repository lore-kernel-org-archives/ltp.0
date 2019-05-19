From: Sandeep Patil <sspatil@android.com>
Date: Sun, 19 May 2019 15:21:38 -0700
Subject: [LTP] [PATCH 4/5] syscalls/bdflush01: delete bdflush test
In-Reply-To: <20190519003808.47425-5-sspatil@android.com>
References: <20190519003808.47425-1-sspatil@android.com>
 <20190519003808.47425-5-sspatil@android.com>
Message-ID: <20190519222138.GF209259@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, May 18, 2019 at 05:38:07PM -0700, Sandeep Patil wrote:
> The manual says the system call is deprecated since Linux 2.6
> and does nothing. So, remove the test.
> 
> Signed-off-by: Sandeep Patil <sspatil@android.com>
> ---
>  testcases/kernel/syscalls/bdflush/.gitignore  |   1 -
>  testcases/kernel/syscalls/bdflush/Makefile    |  23 ----
>  testcases/kernel/syscalls/bdflush/bdflush01.c | 126 ------------------
>  3 files changed, 150 deletions(-)
>  delete mode 100644 testcases/kernel/syscalls/bdflush/.gitignore
>  delete mode 100644 testcases/kernel/syscalls/bdflush/Makefile
>  delete mode 100644 testcases/kernel/syscalls/bdflush/bdflush01.c

It seems I've missed removing 'bdflush01' from runtest. I will send a v2 with
that, if you can look at other patches in the mean time.

- ssp
