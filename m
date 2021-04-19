From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 19 Apr 2021 19:09:23 +0300
Subject: [LTP] [PATCH v3] syscalls/chown: Rewrite chown/chown03.c with
 the new api
In-Reply-To: <20210419013427.247615-1-xieziyao@huawei.com>
References: <20210419013427.247615-1-xieziyao@huawei.com>
Message-ID: <60ae8451-30f5-9b82-dcdc-11b97e29099e@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 19.04.2021 04:34, Xie Ziyao wrote:
> For this:
>   testcases/kernel/syscalls/chown/chown03.c
> 
> Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
> ---
> v2->v3:
> 1. Remove some unnecessary comments and incorrect output prints;
> 2. Moved some prerequisite codes from the setup() function to the run() function
> and add code logic for checking whether the setting is successful.
> 

Hi Ziyao,

>  testcases/kernel/syscalls/chown/chown03.c | 241 +++++++---------------
>  1 file changed, 70 insertions(+), 171 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
> index 2c7bcfe7d..4469f1c4d 100644
> --- a/testcases/kernel/syscalls/chown/chown03.c
> +++ b/testcases/kernel/syscalls/chown/chown03.c
> @@ -1,72 +1,18 @@

...
> -int TST_TOTAL = 1;		/* Total number of test conditions */
> -char nobody_uid[] = "nobody";
>  struct passwd *ltpuser;

static struct passwd *ltpuser;

> 
> -void setup();			/* setup function for the test */
> -void cleanup();			/* cleanup function for the test */
> -
> -int main(int ac, char **av)
> +static void run(void)
>  {
...
> +    SAFE_SETEUID(0);
> +    SAFE_CHOWN(FILENAME, -1, 0);
> +    SAFE_CHMOD(FILENAME, NEW_PERMS);
> +    SAFE_SETEUID(ltpuser->pw_uid);
> +
> +    uid_t uid;
> +    gid_t gid;
> +    UID16_CHECK((uid = geteuid()), "chown");
> +    GID16_CHECK((gid = getegid()), "chown");
> +
> +    struct stat stat_buf;
> +    SAFE_STAT(FILENAME, &stat_buf);
> +    if (stat_buf.st_uid != uid || stat_buf.st_gid != 0)
> +        tst_res(TFAIL, "%s: Incorrect ownership"
> +                       "set to %d %d, Expected %d %d",
> +                FILENAME, stat_buf.st_uid,
> +                stat_buf.st_gid, uid, 0);
> +
> +    TST_EXP_PASS(CHOWN(FILENAME, -1, gid), "chown(%s,%d,%d)",
> +                 FILENAME, -1, gid);
> +
> +    SAFE_STAT(FILENAME, &stat_buf);
> +    if (stat_buf.st_uid != uid || stat_buf.st_gid != gid)
> +        tst_res(TFAIL, "%s: Incorrect ownership"
> +                       "set to %d %d, Expected %d %d",
> +                FILENAME, stat_buf.st_uid,
> +                stat_buf.st_gid, uid, gid);

There are two similar owner checks now, it would be better to
move them to a single function, something like this:

static void check_owner(struct stat *s, uid_t exp_uid, gid_t exp_gid)
{
        if (s->st_uid != exp_uid || s->st_gid != exp_gid) {
                tst_res(TFAIL, "%s: wrong owner set to %d %d, expected %d %d",
                        FILENAME, s->st_uid, s->st_gid, exp_uid, exp_gid);
        } else {
                tst_res(TPASS, "%s: expected owner set %d %d",
                        FILENAME, exp_uid, exp_gid);
        }
}
