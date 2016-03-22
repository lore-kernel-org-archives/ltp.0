From: Cui Bixuan <cuibixuan@huawei.com>
Date: Tue, 22 Mar 2016 21:49:13 +0800
Subject: [LTP] max_map_count fail in arm64 system which support lib32
In-Reply-To: <20160322102943.GA10195@rei.suse.cz>
References: <56DD6138.9060109@huawei.com> <20160322102943.GA10195@rei.suse.cz>
Message-ID: <56F14D59.1040701@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2016/3/22 18:29, Cyril Hrubis wrote:
> Hi!
>> ./max_map_count_32
>> max_map_count    0  TINFO  :  set overcommit_memory to 2
>> max_map_count    0  TINFO  :  set max_map_count to 64
>> max_map_count    1  TFAIL  :  max_map_count.c:233: 64 map entries in total, but expected 64 entries
>> max_map_count    0  TINFO  :  set max_map_count to 256
>> max_map_count    2  TFAIL  :  max_map_count.c:233: 256 map entries in total, but expected 256 entries
>> max_map_count    0  TINFO  :  set max_map_count to 1024
>> max_map_count    3  TFAIL  :  max_map_count.c:233: 1024 map entries in total, but expected 1024 entries
>> max_map_count    0  TINFO  :  set max_map_count to 4096
>> max_map_count    4  TFAIL  :  max_map_count.c:233: 4096 map entries in total, but expected 4096 entries
>> max_map_count    0  TINFO  :  set max_map_count to 16384
>> max_map_count    5  TFAIL  :  max_map_count.c:233: 16384 map entries in total, but expected 16384 entries
>> max_map_count    0  TINFO  :  set max_map_count to 65536
>> max_map_count    6  TFAIL  :  max_map_count.c:233: 65536 map entries in total, but expected 65536 entries
>> max_map_count    0  TINFO  :  set overcommit_memory to 0
>> max_map_count    0  TINFO  :  set max_map_count to 65530
>>
>>     When I use 32-bit SDK, it will compile at:
>>
>> 	#elif defined(__arm__)
>>         	/* Older arm kernels didn't label their vdso maps */
>>         	if (!strncmp(line, "ffff0000-ffff1000", 17))
>>                 	return true;
> 
> So you compile 32bit binary and run it on 64bit arm kernel and it
> wrongly skips one mapping?
> 
>>     and not:
>> 	#elif defined(__ia64__)
>>         	/* On ia64, the vdso is not a proper mapping */
>>         	if (!strcmp(buf, "[vdso]"))
>>                 	return true;
> 
> __ia64__ is itanium, I guess that the function always returns false when
> compiled for 64bit arm.
> 
> The solution may be runtime detection for 32bit/64bit kernel on arm. We
> can look at the machine string in the struct utsname returned from
> uname(2) to get that information.
Hi,
I add a print:

#elif defined(__arm__)
if (!strncmp(line, "ffff0000-ffff1000", 17))
        {
                printf("%s\n", line);  // I add
                return true;
        }

and then run it(32bit SDK):

./max_map_count
max_map_count    0  TINFO  :  set overcommit_memory to 2
max_map_count    0  TINFO  :  set max_map_count to 64
ffff0000-ffff1000 r-xp 00000000 00:00 0                                  [vectors]
max_map_count    1  TFAIL  :  max_map_count.c:242: 64 map entries in total, but expected 64 entries

So we know why it failed:
It skip 'ffff0000-ffff1000' in arm64 kernel when we use 32bit SDK, but it doesn't skip when use 64bit SDK.
Maybe the error is caused by the different sdk.


And I do this test for arm32 system:
arma9el:/tmp# ./max_map_count
max_map_count    0  TINFO  :  set overcommit_memory to 2
max_map_count    0  TINFO  :  set max_map_count to 64
ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]
max_map_count    1  TPASS  :  max_maps:64 map_count:65  map entries in total as expected.

It skip 'ffff0000-ffff1000' in arm32 but passed.

Look at max_map_count.c:
 * Note: On some architectures there is a special vma VSYSCALL, which
 * is allocated without incrementing mm->map_count variable. On these
 * architectures each /proc/<pid>/maps has at the end:
...

So I think:
* arm 64bit kernel doesn't have 'special vma VSYSCALL' so no need to skip(32bit binary skip so fail);
* arm 32bit kernel have 'special vma VSYSCALL';

Is it right :-D?

Thanks
Cui Bixuan
> 

