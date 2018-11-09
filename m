From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 9 Nov 2018 05:24:00 -0500 (EST)
Subject: [LTP] [PATCH] msgstress04: make sure not pass IPC_PRIVATE to
 msgget
In-Reply-To: <20181108093324.14028-1-kai.kang@windriver.com>
References: <20181108093324.14028-1-kai.kang@windriver.com>
Message-ID: <1149365280.71650211.1541759040124.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: Kai Kang <kai.kang@windriver.com>
> 
> It fails to run case msgstress04:
> 
> $ ./msgstress04 -n 1 -c 1 -l 1
> 
> It only inits the first MSGMNI members of keyarray. So if argument off
> of function dotest_iteration is greater than MSGMNI, the argument key
> passed to function dotest() will be IPC_PRIVATE(0) which will finally
> pass to syscall msgget(), then cause case fails.
> 
> Make sure get the value for key from the initialized members of keyarray.
> 
> Signed-off-by: Kai Kang <kai.kang@windriver.com>
> ---
>  testcases/kernel/syscalls/ipc/msgstress/msgstress04.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
> b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
> index 18fad4fbd..a357ce59a 100644
> --- a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
> +++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
> @@ -198,7 +198,7 @@ static void dotest_iteration(int off)
>  	memset(pidarray, 0, sizeof(pidarray));
>  
>  	for (i = 0; i < nprocs; i++) {
> -		key = keyarray[off + i];
> +		key = keyarray[(off + i) % MSGMNI];

Hi,

Isn't this going to pick same key over and over again?

Say maxnprocs is '1', and MSGMNI is 10000:
  dotest_iteration(i*(10000 / 1));
will become:
  key = keyarray[(10000 + 0) % 10000];
  key = keyarray[(20000 + 0) % 10000];
  key = keyarray[(30000 + 0) % 10000];
  ...

If test intention is to exercise queues for all keys, shouldn't we fix main() instead?

diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
index 18fad4fbdca1..81383d6c8b11 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
@@ -176,11 +176,11 @@ int main(int argc, char **argv)
        } else {
                for (i = 0; i < (MSGMNI / maxnprocs); i++) {
                        nprocs = maxnprocs;
-                       dotest_iteration(i*(MSGMNI / maxnprocs));
+                       dotest_iteration(i * maxnprocs);
                }
 
                nprocs = MSGMNI % maxnprocs;
-               dotest_iteration(i*(MSGMNI / maxnprocs));
+               dotest_iteration(i * maxnprocs);
        }
 
        tst_resm(TPASS, "Test ran successfully!");

Regards,
Jan

>  
>  		if ((pid = FORK_OR_VFORK()) < 0)
>  			tst_brkm(TFAIL, cleanup,
> --
> 2.17.0
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
