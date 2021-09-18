From: Xiao Yang <ice_yangxiao@163.com>
Date: Sat, 18 Sep 2021 18:39:15 +0800
Subject: [LTP] [PATCH v4 5/5] syscalls/dup2: rename dup205 to dup204
In-Reply-To: <20210918072609.8576-6-qi.fuli@fujitsu.com>
References: <20210918072609.8576-1-qi.fuli@fujitsu.com>
 <20210918072609.8576-6-qi.fuli@fujitsu.com>
Message-ID: <5038c65d-80ab-ee73-b3d7-a13cb5194851@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch looks good to me.

On 9/18/21 3:26 PM, QI Fuli wrote:
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> ---
>   runtest/syscalls                                      | 1 -
>   testcases/kernel/syscalls/dup2/.gitignore             | 1 -
>   testcases/kernel/syscalls/dup2/Makefile               | 2 +-
>   testcases/kernel/syscalls/dup2/{dup205.c => dup204.c} | 0
>   4 files changed, 1 insertion(+), 3 deletions(-)
>   rename testcases/kernel/syscalls/dup2/{dup205.c => dup204.c} (100%)
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 29d7752c7..75304f2f1 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -152,7 +152,6 @@ dup201 dup201
>   dup202 dup202
>   dup203 dup203
>   dup204 dup204
> -dup205 dup205
>   
>   dup3_01 dup3_01
>   dup3_02 dup3_02
> diff --git a/testcases/kernel/syscalls/dup2/.gitignore b/testcases/kernel/syscalls/dup2/.gitignore
> index 6c4685b80..0c9a8cd75 100644
> --- a/testcases/kernel/syscalls/dup2/.gitignore
> +++ b/testcases/kernel/syscalls/dup2/.gitignore
> @@ -2,4 +2,3 @@
>   /dup202
>   /dup203
>   /dup204
> -/dup205
> diff --git a/testcases/kernel/syscalls/dup2/Makefile b/testcases/kernel/syscalls/dup2/Makefile
> index 28fc158e4..fcdd146b7 100644
> --- a/testcases/kernel/syscalls/dup2/Makefile
> +++ b/testcases/kernel/syscalls/dup2/Makefile
> @@ -6,7 +6,7 @@ top_srcdir		?= ../../../..
>   include $(top_srcdir)/include/mk/testcases.mk
>   
>   ifeq ($(ANDROID),1)
> -FILTER_OUT_MAKE_TARGETS	+= dup201 dup205
> +FILTER_OUT_MAKE_TARGETS	+= dup201 dup204
>   endif
>   
>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup204.c
> similarity index 100%
> rename from testcases/kernel/syscalls/dup2/dup205.c
> rename to testcases/kernel/syscalls/dup2/dup204.c

