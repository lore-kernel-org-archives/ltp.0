From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 5 Aug 2021 03:43:32 +0000
Subject: [LTP] [PATCH v2 2/2] msgget03: don't depend on existed shared
 resources
In-Reply-To: <YQqor4LiNK4/Xrbe@yuki>
References: <20210712075223.10682-1-aleksei.kodanev@bell-sw.com>
 <20210712075223.10682-2-aleksei.kodanev@bell-sw.com> <YPkkZ0Zq9DyHKBaT@pevik>
 <YPlhMeRRsNnemT05@yuki> <YPlsK8fsMI8T+H7c@pevik> <YPlsVD2gbIiX8JJk@yuki>
 <60FA81E4.3060709@fujitsu.com> <YPq0749ZnnGsAV2q@pevik>
 <60FF9EFA.308@fujitsu.com> <YQqor4LiNK4/Xrbe@yuki>
Message-ID: <610B5E7D.1070104@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Petr
> Hi!
>>  From 2772f8f0bbc1526389cb2090895dded41e2c43dc Mon Sep 17 00:00:00 2001
>> From: Yang Xu<xuyang2018.jy@fujitsu.com>
>> Date: Tue, 27 Jul 2021 16:22:42 +0800
>> Subject: [PATCH] libs/libnewipc:Rename get_used_queues as get_used_sysvipc_cnt
>>
>> Rename get_used_queues as get_used_sysvipc_cnt, so we can use GET_USED_QUEQUES()
>> and GET_USED_SEGMENTS() to get the corresponding used sysvipc resource total.
>>
>> Then we can use them in shmget03/msgget03, so we can trigger the ENOSPC error correctly
>> even current environment has consume some sysvipc resource.
>>
>> I don't use this api in verify function since we don't support run cases in parallel and
>> we should assume this situation that this case is the only case to use(free or alloc) sysv
>> ipc resource at that time.
>>
>> Fixes: #842
>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
>> ---
>>   include/libnewipc.h                             |  6 ++++--
>>   libs/libltpnewipc/libnewipc.c                   | 16 ++++++++--------
>>   testcases/kernel/syscalls/ipc/msgget/msgget03.c | 10 +++++++---
>>   testcases/kernel/syscalls/ipc/shmget/shmget03.c | 10 ++++++----
>>   4 files changed, 25 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/libnewipc.h b/include/libnewipc.h
>> index 075364f85..b0448841a 100644
>> --- a/include/libnewipc.h
>> +++ b/include/libnewipc.h
>> @@ -49,9 +49,11 @@ key_t getipckey(const char *file, const int lineno);
>>   #define GETIPCKEY() \
>>   	getipckey(__FILE__, __LINE__)
>>
>> -int get_used_queues(const char *file, const int lineno);
>> +int get_used_sysvipc_cnt(const char *file, const int lineno, const char *sysvipc_file);
>>   #define GET_USED_QUEUES() \
>> -	get_used_queues(__FILE__, __LINE__)
>> +	get_used_sysvipc_cnt(__FILE__, __LINE__, "/proc/sysvipc/msg")
>> +#define GET_USED_SEGMENTS() \
>> +	get_used_sysvipc_cnt(__FILE__, __LINE__, "/proc/sysvipc/shm")
>
> I would just call it get_used_sysvipc()
OK.
>
>>   void *probe_free_addr(const char *file, const int lineno);
>>   #define PROBE_FREE_ADDR() \
>> diff --git a/libs/libltpnewipc/libnewipc.c b/libs/libltpnewipc/libnewipc.c
>> index d0974bbe0..687a907e7 100644
>> --- a/libs/libltpnewipc/libnewipc.c
>> +++ b/libs/libltpnewipc/libnewipc.c
>> @@ -48,25 +48,25 @@ key_t getipckey(const char *file, const int lineno)
>>   	return key;
>>   }
>>
>> -int get_used_queues(const char *file, const int lineno)
>> +int get_used_sysvipc_cnt(const char *file, const int lineno, const char *sysvipc_file)
>>   {
>>   	FILE *fp;
>> -	int used_queues = -1;
>> +	int used_cnt = -1;
>
> And here as well the _cnt is not adding any value over I would say.
OK.
>
>>   	char buf[BUFSIZE];
>>
>> -	fp = safe_fopen(file, lineno, NULL, "/proc/sysvipc/msg", "r");
>> +	fp = safe_fopen(file, lineno, NULL, sysvipc_file, "r");
>>
>>   	while (fgets(buf, BUFSIZE, fp) != NULL)
>> -		used_queues++;
>> +		used_cnt++;
>>
>>   	fclose(fp);
>>
>> -	if (used_queues<  0) {
>> -		tst_brk(TBROK, "can't read /proc/sysvipc/msg to get "
>> -			"used message queues at %s:%d", file, lineno);
>> +	if (used_cnt<  0) {
>> +		tst_brk(TBROK, "can't read %s to get used message queues "
>> +			"at %s:%d", sysvipc_file, file, lineno);
>>   	}
I also modify this info.
message queues => sysvipc resource total
>>
>> -	return used_queues;
>> +	return used_cnt;
>>   }
>>
>>   void *probe_free_addr(const char *file, const int lineno)
>> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
>> index ab5714cdc..8ccffc547 100644
>> --- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
>> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
>> @@ -21,7 +21,7 @@
>>   #include "tst_safe_sysv_ipc.h"
>>   #include "libnewipc.h"
>>
>> -static int maxmsgs, queue_cnt;
>> +static int maxmsgs, queue_cnt, existed_cnt;
>                                    ^
> 				  Why not 'used_cnt' ?
Yes.
>>   static int *queues;
>>   static key_t msgkey;
>>
>> @@ -37,11 +37,15 @@ static void setup(void)
>>
>>   	msgkey = GETIPCKEY();
>>
>> +	existed_cnt = GET_USED_QUEUES();
>> +	tst_res(TINFO, "Current environment %d message queues are already in use",
>> +		existed_cnt);
>> +
>>   	SAFE_FILE_SCANF("/proc/sys/kernel/msgmni", "%i",&maxmsgs);
>>
>> -	queues = SAFE_MALLOC(maxmsgs * sizeof(int));
>> +	queues = SAFE_MALLOC((maxmsgs - existed_cnt) * sizeof(int));
>>
>> -	for (num = 0; num<  maxmsgs; num++) {
>> +	for (num = 0; num<  maxmsgs - existed_cnt; num++) {
>>   		res = msgget(msgkey + num, IPC_CREAT | IPC_EXCL);
>>   		if (res == -1)
>>   			tst_brk(TBROK | TERRNO, "msgget failed unexpectedly");
>> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
>> index efbc465e1..acd352796 100644
>> --- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
>> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
>> @@ -22,7 +22,7 @@
>>   #include "libnewipc.h"
>>
>>   static int *queues;
>> -static int maxshms, queue_cnt;
>> +static int maxshms, queue_cnt, existed_cnt;
>                                     ^
> 				   Here as well.
OK.
>>   static key_t shmkey;
>>
>>   static void verify_shmget(void)
>> @@ -36,11 +36,13 @@ static void setup(void)
>>   	int res, num;
>>
>>   	shmkey = GETIPCKEY();
>> -
>> +	existed_cnt = GET_USED_SEGMENTS();
>> +	tst_res(TINFO, "Current environment %d shared memory segments are already in use",
>> +		existed_cnt);
>>   	SAFE_FILE_SCANF("/proc/sys/kernel/shmmni", "%i",&maxshms);
>>
>> -	queues = SAFE_MALLOC(maxshms * sizeof(int));
>> -	for (num = 0; num<  maxshms; num++) {
>> +	queues = SAFE_MALLOC((maxshms - existed_cnt) * sizeof(int));
>> +	for (num = 0; num<  maxshms - existed_cnt; num++) {
>>   		res = shmget(shmkey + num, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW);
>>   		if (res == -1)
>>   			tst_brk(TBROK | TERRNO, "shmget failed unexpectedly");
>
> Other than the very minor differencies I would do in naming the
> variables and function this looks good to me.
>
> Reviewed-by: Cyril Hrubis<chrubis@suse.cz>
Thanks for your review. I spilt this patch into a patchset because it is 
more friendly for user or tester.

Best Regards
Yang Xu
>
>
