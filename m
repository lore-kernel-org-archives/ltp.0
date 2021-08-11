From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Wed, 11 Aug 2021 12:04:20 +0200
Subject: [LTP] [PATCH] controllers: detect previous test failure on
 cgroup mounts
In-Reply-To: <20210720150520.17612-1-krzysztof.kozlowski@canonical.com>
References: <20210720150520.17612-1-krzysztof.kozlowski@canonical.com>
Message-ID: <448ccb00-8499-40a8-4234-52e1e49a0760@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20/07/2021 17:05, Krzysztof Kozlowski wrote:
> The failure of memcg_stress_test.sh cleanup went unnoticed (except
> echo message) and caused further cgroup_fj and memcg_control_test
> failures because of unclean cgroups. Flow is usually like:
> 
> 1. memcg_stress_test succeeds but actually the /dev/memcg was not
>    cleaned up. Notice lack of any error message due to 2>/dev/null.
> 
>      memcg_stress_test 1 TINFO: Testing 150 cgroups, using 1273 MB, interval 5
>      memcg_stress_test 1 TINFO: Starting cgroups
>      memcg_stress_test 1 TINFO: Testing cgroups for 900s
>      memcg_stress_test 1 TINFO: Killing groups
>      tag=memcg_stress stime=1626770787 dur=903 exit=exited stat=2 core=no cu=19 cs=12
> 
> 2. memcg_control_test has false-positive. It succeeds but actually no
>    test was done due to /dev/memcg pollution from previous test:
> 
>      mkdir: cannot create directory ?/tmp/ltp-q8DjShPJeB/mnt/1?: File exists
>      memcg_control    0  TINFO  :  Test #1: Checking if the memory usage limit imposed by the topmost group is enforced
>      sh: echo: I/O error
>      /opt/ltp/testcases/bin/memcg_control_test.sh: 86: /opt/ltp/testcases/bin/memcg_control_test.sh: cannot create /tmp/ltp-q8DjShPJeB/mnt/1/memory.memsw.limit_in_bytes:
>      Permission denied
>      rmdir: failed to remove 'sub': Device or resource busy
>      rmdir: failed to remove '/tmp/ltp-q8DjShPJeB/mnt/1': Device or resource busy
>      memcg_control    1  TPASS  :  memcg_control: passed
>      tag=memcg_control stime=1626771695 dur=6 exit=exited stat=0 core=no cu=2 cs=1
> 
> 3. cgroup_fj_function2_memory fails with a cryptic message of mounting a
>    path with new line (because /dev/memcg was not cleaned up before):
> 
>      cgroup_fj_function2_memory 1 TINFO: Subsystem memory is mounted at /sys/fs/cgroup/memory
>      /dev/memcg
>      mkdir: cannot create directory ?/sys/fs/cgroup/memory?: File exists
>      cgroup_fj_function2_memory 1 TBROK: mkdir /sys/fs/cgroup/memory
>      /dev/memcg/ltp failed
>      cgroup_fj_function2_memory 1 TINFO: Removing all ltp subgroups...
>      find: ?/sys/fs/cgroup/memory\n/dev/memcg/ltp/?: No such file or directory
> 
> The actual failure was in memcg_stress_test executed before other tests,
> however it went unnoticed.  Debugging such failures is difficult as
> result of failing test depends on running another which did not fail.
> Instead, detect unclean cgroups mounts and explicitly test it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../kernel/controllers/cgroup_fj/cgroup_fj_common.sh   |  4 ++--
>  .../controllers/memcg/control/memcg_control_test.sh    | 10 ++++++----
>  .../controllers/memcg/stress/memcg_stress_test.sh      |  8 ++++----
>  3 files changed, 12 insertions(+), 10 deletions(-)
> 

Hi all,

Any comments here?

Best regards,
Krzysztof
