From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Sep 2021 17:13:04 +0200
Subject: [LTP] [PATCH] controllers: detect previous test failure on
 cgroup mounts
In-Reply-To: <20210720150520.17612-1-krzysztof.kozlowski@canonical.com>
References: <20210720150520.17612-1-krzysztof.kozlowski@canonical.com>
Message-ID: <YTjTAG4bFHce9QTu@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../kernel/controllers/cgroup_fj/cgroup_fj_common.sh   |  4 ++--
>  .../controllers/memcg/control/memcg_control_test.sh    | 10 ++++++----
>  .../controllers/memcg/stress/memcg_stress_test.sh      |  8 ++++----
>  3 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> index 5594fe9de426..53ab637e8910 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> @@ -123,10 +123,10 @@ cleanup()
>      fi
>  
>      if grep -q "$mount_point" /proc/mounts; then
> -        umount "$mount_point"
> +        EXPECT_PASS umount "$mount_point"
>      fi
>  
>      if [ -e "$mount_point" ]; then
> -        rmdir "$mount_point"
> +        EXPECT_PASS rmdir "$mount_point"
>      fi
>  }
> diff --git a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> index 4d9f1bb5d586..626f5e676831 100644
> --- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> +++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
> @@ -53,6 +53,8 @@ STATUS_PIPE="$TMP/status_pipe"
>  PASS=0
>  FAIL=1
>  
> +. test.sh

We cannot casually include the test.sh in testcases that does not use
the shell library as that will change the behavior of the tst_ commands.

Due to historicall reason we have two sets of tst_resm/tst_brkm/..., one
set are actuall binaries with the tst_foo name and the second set is
provided by the test.sh library. It's unfortunate but the binary
commands are still used in a few places and it's hard to even find out
where, since we have to look for shell scripts that does not source
(even indirectly test.sh) but use the tst_resm interfaces.

So unless you have reviewed the test carefully and made sure that it
works well with the test.sh library this will possibly introduce subtle
breakage.

The changes in the other two shell scripts looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
