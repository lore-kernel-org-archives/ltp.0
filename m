From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 29 Jul 2021 16:20:17 +0200
Subject: [LTP] [PATCH 3/3] mbind01: add more tests for MPOL_LOCAL
In-Reply-To: <20210729132514.1699551-3-liwang@redhat.com>
References: <20210729132514.1699551-1-liwang@redhat.com>
 <20210729132514.1699551-3-liwang@redhat.com>
Message-ID: <CAASaF6yQkiZVPWpsoo0ZrryBGFdLSGo3kkoejeWcy8dQMSL3yw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 29, 2021 at 3:25 PM Li Wang <liwang@redhat.com> wrote:

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/mbind/mbind01.c | 25 ++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/mbind/mbind01.c
> b/testcases/kernel/syscalls/mbind/mbind01.c
> index d2cf13c8f..b5c1e948d 100644
> --- a/testcases/kernel/syscalls/mbind/mbind01.c
> +++ b/testcases/kernel/syscalls/mbind/mbind01.c
> @@ -34,7 +34,7 @@ static struct bitmask *nodemask, *getnodemask,
> *empty_nodemask;
>  static void test_default(unsigned int i, char *p);
>  static void test_none(unsigned int i, char *p);
>  static void test_invalid_nodemask(unsigned int i, char *p);
> -static void check_policy_pref_no_target(int);
> +static void check_policy_pref_or_local(int);
>
>  struct test_case {
>         int policy;
> @@ -92,7 +92,7 @@ static struct test_case tcase[] = {
>                 .ret = 0,
>                 .err = 0,
>                 .test = test_none,
> -               .check_policy = check_policy_pref_no_target,
> +               .check_policy = check_policy_pref_or_local,
>         },
>         {
>                 POLICY_DESC(MPOL_PREFERRED),
> @@ -101,6 +101,20 @@ static struct test_case tcase[] = {
>                 .test = test_default,
>                 .exp_nodemask = &nodemask,
>         },
> +       {
> +               POLICY_DESC(MPOL_LOCAL),
> +               .ret = 0,
> +               .err = 0,
> +               .test = test_none,
> +               .exp_nodemask = &empty_nodemask,
> +               .check_policy = check_policy_pref_or_local,
>

This is a bit more permissive, it allows for MPOL_LOCAL to return also
MPOL_PREFERRED.
Shouldn't that still be treated as error?


> +       },
> +       {
> +               POLICY_DESC_TEXT(MPOL_LOCAL, "target exists"),
> +               .ret = -1,
> +               .err = EINVAL,
> +               .test = test_default,
> +       },
>         {
>                 POLICY_DESC(UNKNOWN_POLICY),
>                 .ret = -1,
> @@ -122,7 +136,7 @@ static struct test_case tcase[] = {
>         },
>  };
>
> -static void check_policy_pref_no_target(int policy)
> +static void check_policy_pref_or_local(int policy)
>  {
>         if (policy != MPOL_PREFERRED && policy != MPOL_LOCAL) {
>                 tst_res(TFAIL, "Wrong policy: %s(%d), "
> @@ -182,6 +196,11 @@ static void do_test(unsigned int i)
>
>         tst_res(TINFO, "case %s", tc->desc);
>
> +       if ((tst_kvercmp(3, 8, 0)) < 0 && (tc->policy == MPOL_LOCAL)) {
> +               tst_res(TCONF, "%s is not supported",
> tst_mempolicy_mode_name(tc->policy));
> +               return;
> +       }
>

I was thinking of runtime check (to support also downstream kernels that
backported it),
but I don't have strong opinion.



> +
>         setup_node();
>
>         p = SAFE_MMAP(NULL, MEM_LENGTH, PROT_READ | PROT_WRITE,
> MAP_PRIVATE |
> --
> 2.31.1
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210729/7098a98b/attachment.htm>
