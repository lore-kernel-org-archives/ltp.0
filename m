From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 9 Sep 2020 04:44:07 -0400 (EDT)
Subject: [LTP] [PATCH] ioctl: take use of TST_RETRY_FN* macro
In-Reply-To: <20200909075347.2863-1-liwang@redhat.com>
References: <20200909075347.2863-1-liwang@redhat.com>
Message-ID: <1908270893.11577594.1599641047815.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
>  static void check_partition(int part_num, bool value)
>  {
> -	int ret;
> +	int ret, time_delay;
>  
>  	sprintf(sys_loop_partpath, "/sys/block/loop%d/loop%dp%d",
>  		dev_num, dev_num, part_num);
>  	sprintf(loop_partpath, "%sp%d", dev_path, part_num);
>  
> -	ret = access(sys_loop_partpath, F_OK);
> +	value ? (time_delay = 30) : (time_delay = 1);
> +
> +	ret = TST_RETRY_FN_EXP_BACKOFF(access(sys_loop_partpath, F_OK),
> TST_RETVAL_EQ0, time_delay);

Shouldn't we invert also the check when value == 0? At the moment
there's TST_RETVAL_EQ0 for all cases, but we expect path to exist
only for value == 1, correct?

diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
index 151618df41db..dff31d58a054 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl09.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
@@ -28,6 +28,9 @@ static void change_partition(const char *const cmd[])
                tst_brk(TBROK, "parted return %i", ret);
 }
 
+#define RETVAL_CHECK(x) \
+       ({ value ? TST_RETVAL_EQ0(x) : TST_RETVAL_NOTNULL(x); })
+
 static void check_partition(int part_num, bool value)
 {
        int ret;
@@ -36,7 +39,7 @@ static void check_partition(int part_num, bool value)
                dev_num, dev_num, part_num);
        sprintf(loop_partpath, "%sp%d", dev_path, part_num);
 
-       ret = access(sys_loop_partpath, F_OK);
+       ret = TST_RETRY_FN_EXP_BACKOFF(access(sys_loop_partpath, F_OK), RETVAL_CHECK, 30);
        if (ret == 0)
                tst_res(value ? TPASS : TFAIL, "access %s succeeds",
                        sys_loop_partpath);
@@ -44,7 +47,7 @@ static void check_partition(int part_num, bool value)
                tst_res(value ? TFAIL : TPASS, "access %s fails",
                        sys_loop_partpath);
 
-       ret = access(loop_partpath, F_OK);
+       ret = TST_RETRY_FN_EXP_BACKOFF(access(loop_partpath, F_OK), RETVAL_CHECK, 30);
        if (ret == 0)
                tst_res(value ? TPASS : TFAIL, "access %s succeeds",
                        loop_partpath);

