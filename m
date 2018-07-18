From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 18 Jul 2018 20:34:42 +0530
Subject: [LTP] [PATCH] open|creat: skip S_ISGID check on files created
 by non-group members
In-Reply-To: <3d0dd8e851d8db6bae222ca5946419b75df35ba5.1531816427.git.jstancek@redhat.com>
References: <3d0dd8e851d8db6bae222ca5946419b75df35ba5.1531816427.git.jstancek@redhat.com>
Message-ID: <CA+G9fYsdADRR7FMXakzCqnMdX+s=Onw0Epf4AgOAYiwZyOtgCg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thanks for the patch Jan.

On 17 July 2018 at 14:05, Jan Stancek <jstancek@redhat.com> wrote:
> 0fa3ecd87848 ("Fix up non-directory creation in SGID directories")
> fixes problem described in CVE-2018-13405. This commit is getting
> backported to older streams as well.
>
> This patch removes S_ISGID check for files created by non-group members
> in LTP tests creat08 and open10.
>
> Once 0fa3ecd87848 will be in non-rc kernel, we could add a new test
> for this CVE that would be limited to 4.18+ kernels.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Naresh Kamboju <naresh.kamboju@linaro.org>


> ---
>  testcases/kernel/syscalls/creat/creat08.c | 13 ++++++-------
>  testcases/kernel/syscalls/open/open10.c   | 12 +++++-------
>  2 files changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/creat/creat08.c b/testcases/kernel/syscalls/creat/creat08.c
> index 50f2b39931b8..d22558ac3c53 100644
> --- a/testcases/kernel/syscalls/creat/creat08.c
> +++ b/testcases/kernel/syscalls/creat/creat08.c
> @@ -361,13 +361,12 @@ int main(int ac, char **av)
>                         local_flag = FAILED;
>                 }
>
> -               /* Verify modes */
> -               if (!(buf.st_mode & S_ISGID)) {
> -                       tst_resm(TFAIL,
> -                                "%s: Incorrect modes, setgid bit should be set",
> -                                setgid_B);
> -                       local_flag = FAILED;
> -               }
> +               /*
> +                * Skip S_ISGID check
> +                * 0fa3ecd87848 ("Fix up non-directory creation in SGID directories")
> +                * clears S_ISGID for files created by non-group members
> +                */
> +
>                 close(fd);
>
>                 if (local_flag == PASSED) {
> diff --git a/testcases/kernel/syscalls/open/open10.c b/testcases/kernel/syscalls/open/open10.c
> index 613f2288fbde..14feec9e127e 100644
> --- a/testcases/kernel/syscalls/open/open10.c
> +++ b/testcases/kernel/syscalls/open/open10.c
> @@ -345,13 +345,11 @@ int main(int ac, char *av[])
>                         local_flag = FAILED;
>                 }
>
> -               /* Verify modes */
> -               if (!(buf.st_mode & S_ISGID)) {
> -                       tst_resm(TFAIL,
> -                                "%s: Incorrect modes, setgid bit not set",
> -                                setgid_B);
> -                       local_flag = FAILED;
> -               }
> +               /*
> +                * Skip S_ISGID check
> +                * 0fa3ecd87848 ("Fix up non-directory creation in SGID directories")
> +                * clears S_ISGID for files created by non-group members
> +                */
>
>                 if (local_flag == PASSED) {
>                         tst_resm(TPASS, "Test passed in block2.");
> --
> 1.8.3.1
>

- Naresh
