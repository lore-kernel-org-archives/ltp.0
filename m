From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Tue, 9 Oct 2018 08:45:31 -0300
Subject: [LTP] LTP: futex_wake04 hangs forever on i386
In-Reply-To: <20181009092821.GA16630@rei>
References: <CA+G9fYs13QZtsREe3dvic+G6VPQ1dJroKH0sguBiNdtizRTeNQ@mail.gmail.com>
 <20181008133059.GB30978@rei>
 <3dbee853-6bce-d057-f42a-655a8f2991c3@linaro.org>
 <20181009092821.GA16630@rei>
Message-ID: <84a1e57f-4be2-272d-6db2-c4dd5e8391ea@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>> And there wasn't a second thread task id inside:
>>
>> /proc/<pid>/task/{<pid>, <tid1>, <tid2>}
>>
>> like it should.
>>
>> Likely the task creation (because of error ? check last part) logic here
>> was faster than wait_for_threads() logic could expect... causing a race
>> for the test's logic.
> 
> That shouldn't really happen, the wait_for_threads(2) function is called
> in a loop until there are two sleeping threads under the
> /proc/$pid/task/ directory (minus the main thread). So unless there is a
> problem with starting a thread or locking on a futex the loop will end
> eventually and the futexes are unlocked only after this loop finishes.

Yes, I'll check why.

>> Reading hugetlb_report_meminfo() in hugetlb.c, I am not sure (struct
>> hstat *h)->nr_huge_pages should change that much (through new hugepages
>> being asked for, sysctl, or numa balance, among other options). I'll try
>> to trace this tomorrow to see who is touching the HugePages_Total during
>> the test.
> 
> That is because the test modifies the size of the huge pages pool itself
> in the test setup so that it can run on a systems where the default is
> set to 0. I guess that we should change it so that it check if the
> orig_hugepages is non-zero or not and only change the value if it's
> zero.

Hum, I missed that =), tks. Will get back to you soon on this.

