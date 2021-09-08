From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Sep 2021 11:29:54 +0800
Subject: [LTP] [PATCH] open_posix: Add failure handling of fork()
In-Reply-To: <20210905031113.2740-1-zhaogongyi@huawei.com>
References: <20210905031113.2740-1-zhaogongyi@huawei.com>
Message-ID: <CAEemH2ebjS-4UVQGhVuArkzDeS3n1A82wPxVDfGHQ=0Jt+Q4qQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Sep 7, 2021 at 8:41 PM Zhao Gongyi <zhaogongyi@huawei.com> wrote:

> When fork() failed and transfer the return value(-1) to kill(),
> kill(-1, SIGSTOP) would freeze the system, so it is very serious
> in this cases and should be avoided.
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  .../conformance/interfaces/clock_nanosleep/1-5.c               | 3 +++
>  .../conformance/interfaces/nanosleep/3-2.c                     | 3 +++
>  .../conformance/interfaces/sigaction/10-1.c                    | 3 +++
>  .../conformance/interfaces/sigaction/11-1.c                    | 3 +++
>  .../conformance/interfaces/sigaction/9-1.c                     | 3 +++
>  5 files changed, 15 insertions(+)
>
> diff --git
> a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
> b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
> index 46f26163d..a87585884 100644
> ---
> a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
> +++
> b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
> @@ -48,6 +48,9 @@ int main(void)
>                         return CHILDFAIL;
>                 }
>                 return CHILDFAIL;
> +       } else if (pid < 0) {
> +               printf("fork() did not return success\n");
> +               return PTS_UNRESOLVED;
>

Can we do the error check following the fork() instantly?
Insert pid<0 with a 'else if' looks a bit strange here.

Normally convention like:

pid = fork();
 if (pid < 0)
    do error handle ...

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210908/6793832e/attachment.htm>
