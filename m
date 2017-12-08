From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 8 Dec 2017 16:53:57 +0800
Subject: [LTP] [PATCH] sctp: porting "tests: fix SMALL_MAXSEG" to
	ltp/utils/sctp
In-Reply-To: <1512722689-7248-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1512722689-7248-1-git-send-email-lizhijian@cn.fujitsu.com>
Message-ID: <CADvbK_dOujZu02er5BrOyA+LUtM4VNwqehhOgQBCuTooNmv_4Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Dec 8, 2017 at 4:44 PM, Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
> LKP reported a sctp issue: https://lists.01.org/pipermail/lkp/2017-December/007830.html recently
> we need to update sctp to fix this issue
>
> the origin patch: https://github.com/sctp/lksctp-tools/commit/723993d3e33100fa96245d2ed46611eb9cba5236
> -----------------
> tests: fix SMALL_MAXSEG
> After Commit ecca8f88da5c ("sctp: set frag_point in sctp_setsockopt_maxseg
> correctly") in kernel, sctp will not allow to set max_seg with a too small
> value.
>
> Now it's using SMALL_MAXSEG in func_tests, with SMALL_MAXSEG = 100,
> sctp_setsockopt always returns err and causes some tests to fail.
>
> This patch is to avoid it by defining SMALL_MAXSEG as 500 instead, 500
> is a good value, as it's very close to the minimum and will not cause
> the last frag's size is different from the others', which would also
> lead to failure of some tests.
> -----------------
>
> CC: lucien.xin@gmail.com
> CC: xiaolong.ye@intel.com
> CC: philip.li@intel.com
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  utils/sctp/func_tests/test_sctp_sendrecvmsg.c | 2 +-
>  utils/sctp/func_tests/test_timetolive.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/utils/sctp/func_tests/test_sctp_sendrecvmsg.c b/utils/sctp/func_tests/test_sctp_sendrecvmsg.c
> index 21ba867..70b0ce7 100644
> --- a/utils/sctp/func_tests/test_sctp_sendrecvmsg.c
> +++ b/utils/sctp/func_tests/test_sctp_sendrecvmsg.c
> @@ -61,7 +61,7 @@ int TST_CNT = 0;
>
>  /* RCVBUF value, and indirectly RWND*2 */
>  #define SMALL_RCVBUF 3000
> -#define SMALL_MAXSEG 100
> +#define SMALL_MAXSEG 500
>  /* This is extra data length to ensure rwnd closes */
>  #define RWND_SLOP    100
>  static char *fillmsg = NULL;
> diff --git a/utils/sctp/func_tests/test_timetolive.c b/utils/sctp/func_tests/test_timetolive.c
> index d13168e..3a920d6 100644
> --- a/utils/sctp/func_tests/test_timetolive.c
> +++ b/utils/sctp/func_tests/test_timetolive.c
> @@ -77,7 +77,7 @@ int TST_CNT = 0;
>  #define SMALL_RCVBUF 3000
>
>  /* MAX segment size */
> -#define SMALL_MAXSEG 100
> +#define SMALL_MAXSEG 500
>
>  /* RWND_SLOP is the extra data that fills up the rwnd */
>  #define RWND_SLOP 100
> --
> 2.7.4
>
>
>
Thanks.

Reviewed-by: Xin Long <lucien.xin@gmail.com>
