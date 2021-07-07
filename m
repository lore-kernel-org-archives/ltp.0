From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Wed, 7 Jul 2021 01:50:43 +0000
Subject: [LTP] [PATCH] shmget03: fix test when some shm segments already
 exist
In-Reply-To: <381b8420-3dba-d7c1-027c-e2e2adc719de@bell-sw.com>
References: <20210706105758.43220-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2cOm+1BMWE7oWVFttXNOeQsYk9veXePS+ctxAABk2rCWQ@mail.gmail.com>
 <c2c7ff46-df28-c7b6-49dd-c891d9655d00@bell-sw.com>
 <381b8420-3dba-d7c1-027c-e2e2adc719de@bell-sw.com>
Message-ID: <60E50890.9040903@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,Li
> On 06.07.2021 16:43, Alexey Kodanev wrote:
>> Hi Li,
>> On 06.07.2021 15:49, Li Wang wrote:
>>> Hi Alexey,
>>>
>>> On Tue, Jul 6, 2021 at 6:59 PM Alexey Kodanev<aleksei.kodanev@bell-sw.com<mailto:aleksei.kodanev@bell-sw.com>>  wrote:
>>>
>>>      It's unlikely, but still possible that some of them could be
>>>      created during the test as well, so the patch only checks
>>>      errno.
>>>
>>>
>>> Thanks for fixing this, seems the msgget03 has this problem as well.
>>> https://github.com/linux-test-project/ltp/issues/842<https://github.com/linux-test-project/ltp/issues/842>
>>
>> Yes, it is the same, it can be easily reproduced:
>>
>> $ ./msgget03
>> tst_test.c:1311: TINFO: Timeout per run is 0h 05m 00s
>> msgget03.c:50: TINFO: The maximum number of message queues (32000) reached
>> msgget03.c:29: TPASS: msgget(1627491660, 1536) : ENOSPC (28)
>>
>> $ ipcmk -Q
>> Message queue id: 32768
>>
>> $ ./msgget03
>> tst_test.c:1311: TINFO: Timeout per run is 0h 05m 00s
>> msgget03.c:46: TBROK: msgget failed unexpectedly: ENOSPC (28)
>>
>>
>> We can fix it similarly.
>>
>
> It's also possible that some resources will be freed during
> the tests... perhaps, moving the loop to verify_*() is the
> better option?
>
> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> index 76cf82cd3..5b760b1d6 100644
> --- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> @@ -26,29 +26,29 @@ static key_t msgkey;
>
>   static void verify_msgget(void)
>   {
> -       TST_EXP_FAIL2(msgget(msgkey + maxmsgs, IPC_CREAT | IPC_EXCL), ENOSPC,
> -               "msgget(%i, %i)", msgkey + maxmsgs, IPC_CREAT | IPC_EXCL);
> +       int num, res;
> +
> +       for (num = 0; num<= maxmsgs; ++num) {
> +               res = msgget(msgkey + num, IPC_CREAT | IPC_EXCL);
> +               if (res == -1) {
> +                       if (errno == ENOSPC) {
> +                               tst_res(TPASS | TERRNO, "created queues %d", num);
> +                               return;
> +                       }
> +                       tst_brk(TFAIL | TERRNO,
> +                               "msgget failed unexpectedly, num %d", num);
> +               }
> +               queues[queue_cnt++] = res;
> +       }
>   }
If we use this old format, then we can not ensure whether we trigger the 
ENOSPC errer correctly when reaching the expected nums.

So to avoid the existed memory segments error, I think we should alter 
get_used_queus api to count the existed  memory segments by adding a 
file argument.

ps:get_used_queus seems never be used.

code maybe as below:

diff --git a/include/libnewipc.h b/include/libnewipc.h
index 075364f85..76de70fee 100644
--- a/include/libnewipc.h
+++ b/include/libnewipc.h
@@ -49,9 +49,9 @@ key_t getipckey(const char *file, const int lineno);
  #define GETIPCKEY() \
         getipckey(__FILE__, __LINE__)

-int get_used_queues(const char *file, const int lineno);
-#define GET_USED_QUEUES() \
-       get_used_queues(__FILE__, __LINE__)
+int get_used_queues(const char *file, const int lineno, const char 
*proc_file);
+#define GET_USED_QUEUES(proc_file) \
+       get_used_queues(__FILE__, __LINE__, proc_file)

  void *probe_free_addr(const char *file, const int lineno);
  #define PROBE_FREE_ADDR() \
diff --git a/libs/libltpnewipc/libnewipc.c b/libs/libltpnewipc/libnewipc.c
index d0974bbe0..533a21140 100644
--- a/libs/libltpnewipc/libnewipc.c
+++ b/libs/libltpnewipc/libnewipc.c
@@ -48,13 +48,13 @@ key_t getipckey(const char *file, const int lineno)
         return key;
  }

-int get_used_queues(const char *file, const int lineno)
+int get_used_queues(const char *file, const int lineno, const char 
*proc_file )
  {
         FILE *fp;
         int used_queues = -1;
         char buf[BUFSIZE];

-       fp = safe_fopen(file, lineno, NULL, "/proc/sysvipc/msg", "r");
+       fp = safe_fopen(file, lineno, NULL, proc_file, "r");

         while (fgets(buf, BUFSIZE, fp) != NULL)
                 used_queues++;
@@ -62,8 +62,8 @@ int get_used_queues(const char *file, const int lineno)
         fclose(fp);

         if (used_queues < 0) {
-               tst_brk(TBROK, "can't read /proc/sysvipc/msg to get "
-                       "used message queues@%s:%d", file, lineno);
+               tst_brk(TBROK, "can't read %s to get used message queues "
+                       "at %s:%d", proc_file, file, lineno);
         }


--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -22,7 +22,7 @@
  #include "libnewipc.h"

  static int *queues;
-static int maxshms, queue_cnt;
+static int maxshms, queue_cnt, existed_cnt;
  static key_t shmkey;

  static void verify_shmget(void)
@@ -36,11 +36,14 @@ static void setup(void)
         int res, num;

         shmkey = GETIPCKEY();
+       existed_cnt = GET_USED_QUEUES("/proc/sysvipc/shm");

+       tst_res(TINFO, "Current environment has %d existed shared emory 
segments",
+               existed_cnt);
         SAFE_FILE_SCANF("/proc/sys/kernel/shmmni", "%i", &maxshms);

-       queues = SAFE_MALLOC(maxshms * sizeof(int));
-       for (num = 0; num < maxshms; num++) {
+       queues = SAFE_MALLOC((maxshms - existed_cnt) * sizeof(int));
+       for (num = 0; num < maxshms - existed_cnt; num++) {
                 res = shmget(shmkey + num, SHM_SIZE, IPC_CREAT | 
IPC_EXCL | SHM_RW);
                 if (res == -1)
                         tst_brk(TBROK | TERRNO, "shmget failed 
unexpectedly");


Best Regards
Yang Xu

> ...
