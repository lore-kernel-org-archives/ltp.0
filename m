From: Pako Fonseca <ratjar501@gmail.com>
Date: Fri, 29 Sep 2017 15:44:13 -0500
Subject: [LTP] Issue running cpuset_base_ops_testset shell script
In-Reply-To: <CALhEcWGfV5ZUqe6tyipqNFaFVgdr632ig_Fpc7UJR8fQFWcjFA@mail.gmail.com>
References: <CALhEcWHtmEd+VHOOSHCzpLppCRVAe8pUYrJD1+aGim=4oA2T7g@mail.gmail.com>
 <1171612333.22940868.1506499575369.JavaMail.zimbra@redhat.com>
 <CALhEcWGfV5ZUqe6tyipqNFaFVgdr632ig_Fpc7UJR8fQFWcjFA@mail.gmail.com>
Message-ID: <CALhEcWEE0JePgjF1p07XXhHMLDhOBVKU9hsS26UJKi8DQzN+pg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I applied the patch and investigated a little bit more and resolved
it! Apparently the cpuset route is different!

In centOS, RHEL and Suse cpuset is located in /sys/fs/cgroup/cpuset so
when i unmounted and ran again the tests all of them were successful.

Thanks a lot for your help all of you guys! :)

2017-09-27 18:21 GMT-05:00 Pako Fonseca <ratjar501@gmail.com>:
> Hi again :)
>
> 2017-09-27 3:06 GMT-05:00 Jan Stancek <jstancek@redhat.com>:
>>
>> ----- Original Message -----
>>> **LTP Version: 20160920
>>
>> This is quite old.
>>
>>> Kernel Version: 3.10.0-327.el7.x86_64
>>> OS: CentOS Linux release 7.2.1511 (Core)**
>>>
>>> Good day, i'm trying to run this test script
>>> "**cpuset_base_ops_testset.sh**" but when i do that i have multiple
>>> errors related to some missing devices under **/dev/cpuset/** here is
>>> the output:
>>> ```
>>> opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
>>> /dev/cpuset/cpus: Permission denied
>>
>> And I assume you are running systemd, which mounts it elsewhere
>> and test can't cope with that.
>>
>> I think there was a patch posted:
>>   http://lists.linux.it/pipermail/ltp/2017-April/004348.html
>> but it looks it might have been forgotten after the last release.
>>
>> Would you care to give it a try with latest LTP?
>>
>> Regards,
>> Jan
>
> Yes i'm using systemd and i already downloaded the last stable release
> and I have this output, i changed the operative system below the
> output and specs.
>
> OS: Red Hat Enterprise Linux Server release 7.2
> Kernel: 3.10.0-327.el7.x86_64
> LTP: 20170516
>
> Running tests.......
> <<<test_start>>>
> tag=cpuset_base_ops stime=1453936149
> cmdline="cpuset_base_ops_testset.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/cpus: Permission denied
> cat: /dev/cpuset/cpus: No such file or directory
> cpuset_base_ops 1 TPASS: cpus(READONLY): Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/mems: Permission denied
> cat: /dev/cpuset/mems: No such file or directory
> cpuset_base_ops 3 TPASS: mems(READONLY): Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_pressure: Permission denied
> cat: /dev/cpuset/memory_pressure: No such file or directory
> cpuset_base_ops 5 TPASS: memory_pressure(READONLY): Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 7 TFAIL: cpus: Test result -  Expected string - "EMPTY"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 9 TFAIL: cpus: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 11 TPASS: cpus: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 13 TFAIL: cpus: Test result -  Expected string - "0-255"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 15 TPASS: cpus: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 17 TFAIL: cpus: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 19 TFAIL: cpus: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 21 TFAIL: cpus: Test result -  Expected string - "0-255"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 23 TPASS: cpus: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 25 TPASS: cpus: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 27 TPASS: cpus: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 29 TPASS: cpus: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 31 TPASS: cpus: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 33 TFAIL: cpus: Test result -  Expected string - "0-255"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 35 TFAIL: cpus: Test result -  Expected string - "0-254"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/cpus: Permission denied
> cat: /dev/cpuset/1/cpus: No such file or directory
> cpuset_base_ops 37 TFAIL: cpus: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 39 TFAIL: mems: Test result -  Expected string - "EMPTY"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 41 TFAIL: mems: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 43 TPASS: mems: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 45 TFAIL: mems: Test result -  Expected string - "0-1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 47 TPASS: mems: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 49 TFAIL: mems: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 51 TFAIL: mems: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 53 TFAIL: mems: Test result -  Expected string - "0-1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 55 TPASS: mems: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 57 TPASS: mems: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 59 TPASS: mems: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 61 TPASS: mems: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 63 TPASS: mems: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/1/mems: Permission denied
> cat: /dev/cpuset/1/mems: No such file or directory
> cpuset_base_ops 65 TFAIL: mems: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/cpu_exclusive: Permission denied
> cat: /dev/cpuset/cpu_exclusive: No such file or directory
> cpuset_base_ops 67 TFAIL: cpu_exclusive: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/cpu_exclusive: Permission denied
> cat: /dev/cpuset/cpu_exclusive: No such file or directory
> cpuset_base_ops 69 TFAIL: cpu_exclusive: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/cpu_exclusive: Permission denied
> cat: /dev/cpuset/cpu_exclusive: No such file or directory
> cpuset_base_ops 71 TFAIL: cpu_exclusive: Test result -  Expected string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/cpu_exclusive: Permission denied
> cat: /dev/cpuset/cpu_exclusive: No such file or directory
> cpuset_base_ops 73 TPASS: cpu_exclusive: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/cpu_exclusive: Permission denied
> cat: /dev/cpuset/cpu_exclusive: No such file or directory
> cpuset_base_ops 75 TPASS: cpu_exclusive: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/cpu_exclusive: Permission denied
> cat: /dev/cpuset/cpu_exclusive: No such file or directory
> cpuset_base_ops 77 TFAIL: cpu_exclusive: Test result -  Expected string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/mem_exclusive: Permission denied
> cat: /dev/cpuset/mem_exclusive: No such file or directory
> cpuset_base_ops 79 TFAIL: mem_exclusive: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/mem_exclusive: Permission denied
> cat: /dev/cpuset/mem_exclusive: No such file or directory
> cpuset_base_ops 81 TFAIL: mem_exclusive: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/mem_exclusive: Permission denied
> cat: /dev/cpuset/mem_exclusive: No such file or directory
> cpuset_base_ops 83 TFAIL: mem_exclusive: Test result -  Expected string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/mem_exclusive: Permission denied
> cat: /dev/cpuset/mem_exclusive: No such file or directory
> cpuset_base_ops 85 TPASS: mem_exclusive: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/mem_exclusive: Permission denied
> cat: /dev/cpuset/mem_exclusive: No such file or directory
> cpuset_base_ops 87 TPASS: mem_exclusive: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/mem_exclusive: Permission denied
> cat: /dev/cpuset/mem_exclusive: No such file or directory
> cpuset_base_ops 89 TFAIL: mem_exclusive: Test result -  Expected string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/mem_hardwall: Permission denied
> cat: /dev/cpuset/mem_hardwall: No such file or directory
> cpuset_base_ops 91 TFAIL: mem_hardwall: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/mem_hardwall: Permission denied
> cat: /dev/cpuset/mem_hardwall: No such file or directory
> cpuset_base_ops 93 TFAIL: mem_hardwall: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/mem_hardwall: Permission denied
> cat: /dev/cpuset/mem_hardwall: No such file or directory
> cpuset_base_ops 95 TFAIL: mem_hardwall: Test result -  Expected string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/mem_hardwall: Permission denied
> cat: /dev/cpuset/mem_hardwall: No such file or directory
> cpuset_base_ops 97 TPASS: mem_hardwall: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/mem_hardwall: Permission denied
> cat: /dev/cpuset/mem_hardwall: No such file or directory
> cpuset_base_ops 99 TPASS: mem_hardwall: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/mem_hardwall: Permission denied
> cat: /dev/cpuset/mem_hardwall: No such file or directory
> cpuset_base_ops 101 TFAIL: mem_hardwall: Test result -  Expected string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_migrate: Permission denied
> cat: /dev/cpuset/memory_migrate: No such file or directory
> cpuset_base_ops 103 TFAIL: memory_migrate: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_migrate: Permission denied
> cat: /dev/cpuset/memory_migrate: No such file or directory
> cpuset_base_ops 105 TFAIL: memory_migrate: Test result -  Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_migrate: Permission denied
> cat: /dev/cpuset/memory_migrate: No such file or directory
> cpuset_base_ops 107 TFAIL: memory_migrate: Test result -  Expected string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_migrate: Permission denied
> cat: /dev/cpuset/memory_migrate: No such file or directory
> cpuset_base_ops 109 TPASS: memory_migrate: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_migrate: Permission denied
> cat: /dev/cpuset/memory_migrate: No such file or directory
> cpuset_base_ops 111 TPASS: memory_migrate: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_migrate: Permission denied
> cat: /dev/cpuset/memory_migrate: No such file or directory
> cpuset_base_ops 113 TFAIL: memory_migrate: Test result -  Expected string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_spread_page: Permission denied
> cat: /dev/cpuset/memory_spread_page: No such file or directory
> cpuset_base_ops 115 TFAIL: memory_spread_page: Test result -  Expected
> string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_spread_page: Permission denied
> cat: /dev/cpuset/memory_spread_page: No such file or directory
> cpuset_base_ops 117 TFAIL: memory_spread_page: Test result -  Expected
> string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_spread_page: Permission denied
> cat: /dev/cpuset/memory_spread_page: No such file or directory
> cpuset_base_ops 119 TFAIL: memory_spread_page: Test result -  Expected
> string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_spread_page: Permission denied
> cat: /dev/cpuset/memory_spread_page: No such file or directory
> cpuset_base_ops 121 TPASS: memory_spread_page: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_spread_page: Permission denied
> cat: /dev/cpuset/memory_spread_page: No such file or directory
> cpuset_base_ops 123 TPASS: memory_spread_page: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_spread_page: Permission denied
> cat: /dev/cpuset/memory_spread_page: No such file or directory
> cpuset_base_ops 125 TFAIL: memory_spread_page: Test result -  Expected
> string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_spread_slab: Permission denied
> cat: /dev/cpuset/memory_spread_slab: No such file or directory
> cpuset_base_ops 127 TFAIL: memory_spread_slab: Test result -  Expected
> string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_spread_slab: Permission denied
> cat: /dev/cpuset/memory_spread_slab: No such file or directory
> cpuset_base_ops 129 TFAIL: memory_spread_slab: Test result -  Expected
> string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_spread_slab: Permission denied
> cat: /dev/cpuset/memory_spread_slab: No such file or directory
> cpuset_base_ops 131 TFAIL: memory_spread_slab: Test result -  Expected
> string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_spread_slab: Permission denied
> cat: /dev/cpuset/memory_spread_slab: No such file or directory
> cpuset_base_ops 133 TPASS: memory_spread_slab: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_spread_slab: Permission denied
> cat: /dev/cpuset/memory_spread_slab: No such file or directory
> cpuset_base_ops 135 TPASS: memory_spread_slab: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_spread_slab: Permission denied
> cat: /dev/cpuset/memory_spread_slab: No such file or directory
> cpuset_base_ops 137 TFAIL: memory_spread_slab: Test result -  Expected
> string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/sched_load_balance: Permission denied
> cat: /dev/cpuset/sched_load_balance: No such file or directory
> cpuset_base_ops 139 TFAIL: sched_load_balance: Test result -  Expected
> string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/sched_load_balance: Permission denied
> cat: /dev/cpuset/sched_load_balance: No such file or directory
> cpuset_base_ops 141 TFAIL: sched_load_balance: Test result -  Expected
> string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/sched_load_balance: Permission denied
> cat: /dev/cpuset/sched_load_balance: No such file or directory
> cpuset_base_ops 143 TFAIL: sched_load_balance: Test result -  Expected
> string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/sched_load_balance: Permission denied
> cat: /dev/cpuset/sched_load_balance: No such file or directory
> cpuset_base_ops 145 TPASS: sched_load_balance: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/sched_load_balance: Permission denied
> cat: /dev/cpuset/sched_load_balance: No such file or directory
> cpuset_base_ops 147 TPASS: sched_load_balance: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/sched_load_balance: Permission denied
> cat: /dev/cpuset/sched_load_balance: No such file or directory
> cpuset_base_ops 149 TFAIL: sched_load_balance: Test result -  Expected
> string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_pressure_enabled: Permission denied
> cat: /dev/cpuset/memory_pressure_enabled: No such file or directory
> cpuset_base_ops 151 TFAIL: memory_pressure_enabled: Test result -
> Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_pressure_enabled: Permission denied
> cat: /dev/cpuset/memory_pressure_enabled: No such file or directory
> cpuset_base_ops 153 TFAIL: memory_pressure_enabled: Test result -
> Expected string - "0"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_pressure_enabled: Permission denied
> cat: /dev/cpuset/memory_pressure_enabled: No such file or directory
> cpuset_base_ops 155 TFAIL: memory_pressure_enabled: Test result -
> Expected string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_pressure_enabled: Permission denied
> cat: /dev/cpuset/memory_pressure_enabled: No such file or directory
> cpuset_base_ops 157 TPASS: memory_pressure_enabled: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_pressure_enabled: Permission denied
> cat: /dev/cpuset/memory_pressure_enabled: No such file or directory
> cpuset_base_ops 159 TPASS: memory_pressure_enabled: Get the expected string
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
> /dev/cpuset/memory_pressure_enabled: Permission denied
> cat: /dev/cpuset/memory_pressure_enabled: No such file or directory
> cpuset_base_ops 161 TFAIL: memory_pressure_enabled: Test result -
> Expected string - "1"
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 223:
> /dev/cpuset/sub_cpuset/cpus: Permission denied
> cpuset_base_ops 163 TPASS: Attaching Task Test successed!!
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 197: 53295
> Terminated              cat /dev/zero > /dev/null
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 223:
> /dev/cpuset/sub_cpuset/cpus: Permission denied
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 226:
> /dev/cpuset/sub_cpuset/mems: Permission denied
> cpuset_base_ops 165 TFAIL: Attaching Task Test failed!! cpus - "0",
> mems - "0", Expect - "0", Fact - "". (0 - Attach Success, 1 - Attach
> Fail)
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 197: 53311
> Terminated              cat /dev/zero > /dev/null
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 226:
> /dev/cpuset/sub_cpuset/mems: Permission denied
> cpuset_base_ops 167 TPASS: Attaching Task Test successed!!
> /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 197: 53327
> Terminated              cat /dev/zero > /dev/null
> incrementing stop
> <<<execution_status>>>
> initiation_status="ok"
> duration=5 termination_type=exited termination_id=1 corefile=no
> cutime=174 cstime=504
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: 20170516
>
>        ###############################################################
>
>             Done executing testcases.
>             LTP Version:  20170516
>        ###############################################################
>
> Apparently I still have that output related with permission denied,
> what do you think?
> A lot of thanks for your help!
>
> 2017-09-27 3:06 GMT-05:00 Jan Stancek <jstancek@redhat.com>:
>>
>> ----- Original Message -----
>>> **LTP Version: 20160920
>>
>> This is quite old.
>>
>>> Kernel Version: 3.10.0-327.el7.x86_64
>>> OS: CentOS Linux release 7.2.1511 (Core)**
>>>
>>> Good day, i'm trying to run this test script
>>> "**cpuset_base_ops_testset.sh**" but when i do that i have multiple
>>> errors related to some missing devices under **/dev/cpuset/** here is
>>> the output:
>>> ```
>>> opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 58:
>>> /dev/cpuset/cpus: Permission denied
>>
>> And I assume you are running systemd, which mounts it elsewhere
>> and test can't cope with that.
>>
>> I think there was a patch posted:
>>   http://lists.linux.it/pipermail/ltp/2017-April/004348.html
>> but it looks it might have been forgotten after the last release.
>>
>> Would you care to give it a try with latest LTP?
>>
>> Regards,
>> Jan
