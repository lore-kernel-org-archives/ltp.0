From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 22 Jan 2020 14:06:32 +0530
Subject: [LTP] [PATCH 2/2] syscalls/pidfd_open
In-Reply-To: <20200122051233.naobo3bb4jrk63of@vireshk-i7>
References: <b4f5242fdca1659b2f71e1b3290fd32194e7340a.1579259595.git.viresh.kumar@linaro.org>
 <4dd4dabd2cd574dc2657c5926e8e3d1a0c8a8ae6.1579259595.git.viresh.kumar@linaro.org>
 <20200121153928.GA12370@rei>
 <20200122051233.naobo3bb4jrk63of@vireshk-i7>
Message-ID: <20200122083632.spw7okh6g6c77p5q@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 22-01-20, 10:42, Viresh Kumar wrote:
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Thu, 16 Jan 2020 16:47:01 +0530
> Subject: [PATCH] syscalls/pidfd_open
> 
> Add tests to check working of pidfd_open() syscall.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  configure.ac                                  |  1 +
>  include/lapi/pidfd_open.h                     | 21 ++++++
>  runtest/syscalls                              |  3 +
>  .../kernel/syscalls/pidfd_open/.gitignore     |  2 +
>  testcases/kernel/syscalls/pidfd_open/Makefile |  6 ++
>  .../kernel/syscalls/pidfd_open/pidfd_open01.c | 38 +++++++++++
>  .../kernel/syscalls/pidfd_open/pidfd_open02.c | 45 +++++++++++++
>  .../kernel/syscalls/pidfd_open/pidfd_open03.c | 64 +++++++++++++++++++
>  8 files changed, 180 insertions(+)
>  create mode 100644 include/lapi/pidfd_open.h
>  create mode 100644 testcases/kernel/syscalls/pidfd_open/.gitignore
>  create mode 100644 testcases/kernel/syscalls/pidfd_open/Makefile
>  create mode 100644 testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
>  create mode 100644 testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
>  create mode 100644 testcases/kernel/syscalls/pidfd_open/pidfd_open03.c

+ this as well (I will resent the patches properly again after you
have had a chance to look at them once).

diff --git a/runtest/syscalls b/runtest/syscalls
index 9d6d288780a3..a2d749d526a8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -848,6 +848,7 @@ personality02 personality02
 
 pidfd_open01 pidfd_open01
 pidfd_open02 pidfd_open02
+pidfd_open03 pidfd_open03
 
 pidfd_send_signal01 pidfd_send_signal01
 pidfd_send_signal02 pidfd_send_signal02
diff --git a/testcases/kernel/syscalls/pidfd_open/.gitignore b/testcases/kernel/syscalls/pidfd_open/.gitignore
index be218f88647d..e0b8900c1c33 100644
--- a/testcases/kernel/syscalls/pidfd_open/.gitignore
+++ b/testcases/kernel/syscalls/pidfd_open/.gitignore
@@ -1,2 +1,3 @@
 pidfd_open01
 pidfd_open02
+pidfd_open03

-- 
viresh
