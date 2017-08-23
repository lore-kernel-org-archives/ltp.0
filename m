From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Aug 2017 14:12:45 +0800
Subject: [LTP] [PATCH] numa: Add new regression test for MPOL_PREFERRED
	poliy
In-Reply-To: <20170822155034.GB26138@rei.lan>
References: <20170816091257.5097-1-liwang@redhat.com>
 <20170822155034.GB26138@rei.lan>
Message-ID: <CAEemH2cgnT2i_+61atE523h=GDUNCTd8xCVWLM1ic_8LA66xMg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 22, 2017 at 11:50 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> +# Verification of THP memory allocated on preferred node
>> +test12()
>> +{
>> +     Mem_curr=0
>> +
>> +     COUNTER=1
>> +     for node in $nodes_list; do
>> +
>> +             if [ $COUNTER -eq $total_nodes ]; then   #wrap up for last node
>> +                     Preferred_node=$(echo $nodes_list | cut -d ' ' -f 1)
>> +             else
>> +                     # always next node is preferred node
>> +                     Preferred_node=$(echo $nodes_list | cut -d ' ' -f $((COUNTER+1)))
>> +             fi
>> +
>> +             numactl --cpunodebind=$node --preferred=$Preferred_node support_numa alloc_1GB_THP &
>> +             pid=$!
>> +
>> +             wait_for_support_numa $pid
>> +
>> +             Mem_curr=$(echo "$(extract_numastat_p $pid $Preferred_node) * $MB" |bc)
>> +             if [ $(echo "$Mem_curr < $GB" |bc ) -eq 1 ]; then
>> +                     tst_res TFAIL \
>> +                             "NUMA memory allocated in node$Preferred_node is less than expected"
>> +                     kill -CONT $pid >/dev/null 2>&1
>> +                     return
>> +             fi
>> +
>> +             COUNTER=$((COUNTER+1))
>> +             kill -CONT $pid >/dev/null 2>&1
>> +     done
>> +
>> +     tst_res TPASS "NUMA preferred node policy verified with THP enabled"
>> +}
>
> I suppose that we should check that transparent huge pages are enabled
> before we run this test, i.e. that the file
> /sys/kernel/mm/transparent_hugepage/enabled exists and that it's set to
> always. Otherwise the helper would allocate 1GB of ordinary memory.

You are right. I should did the THP enabled check but forgot to.

>
> Also do we really need to allocate 1GB? Shouldn't be one huge page
> enough? Or do we need to allocate a few of them?

Good question.

Actually, I tried to allocate 1 Huge page size (2MB, x86_64) before
but the BUG can not be reproduced (everything goes well on my system).

After trying some more times, I found that if just extend to allocate
more than 1 (at least 2) Huge pages in the test, bug could be
reproduced again.

So, I would like to amend the test in allocating 2 Huge page size in PATCH v2.


FYI:

While support_numa.c trying to allocate 2 huge page on the Node1 we
specified, it does NOT do as we expected, it just fallbacks to local
node Node0.

# grep -i hugepagesize /proc/meminfo
Hugepagesize:       2048 kB

# lscpu |grep NUMA
NUMA node(s):          8
NUMA node0 CPU(s):     0,4,8,12
NUMA node1 CPU(s):     16,20,24,28
NUMA node2 CPU(s):     1,5,9,13
NUMA node3 CPU(s):     17,21,25,29
NUMA node4 CPU(s):     2,6,10,14
NUMA node5 CPU(s):     18,22,26,30
NUMA node6 CPU(s):     19,23,27,31
NUMA node7 CPU(s):     3,7,11,15


# numactl --cpunodebind=0 --preferred=1 ./support_numa alloc_2HPSZ_THP &
[1] 21956

# numastat -p 21956

Per-node process memory usage (in MBs) for PID 21956 (support_numa)
                           Node 0          Node 1          Node 2
                  --------------- --------------- ---------------
Huge                         0.00            0.00            0.00
Heap                         0.00            0.00            0.00
Stack                        0.00            0.02            0.00
Private                      2.33            2.19            0.01
----------------  --------------- --------------- ---------------
Total                        2.33            2.22            0.01

                           Node 3          Node 4          Node 5
                  --------------- --------------- ---------------
Huge                         0.00            0.00            0.00
Heap                         0.00            0.00            0.00
Stack                        0.00            0.00            0.00
Private                      0.00            0.00            0.00
----------------  --------------- --------------- ---------------
Total                        0.00            0.00            0.00

                           Node 6          Node 7           Total
                  --------------- --------------- ---------------
Huge                         0.00            0.00            0.00
Heap                         0.00            0.00            0.00
Stack                        0.00            0.00            0.02
Private                      0.00            0.00            4.53
----------------  --------------- --------------- ---------------
Total                        0.00            0.00            4.55




>
>>  tst_run
>> diff --git a/testcases/kernel/numa/support_numa.c b/testcases/kernel/numa/support_numa.c
>> index 4904cc5..37790e7 100644
>> --- a/testcases/kernel/numa/support_numa.c
>> +++ b/testcases/kernel/numa/support_numa.c
>> @@ -53,6 +53,7 @@ static void help(void)
>>       printf("Input:  Describe input arguments to this program\n");
>>       printf("        argv[1] == \"alloc_1MB\" then allocate 1MB of memory\n");
>>       printf("        argv[1] == \"alloc_1MB_shared\" then allocate 1MB of share memory\n");
>> +     printf("        argv[1] == \"alloc_1GB_THP\" then allocate 1GB of THP memory\n");
>>       printf("        argv[1] == \"alloc_1huge_page\" then allocate 1HUGE PAGE SIZE of memory\n");
>>       printf("        argv[1] == \"pause\" then pause the program to catch sigint\n");
>>       printf("Exit:   On failure - Exits with non-zero value\n");
>> @@ -138,6 +139,22 @@ int main(int argc, char *argv[])
>>               munmap(buf, sb.st_size);
>>               close(fd);
>>               remove(TEST_SFILE);
>> +     } else if (!strcmp(argv[1], "alloc_1GB_THP")) {
>> +             size_t size = 1024 * MB;
>> +
>> +             buf = mmap(NULL, size, PROT_READ | PROT_WRITE,
>> +                             MAP_PRIVATE | MAP_ANONYMOUS,
>> +                             -1, 0);
>> +             if (buf == MAP_FAILED) {
>> +                     perror("mmap failed");
>> +                     exit(1);
>> +             }
>> +
>> +             memset(buf, 'a', size);
>> +
>> +             raise(SIGSTOP);
>> +
>> +             munmap(buf, size);
>>       } else if (!strcmp(argv[1], "alloc_1huge_page")) {
>>               hpsz = read_hugepagesize();
>>               if (hpsz == 0)
>> --
>> 2.9.3
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>
> --
> Cyril Hrubis
> chrubis@suse.cz



-- 
Li Wang
liwang@redhat.com
