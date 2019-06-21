From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 21 Jun 2019 13:58:28 +0800
Subject: [LTP] [PATCH RFC] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <20190610032754.GA7114@hori.linux.bs1.fc.nec.co.jp>
References: <20190607095213.13372-1-liwang@redhat.com>
 <20190610032754.GA7114@hori.linux.bs1.fc.nec.co.jp>
Message-ID: <5D0C7204.9020704@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> Hi Li Wang,
>
> Thank you for maintaining the testcase.
>
> Recently (since 4.19) we have a semantics change on the return value of
> madvise(MADV_SOFT_OFFLINE), and we see -EBUSY when hugepage migration
> succeeded and error containment failed:
>
>   commit 6bc9b56433b76e40d11099338d27fbc5cd2935ca
>   Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>   Date:   Thu Aug 23 17:00:38 2018 -0700
>   
>       mm: fix race on soft-offlining free huge pages
>
> , so we don't have to consider this EBUSY as error, but a good report
> for application. Your change meets the change.
>
> Feel free to add my ack:
>
> Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>
> Thanks,
> - Naoya
>
> On Fri, Jun 07, 2019 at 05:52:13PM +0800, Li Wang wrote:
>> The test#2 is going to simulate the race condition, where move_pages()
>> and soft offline are called on a single hugetlb page concurrently. But,
>> it return EBUSY and report FAIL in soft-offline a moving hugepage as a
>> result sometimes.
>>
>> The root cause seems a call to page_huge_active return false, then the
>> soft offline action will failed to isolate hugepage with EBUSY return as
>> below call trace:
>>
>> In Parent:
>>   madvise(..., MADV_SOFT_OFFLINE)
>>   ...
>>     soft_offline_page
>>       soft_offline_in_use_page
>>         soft_offline_huge_page
>>           isolate_huge_page
>>             page_huge_active  --> return false at here
>>
>> In Child:
>>   move_pages()
>>   ...
>>     do_move_pages
>>       do_move_pages_to_node
>>         add_page_for_migration
>>           isolate_huge_page   --> it has already isolated the hugepage
>>
>> In this patch, I simply regard the returned EBUSY as a normal situation and
>> mask it in error handler. Because move_pages is calling add_page_for_migration
>> to isolate hugepage before do migration, so that's very possible to hit the
>> collision and return EBUSY on the same page.
>>
>> Error log:
>> ----------
>> move_pages12.c:235: INFO: Free RAM 8386256 kB
>> move_pages12.c:253: INFO: Increasing 2048kB hugepages pool on node 0 to 4
>> move_pages12.c:263: INFO: Increasing 2048kB hugepages pool on node 1 to 6
>> move_pages12.c:179: INFO: Allocating and freeing 4 hugepages on node 0
>> move_pages12.c:179: INFO: Allocating and freeing 4 hugepages on node 1
>> move_pages12.c:169: PASS: Bug not reproduced
>> move_pages12.c:81: FAIL: madvise failed: SUCCESS
>> move_pages12.c:81: FAIL: madvise failed: SUCCESS
>> move_pages12.c:143: BROK: mmap((nil),4194304,3,262178,-1,0) failed: ENOMEM
>> move_pages12.c:114: FAIL: move_pages failed: EINVAL
>>
>> Dmesg:
>> ------
>> [165435.492170] soft offline: 0x61c00 hugepage failed to isolate
>> [165435.590252] soft offline: 0x61c00 hugepage failed to isolate
>> [165435.725493] soft offline: 0x61400 hugepage failed to isolate
>>
>> Other two fixes in this patch:
>>  * use TERRNO(but not TTERRNO) to catch madvise(..., MADV_SOFT_OFFLINE) errno
>>  * go out test when hugepage allocating failed with ENOMEM
Hi Li

Your patch can handle EBUSY errno correctly for soft offline. 
But move page  may be killed by SIGBUS because of  MCE  when we soft offline concurrently.  
That leads to move_page failed with ESRCH.   Also, move page may fails with ENOMEM .
Do you notice it ?

I think ESRCH error can represent the soft offline bug not reproduce because it don't trigger a crash.
What do you think about it?

err_log:
tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
move_pages12.c:236: INFO: Free RAM 119568 kB
move_pages12.c:254: INFO: Increasing 2048kB hugepages pool on node 0 to 83
move_pages12.c:264: INFO: Increasing 2048kB hugepages pool on node 1 to 94
move_pages12.c:180: INFO: Allocating and freeing 4 hugepages on node 0
move_pages12.c:180: INFO: Allocating and freeing 4 hugepages on node 1
move_pages12.c:170: PASS: Bug not reproduced
tst_test.c:1141: BROK: Test killed by SIGBUS!

