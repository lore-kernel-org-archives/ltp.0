From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 21 Oct 2020 12:52:22 +0530
Subject: [LTP] [PATCH V2 17/17] futex: Move variants struct definition
 to common header
In-Reply-To: <aea25607851ab94a0cc69ea3d7213e47d1d6c94e.1600252542.git.viresh.kumar@linaro.org>
References: <cover.1600252542.git.viresh.kumar@linaro.org>
 <aea25607851ab94a0cc69ea3d7213e47d1d6c94e.1600252542.git.viresh.kumar@linaro.org>
Message-ID: <20201021072222.c47cnqee2mesdzcs@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16-09-20, 16:08, Viresh Kumar wrote:
> Use a single definition of the structure and move it to a common place.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../kernel/syscalls/futex/futex_cmp_requeue01.c    | 12 ++++--------
>  .../kernel/syscalls/futex/futex_cmp_requeue02.c    |  9 +++------
>  testcases/kernel/syscalls/futex/futex_wait01.c     | 10 +++-------
>  testcases/kernel/syscalls/futex/futex_wait02.c     | 11 ++++-------
>  testcases/kernel/syscalls/futex/futex_wait03.c     | 11 ++++-------
>  testcases/kernel/syscalls/futex/futex_wait04.c     | 10 +++-------
>  .../kernel/syscalls/futex/futex_wait_bitset01.c    | 11 +++--------
>  testcases/kernel/syscalls/futex/futex_wake01.c     |  9 +++------
>  testcases/kernel/syscalls/futex/futex_wake02.c     | 11 ++++-------
>  testcases/kernel/syscalls/futex/futex_wake03.c     | 13 +++++--------
>  testcases/kernel/syscalls/futex/futex_wake04.c     | 14 +++++---------
>  testcases/kernel/syscalls/futex/futextest.h        |  7 +++++++
>  12 files changed, 48 insertions(+), 80 deletions(-)

Cyril, this one is pending too I believe.

-- 
viresh
