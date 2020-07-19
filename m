From: Li Wang <liwang@redhat.com>
Date: Sun, 19 Jul 2020 15:48:17 +0800
Subject: [LTP] [PATCH 3/9] syscalls/ipc: shmctl04: Rewrite from scratch.
In-Reply-To: <20200717163453.9587-4-chrubis@suse.cz>
References: <20200717163453.9587-1-chrubis@suse.cz>
 <20200717163453.9587-4-chrubis@suse.cz>
Message-ID: <CAEemH2dHcasASDdXKypSwYkg7Yq1+ynO3-Z6QcxMwP6M=Qh3mQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Jul 18, 2020 at 12:35 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> ...
> +       /*
> +        * Sum rss, swap and size for all elements listed, which should
> equal
> +        * the data returned in the shm_info structure.
> +        *
> +        * Note that the size has to be rounded up to nearest multiple of
> page
> +        * size.
> +        */
> +       while (fscanf(f, "%*i %i %*i %i %*i %*i %*i %*i %*i %*i %*i %*i
> %*i %*i %i %i",
> +                     &shmid, &size, &rss, &swap) > 0) {
> +               used_ids++;
> +               shm_rss += rss/page_size;
> +               shm_swp += swap/page_size;
> +               shm_tot += (size + page_size - 1) / page_size;
> +               if (shmid > shmid_max)
> +                       shmid_max = shmid;
> +       }
>
> ...
>
> -       tst_exit();
> +       if (max_id != shmid_max) {
> +               tst_res(TFAIL, "highest shmid = %i, expected %i",
> +                       max_id, shmid_max);
>

It failed many times on my personal laptop (5.4.19-100.fc30.x86_64).

$ cat /proc/sysvipc/shm
       key      shmid   perms        size      cpid    lpid    nattch   uid
  gid    cuid    cgid      atime         dtime              ctime
     rss        swap
         0          6         1600      524288   2778   5447      2     1000
 1000  1000  1000 1595120306 1595120306 1595119412      4096        0
         0          8         1600      524288   1903   2043      2     1000
 1000  1000  1000 1595119515     0                 1595119515     24576
   0

$ ./shmctl04
tst_test.c:1245: INFO: Timeout per run is 0h 05m 00s
shmctl04.c:119: PASS: SHM_INFO returned valid index 8
shmctl04.c:70: PASS: used_ids = 3
shmctl04.c:77: PASS: shm_rss = 7
shmctl04.c:84: PASS: shm_swp = 0
shmctl04.c:91: PASS: shm_tot = 257
shmctl04.c:95: FAIL: highest shmid = 8, expected 65537

Summary:
passed   5
failed   1
skipped  0
warnings 0

After printing the shm_proc during test running, I guess the 'shmid' is not
listing in number order sometimes which probably caused that failure.

       key      shmid perms                  size  cpid  lpid nattch   uid
  gid  cuid  cgid      atime      dtime      ctime                   rss
               swap
         0      98306   600                  2048 29586     0      0  1000
 1000  1000  1000          0          0 1595144682                     0
                  0
         0          6  1600                524288  2778 26559      2  1000
 1000  1000  1000 1595142041 1595142041 1595119412                  4096
                  0
         0          8  1600                524288  1903  2043      2  1000
 1000  1000  1000 1595119515          0 1595119515                 24576
                  0



> +       } else {
> +               tst_res(TPASS, "highest shmid = %i", max_id);
> +       }
>  }
>
> -/*
> - * setup() - performs all the ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void verify_shminfo(void)
>  {
> +       struct shm_info info;
> +       struct shmid_ds ds;
>
> -       tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +       TEST(shmctl(0, SHM_INFO, (struct shmid_ds *)&info));
>
> -       TEST_PAUSE;
> +       if (TST_RET == -1) {
> +               tst_res(TFAIL | TTERRNO, "shmctl(0, SHM_INFO, ...)");
> +               return;
> +       }
>
> -       /*
> -        * Create a temporary directory and cd into it.
> -        * This helps to ensure that a unique msgkey is created.
> -        * See libs/libltpipc/libipc.c for more information.
> -        */
> -       tst_tmpdir();
> +       TEST(shmctl(TST_RET, SHM_STAT_ANY, &ds));
>

'SHM_STAT_ANY' is introduced since Linux 4.17. We have to confirm the SUT
supporting before we running it.

Also, we'd better define it in "ipcshm.h" to avoid compiling errors with
the old distro.

shmctl04.c: In function 'verify_shminfo':
shmctl04.c:114: error: 'SHM_STAT_ANY' undeclared (first use in this
function)
shmctl04.c:114: error: (Each undeclared identifier is reported only once
shmctl04.c:114: error: for each function it appears in.)

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200719/4506f466/attachment.htm>
