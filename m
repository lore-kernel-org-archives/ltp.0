From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 6 Sep 2016 18:03:58 +0530
Subject: [LTP] [v2] readahead02: fix read_ahead_kb file not found
In-Reply-To: <747949240.1570236.1473060993124.JavaMail.zimbra@redhat.com>
References: <1472812953-30811-1-git-send-email-naresh.kamboju@linaro.org>
 <747949240.1570236.1473060993124.JavaMail.zimbra@redhat.com>
Message-ID: <CA+G9fYvFO3yVs1j89jCD=WxQBSUH-ZZL-Go-Yjvd5-P8Vpzn9Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Jan,

On 5 September 2016 at 13:06, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
>> From: "naresh kamboju" <naresh.kamboju@linaro.org>
>> To: chrubis@suse.cz, ltp@lists.linux.it
>> Cc: akpm@linux-foundation.org, "fengguang wu" <fengguang.wu@intel.com>, "graeme gregory" <graeme.gregory@linaro.org>,
>> "milosz wasilewski" <milosz.wasilewski@linaro.org>
>> Sent: Friday, 2 September, 2016 12:42:33 PM
>> Subject: [LTP] [v2] readahead02: fix read_ahead_kb file not found
>>
>> From: Naresh Kamboju <naresh.kamboju@linaro.org>
>>
>> Test case is looking for read_ahead_kb file on a partition device (8:2) and
>> not on block device (8:0/8:16/8:32/8:48). The appropriate block device that
>> holds the partition can be found at queue/read_ahead_kb entry.
>>
>> Before patch readahead02 test broken,
>> readahead02    1  TBROK  :  safe_file_ops.c:144: Failed to open FILE
>> '/sys/dev/block/8:2/queue/read_ahead_kb' for reading at
>> readahead02.c:197: errno=ENOENT(2): No such file or directory
>>
>> After applying patch,
>> readahead02    0  TINFO  :  creating test file of size: 67108864
>> readahead02    0  TINFO  :  max readahead size is: 131072
>> readahead02    0  TINFO  :  read_testfile(0)
>> readahead02    0  TINFO  :  max readahead size is: 131072
>> readahead02    0  TINFO  :  read_testfile(1)
>> readahead02    0  TINFO  :  max readahead size is: 131072
>> readahead02    1  TPASS  :  expected ret success - returned value = 0
>> readahead02    2  TPASS  :  offset is still at 0 as expected
>> readahead02    0  TINFO  :  read_testfile(0) took: 1437202 usec
>> readahead02    0  TINFO  :  read_testfile(1) took: 1361915 usec
>> readahead02    0  TINFO  :  read_testfile(0) read: 67108864 bytes
>> readahead02    0  TINFO  :  read_testfile(1) read: 0 bytes
>> readahead02    3  TPASS  :  readahead saved some I/O
>> readahead02    0  TINFO  :  cache can hold at least: 157404 kB
>> readahead02    0  TINFO  :  read_testfile(0) used cache: 65332 kB
>> readahead02    0  TINFO  :  read_testfile(1) used cache: 65636 kB
>> readahead02    4  TPASS  :  using cache as expected
>
> This doesn't seem to be true for all entries under /sys/dev/block.
> If I ran your patch on lvm, testcase fails:

Thanks for your findings.
I have tested on Ubuntu and Debian.

We have to refactor this test case to work on multi distribution.
I have to find a machine running CentOS and debug this case.

>
> # ./readahead02
> readahead02    0  TINFO  :  creating test file of size: 67108864
> readahead02    1  TBROK  :  safe_file_ops.c:144: Failed to open FILE '/sys/dev/block/253:1/../queue/read_ahead_kb' for reading at readahead02.c:202: errno=ENOENT(2): No such file or directory
> readahead02    2  TBROK  :  safe_file_ops.c:144: Remaining cases broken
>
> # ll /sys/dev/block/253:1
> lrwxrwxrwx. 1 root root 0 Sep  5 09:21 /sys/dev/block/253:1 -> ../../devices/virtual/block/dm-1
>
> # ll /sys/dev/block/253:1/
> total 0
> -r--r--r--. 1 root root 4096 Sep  5 09:25 alignment_offset
> -rw-r--r--. 1 root root 4096 Sep  5 09:25 badblocks
> lrwxrwxrwx. 1 root root    0 Sep  5 09:21 bdi -> ../../bdi/253:1
> -r--r--r--. 1 root root 4096 Sep  5 09:25 capability
> -r--r--r--. 1 root root 4096 Sep  5 09:25 dev
> -r--r--r--. 1 root root 4096 Sep  5 09:25 discard_alignment
> drwxr-xr-x. 2 root root    0 Sep  5 09:25 dm
> -r--r--r--. 1 root root 4096 Sep  5 09:25 ext_range
> drwxr-xr-x. 2 root root    0 Sep  5 09:25 holders
> -r--r--r--. 1 root root 4096 Sep  5 09:25 inflight
> drwxr-xr-x. 2 root root    0 Sep  5 09:25 integrity
> drwxr-xr-x. 2 root root    0 Sep  5 09:25 power
> drwxr-xr-x. 2 root root    0 Sep  5 09:25 queue

read_ahead_kb file should present in queue folder.
Is this test case pass on this machine *without* my patch ?
/sys/dev/block/253:1/queue/read_ahead_kb


> -r--r--r--. 1 root root 4096 Sep  5 09:25 range
> -r--r--r--. 1 root root 4096 Sep  5 09:25 removable
> -r--r--r--. 1 root root 4096 Sep  5 09:25 ro
> -r--r--r--. 1 root root 4096 Sep  5 09:25 size
> drwxr-xr-x. 2 root root    0 Sep  5 09:25 slaves
> -r--r--r--. 1 root root 4096 Sep  5 09:25 stat
> lrwxrwxrwx. 1 root root    0 Sep  5 09:21 subsystem -> ../../../../class/block
> drwxr-xr-x. 2 root root    0 Sep  5 09:25 trace
> -rw-r--r--. 1 root root 4096 Sep  5 09:25 uevent
>
> # lsblk
> NAME                        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> vda                         252:0    0   35G  0 disk
> ├─vda1                      252:1    0  500M  0 part /boot
> └─vda2                      252:2    0 34.5G  0 part
>   ├─rhel_dhcp--27--118-swap 253:0    0    2G  0 lvm  [SWAP]
>   └─rhel_dhcp--27--118-root 253:1    0 32.5G  0 lvm  /

Is it a physical drive or Virtual drive ?
In general I use vda for KVM.

>
> # uname -r
> 4.7.0-rc7+

Thank you.

Best regards
Naresh Kamboju

>
> Regards,
> Jan
