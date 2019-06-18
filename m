From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 19 Jun 2019 00:23:34 +0300
Subject: [LTP] [PATCH v4 1/3] syscalls/fanotify13: new test to verify
 FAN_REPORT_FID functionality
In-Reply-To: <6c25395422b19d2a4e2c66937afcaa767b83e776.1560766652.git.mbobrowski@mbobrowski.org>
References: <cover.1560766652.git.mbobrowski@mbobrowski.org>
 <6c25395422b19d2a4e2c66937afcaa767b83e776.1560766652.git.mbobrowski@mbobrowski.org>
Message-ID: <CAOQ4uxgzA83i=rdQX+076_vZ2LE0Vihv1Fc0MXyXS4r-U4a93Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> +static void do_test(unsigned int number)
> +{
> +       unsigned int i;
> +       int len, fds[ARRAY_SIZE(objects)];
> +
> +       struct file_handle *event_file_handle;
> +       struct fanotify_event_metadata *metadata;
> +       struct fanotify_event_info_fid *event_fid;
> +       struct test_case_t *tc = &test_cases[number];
> +       struct fanotify_mark_type *mark = &tc->mark;
> +
> +       tst_res(TINFO,
> +               "Test #%d: FAN_REPORT_FID with mark flag: %s",
> +               number, mark->name);
> +
> +       fanotify_fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
> +       if (fanotify_fd == -1) {
> +               if (errno == EINVAL) {
> +                       tst_res(TCONF,
> +                               "FAN_REPORT_FID not supported by kernel");
> +                       return;
> +               }
> +               tst_brk(TBROK | TERRNO,
> +                       "fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, "
> +                       "O_RDONLY) failed");
> +       }
> +
> +       /* Place marks on a set of objects and setup the expected masks
> +        * for each event that is expected to be generated
> +        */
> +       if (setup_marks(fanotify_fd, tc) != 0)
> +               return;
> +

Sorry, just notices a test bug.
fanotify_fd needs to be closed before returning from this function,
because next test case is going to overwrite fanotify_fd.
do_cleanup() is called only at end of entire test or on tst_brk().

This needs to be fixed for fanotify14 and fanotify15 as well.

Also, please see my fanotify_dentry branch on github for an extra
patch to fanotify13 to cover a bug reported by syzbot:

https://lore.kernel.org/linux-fsdevel/CAOQ4uxhsnOXXVCuOT4p4c_koBMFfprWwdtCPGNGhzprFaJZwRA@mail.gmail.com/T/#t

Please include this extra patch in your next series posting.

Thanks,
Amir.
