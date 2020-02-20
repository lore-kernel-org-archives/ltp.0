From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Feb 2020 15:57:04 +0800
Subject: [LTP] [PATCH V2 09/10] syscalls/fspick: New tests
In-Reply-To: <7195b2e7ffcda3ba70715b9094cff450568d9298.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <7195b2e7ffcda3ba70715b9094cff450568d9298.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2dUQ_NdJWNTBgh=i0sLY+VzgwFmfCXNqiKeeh2YZDw4_A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Viresh Kumar <viresh.kumar@linaro.org> wrote:

> ...
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fspick/fspick01.c
> ...
> +
> +static void run(unsigned int n)
> +{
> +       struct tcase *tc = &tcases[n];
> +       int fspick_fd;
> +
> +       TEST(fspick(AT_FDCWD, MNTPOINT, tc->flags));
> +       if (TST_RET == -1)
> +               tst_brk(TFAIL | TERRNO, "fspick() failed");
> +
> +       fspick_fd = TST_RET;
> +
> +       TEST(fsconfig(fspick_fd, FSCONFIG_SET_STRING, "user_xattr",
> "false", 0));
> +       if (TST_RET == -1) {
> +               SAFE_CLOSE(fspick_fd);
> +               tst_brk(TBROK | TERRNO, "fsconfig() failed");
>
Test kernel: 5.6.0-rc2+ x86_64

tst_test.c:1278: INFO: Testing on xfs
tst_mkfs.c:90: INFO: Formatting /dev/loop3 with xfs opts='' extra opts=''
tst_test.c:1217: INFO: Timeout per run is 0h 05m 00s
fspick01.c:90: BROK: fsconfig() failed: EINVAL (22)


> +       }
> +
> +       TEST(fsconfig(fspick_fd, FSCONFIG_SET_FLAG, "ro", NULL, 0));
> +       if (TST_RET == -1) {
> +               SAFE_CLOSE(fspick_fd);
> +               tst_brk(TBROK | TERRNO, "fsconfig() failed");
> +       }
> +
> +       SAFE_CLOSE(fspick_fd);
> +       tst_res(TPASS, "%s: fspick() passed", tc->name);
> +}
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200220/82abd210/attachment.htm>