Summary:
passed   1
failed   0
skipped  0
warnings 0

move_pages12.c:114: FAIL: move_pages failed: ESRCH

dmesg
[ 9868.180669] MCE: Killing move_pages12:29616 due to hardware memory corruption fault at 2aaaaac00018
[ 9990.049875] Soft offlining page 50e00 at 2aaaaac00000
[ 9990.052218] Soft offlining page 50c00 at 2aaaaae00000
[ 9990.060395] Soft offlining page 51000 at 2aaaaac00000

Kind Regards,
Yang Xu

>> Signed-off-by: Li Wang <liwang@redhat.com>
>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>> Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
>> Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>  .../kernel/syscalls/move_pages/move_pages12.c | 33 ++++++++++++++-----
>>  1 file changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
>> index 964b712fb..c446396dc 100644
>> --- a/testcases/kernel/syscalls/move_pages/move_pages12.c
>> +++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
>> @@ -77,8 +77,8 @@ static void *addr;
>>  static int do_soft_offline(int tpgs)
>>  {
>>  	if (madvise(addr, tpgs * hpsz, MADV_SOFT_OFFLINE) == -1) {
>> -		if (errno != EINVAL)
>> -			tst_res(TFAIL | TTERRNO, "madvise failed");
>> +		if (errno != EINVAL && errno != EBUSY)
>> +			tst_res(TFAIL | TERRNO, "madvise failed");
>>  		return errno;
>>  	}
>>  	return 0;
>> @@ -121,7 +121,8 @@ static void do_child(int tpgs)
>>  
>>  static void do_test(unsigned int n)
>>  {
>> -	int i;
>> +	int i, ret;
>> +	void *ptr;
>>  	pid_t cpid = -1;
>>  	int status;
>>  	unsigned int twenty_percent = (tst_timeout_remaining() / 5);
>> @@ -136,24 +137,37 @@ static void do_test(unsigned int n)
>>  		do_child(tcases[n].tpages);
>>  
>>  	for (i = 0; i < LOOPS; i++) {
>> -		void *ptr;
>> +		ptr = mmap(NULL, tcases[n].tpages * hpsz,
>> +				PROT_READ | PROT_WRITE,
>> +				MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
>> +		if (ptr == MAP_FAILED) {
>> +			if (errno == ENOMEM) {
>> +				tst_res(TCONF,
>> +					"Cannot allocate hugepage, memory too fragmented?");
>> +				goto out;
>> +			}
>> +
>> +			tst_brk(TBROK | TERRNO, "Cannot allocate hugepage");
>> +		}
>>  
>> -		ptr = SAFE_MMAP(NULL, tcases[n].tpages * hpsz,
>> -			PROT_READ | PROT_WRITE,
>> -			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
>>  		if (ptr != addr)
>>  			tst_brk(TBROK, "Failed to mmap at desired addr");
>>  
>>  		memset(addr, 0, tcases[n].tpages * hpsz);
>>  
>>  		if (tcases[n].offline) {
>> -			if (do_soft_offline(tcases[n].tpages) == EINVAL) {
>> +			ret = do_soft_offline(tcases[n].tpages);
>> +
>> +			if (ret == EINVAL) {
>>  				SAFE_KILL(cpid, SIGKILL);
>>  				SAFE_WAITPID(cpid, &status, 0);
>>  				SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
>>  				tst_res(TCONF,
>>  					"madvise() didn't support MADV_SOFT_OFFLINE");
>>  				return;
>> +			} else if (ret == EBUSY) {
>> +				SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
>> +				goto out;
>>  			}
>>  		}
>>  
>> @@ -163,9 +177,10 @@ static void do_test(unsigned int n)
>>  			break;
>>  	}
>>  
>> +out:
>>  	SAFE_KILL(cpid, SIGKILL);
>>  	SAFE_WAITPID(cpid, &status, 0);
>> -	if (!WIFEXITED(status))
>> +	if (!WIFEXITED(status) && ptr != MAP_FAILED)
>>  		tst_res(TPASS, "Bug not reproduced");
>>  }
>>  
>> -- 
>> 2.20.1
>>
>>
>
> .
>



