From: xuyang <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 21 May 2019 17:48:18 +0800
Subject: [LTP] [PATCH v2] syscalls/move_page12.c: Add new regression test
In-Reply-To: <20190520144145.GC28976@rei.lan>
References: <1512100108-28359-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <1555404533-2316-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190520144145.GC28976@rei.lan>
Message-ID: <5CE3C962.3000907@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

   Hi cryil

> Hi!
>>   #include<errno.h>
>> @@ -49,9 +54,17 @@
>>   #define PATH_MEMINFO	"/proc/meminfo"
>>   #define PATH_NR_HUGEPAGES	"/proc/sys/vm/nr_hugepages"
>>   #define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
>> -#define TEST_PAGES	2
>> +#define PATH_PAGEMAP	"/proc/self/pagemap"
>>   #define TEST_NODES	2
>>
>> +static struct tcase {
>> +	int tpages;
>> +	int offline;
>> +} tcases[] = {
>> +	{2, 0},
>> +	{2, 1},
>> +};
>> +
>>   static int pgsz, hpsz;
>>   static long orig_hugepages = -1;
>>   static char path_hugepages_node1[PATH_MAX];
>> @@ -61,9 +74,21 @@ static long orig_hugepages_node2 = -1;
>>   static unsigned int node1, node2;
>>   static void *addr;
>>
>> -static void do_child(void)
>> +static void do_soft_offline(int tpgs)
>>   {
>> -	int test_pages = TEST_PAGES * hpsz / pgsz;
>> +	if (madvise(addr, tpgs * hpsz, MADV_SOFT_OFFLINE) == -1) {
>> +		if (errno == EINVAL) {
>> +			tst_brk(TCONF,
>> +				"madvise() didn't support MADV_SOFT_OFFLINE");
> Can we change this to tst_res() and return a value from this function so
> that the second test could be skipped without exitting the whole test?
>
> The thing is that as far as we are implementing more than one testcase
> in a test unsupported features that are only relevant for a one test
> should not exit the whole testcase in case of looping (the -i
> parameter).
   OK.  I will change it to tst_res in v3 patch soon.

>> +		} else {
>> +			tst_brk(TBROK | TERRNO, "madvise() failed");
>> +		}
>> +	}
>> +}
>> +
>> +static void do_child(int tpgs)
>> +{
>> +	int test_pages = tpgs * hpsz / pgsz;
>>   	int i, j;
>>   	int *nodes, *status;
>>   	void **pages;
>> @@ -96,34 +121,42 @@ static void do_child(void)
>>   	exit(0);
>>   }
>>
>> -static void do_test(void)
>> +static void do_test(unsigned int n)
>>   {
>>   	int i;
>>   	pid_t cpid = -1;
>>   	int status;
>>   	unsigned int twenty_percent = (tst_timeout_remaining() / 5);
>>
>> -	addr = SAFE_MMAP(NULL, TEST_PAGES * hpsz, PROT_READ | PROT_WRITE,
>> +	if (tcases[n].offline) {
>> +		if (access(PATH_PAGEMAP, F_OK))
>> +			tst_brk(TCONF, "pagemap was not supported");
> Here as well, can we do tst_res() and return instead?
>
   PATH_PAGEMAP is useless in this case. I will remove it .

>> +	}
>> +
>> +	addr = SAFE_MMAP(NULL, tcases[n].tpages * hpsz, PROT_READ | PROT_WRITE,
>>   		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
>>
>> -	SAFE_MUNMAP(addr, TEST_PAGES * hpsz);
>> +	SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
>>
>>   	cpid = SAFE_FORK();
>>   	if (cpid == 0)
>> -		do_child();
>> +		do_child(tcases[n].tpages);
>>
>>   	for (i = 0; i<  LOOPS; i++) {
>>   		void *ptr;
>>
>> -		ptr = SAFE_MMAP(NULL, TEST_PAGES * hpsz,
>> +		ptr = SAFE_MMAP(NULL, tcases[n].tpages * hpsz,
>>   			PROT_READ | PROT_WRITE,
>>   			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
>>   		if (ptr != addr)
>>   			tst_brk(TBROK, "Failed to mmap at desired addr");
>>
>> -		memset(addr, 0, TEST_PAGES * hpsz);
>> +		memset(addr, 0, tcases[n].tpages * hpsz);
>> +
>> +		if (tcases[n].offline)
>> +			do_soft_offline(tcases[n].tpages);
>
> And here we should check the return value and return if the madvise in
> the function has returned EINVAL.
>
>
I got it.

>> -		SAFE_MUNMAP(addr, TEST_PAGES * hpsz);
>> +		SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
>>
>>   		if (tst_timeout_remaining()<  twenty_percent)
>>   			break;
>> @@ -266,7 +299,8 @@ static struct tst_test test = {
>>   	.forks_child = 1,
>>   	.setup = setup,
>>   	.cleanup = cleanup,
>> -	.test_all = do_test,
>> +	.test = do_test,
>> +	.tcnt = ARRAY_SIZE(tcases),
>>   };
>>
>>   #else
> Otherwise it looks good.
>



