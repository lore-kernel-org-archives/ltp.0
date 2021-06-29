From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 29 Jun 2021 20:06:30 +0200
Subject: [LTP] [BUG] btrfs potential failure on 32 core LTP test
 (fallocate05)
In-Reply-To: <0b6a502a-8db8-ef27-f48e-5001f351ef24@toxicpanda.com>
References: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
 <124d7ead-6600-f369-7af1-a1bc27df135c@toxicpanda.com>
 <667133e5-44cb-8d95-c40a-12ac82f186f0@canonical.com>
 <0b6a502a-8db8-ef27-f48e-5001f351ef24@toxicpanda.com>
Message-ID: <2576a472-1c99-889a-685c-a12bbfb08052@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 29/06/2021 19:28, Josef Bacik wrote:
> On 6/29/21 1:26 PM, Krzysztof Kozlowski wrote:
>> On 29/06/2021 19:24, Josef Bacik wrote:
>>> On 6/29/21 1:00 PM, Krzysztof Kozlowski wrote:
>>>> Dear BTRFS folks,
>>>>
>>>> I am hitting a potential regression of btrfs, visible only with
>>>> fallocate05 test from LTP (Linux Test Project) only on 32+ core Azure
>>>> instances (x86_64).
>>>>
>>>> Tested:
>>>> v5.8 (Ubuntu with our stable patches): PASS
>>>> v5.11 (Ubuntu with our stable patches): FAIL
>>>> v5.13 mainline: FAIL
>>>>
>>>> PASS means test passes on all instances
>>>> FAIL means test passes on other instance types (e.g. 4 or 16 core) but
>>>> fails on 32 and 64 core instances (did not test higher),
>>>> e.g.: Standard_F32s_v2, Standard_F64s_v2, Standard_D32s_v3,
>>>> Standard_E32s_v3
>>>>
>>>> Reproduction steps:
>>>> git clone https://github.com/linux-test-project/ltp.git
>>>> cd ltp
>>>> ./build.sh && make install -j8
>>>> cd ../ltp-install
>>>> sudo ./runltp -f syscalls -s fallocate05
>>>>
>>>> Failure output:
>>>> tst_test.c:1379: TINFO: Testing on btrfs
>>>> tst_test.c:888: TINFO: Formatting /dev/loop4 with btrfs opts='' extra opts=''
>>>> tst_test.c:1311: TINFO: Timeout per run is 0h 05m 00s
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file5 size 4807935
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file6 size 90739786
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file7 size 76896492
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file8 size 72228649
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file9 size 36207821
>>>> tst_fill_fs.c:32: TINFO: Creating file mntpoint/file10 size 81483962
>>>> tst_fill_fs.c:59: TINFO: write(): ENOSPC (28)
>>>> fallocate05.c:81: TPASS: write() wrote 65536 bytes
>>>> fallocate05.c:102: TINFO: fallocate()d 0 extra blocks on full FS
>>>> fallocate05.c:114: TPASS: fallocate() on full FS
>>>> fallocate05.c:130: TPASS: fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
>>>> fallocate05.c:134: TFAIL: write(): ENOSPC (28)
>>>>
>>>> Test code:
>>>> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fallocate/fallocate05.c#L134
>>>>
>>>> See also: https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1933112
>>>>
>>>> Other FS tests succeed on that machines/kernels. Other file systems
>>>> also pass - only btrfs fails. The issue was not bisected. Full test
>>>> log attached.
>>>>
>>>
>>> Also it looks like you're using a loop device, the instructions you gave me
>>> aren't complete enough for me to reproduce.  What is the actual setup you are
>>> using?  How big is your loop device?  Is it a backing device?  I had to do -b
>>> <device> to get the test to even start to run, but I've got a 2tib ssd, am I
>>> supposed to be using something else?  Thanks,
>>
>> The test takes care about loop device, nothing is needed from your side.
>> Just run the test and wait till you see:
>> "tst_test.c:1379: TINFO: Testing on btrfs"
>>
>> That's where the interesting part starts :)
>>
> 
> *cough*
> # CONFIG_BLK_DEV_LOOP is not set
> *cough*
> 
> I think I found the problem, my bad,
> 

Minor update - it's not only Azure's. AWS m5.8xlarge and m5.16xlarge (32
and 64 cores) fail similarly. I'll try later also QEMU machines with
different amount of CPUs.

Best regards,
Krzysztof
