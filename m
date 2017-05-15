From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 15 May 2017 13:06:28 +0530
Subject: [LTP] LTP: readahead02 failed
In-Reply-To: <1149421133.11389918.1494832929012.JavaMail.zimbra@redhat.com>
References: <CA+G9fYvHus+AB1CD4AGxw3pOAKavO=gQ0W2zfPSZ-qkUac9U-w@mail.gmail.com>
 <1149421133.11389918.1494832929012.JavaMail.zimbra@redhat.com>
Message-ID: <CA+G9fYto4qkFzCUG5KAPFZG89i=t=JX2Y9_19ceju5NHBmSu_w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

On 15 May 2017 at 12:52, Jan Stancek <jstancek@redhat.com> wrote:
>
> ----- Original Message -----
>> Hi Team,
>>
>> readahead02 failed on HiKey board with below error message.
>> 1. Any minimal limitation of Buffers size or Cached size should have
>> to pass this test case ?  if yes we would change test logic to detect
>> and skip test run.
>
> Hi,
>
> Your system appears to have plenty of memory for this test.
>
>> 2. The first FAIL message is not giving enough information (*) there
>> is a room for improvement here.
>
> I pushed a patch to include errno code in failure message.
>
>> 3.  strace output show Invalid argument for readahead()
>>
>> readahead(3, 0, 67108864)               = -1 EINVAL (Invalid argument)
>> write(1, "readahead02    1  TFAIL  :  read"..., 100readahead02    1
>> TFAIL  :  readahead02.c:86: unexpected failure - returned value = -1,
>> expected: 0
>> ) = 100
>>
>> The man page have explanation of EINVAL is
>> EINVAL fd  does  not  refer  to a file type to which readahead() can be
>> applied.
>
> Have you run into this with any of previous kernels?
>
> What filesystem is /tmp? Is it tmpfs?

root@hikey:/opt/ltp/testcases/bin# mount | grep /tmp
tmpfs on /tmp type tmpfs (rw)

root@hikey:/opt/ltp/testcases/bin# cat /proc/filesystems | grep tmpfs
nodev   tmpfs
nodev   devtmpfs

>
> Can you try with LTP tmpdir backed by different fs?
> For example: env TMPDIR=/root/ ./readahead02

The  "/" root filesystem mounted type as ext4.
/dev/mmcblk0p9 on / type ext4 (rw,relatime,data=ordered)

By changing the TMPDIR environment variable, the test case
"readahead02" got pass. Thanks :)

root@hikey:/opt/ltp/testcases/bin# env TMPDIR=/home/root/
./readahead02
readahead02    0  TINFO  :  creating test file of size: 67108864
[ 4115.161936] readahead02 (2633): drop_caches: 1
readahead02    0  TINFO  :  read_testfile(0)
[ 4117.074675] readahead02 (2633): drop_caches: 1
readahead02    0  TINFO  :  read_testfile(1)
readahead02    0  TINFO  :  max ra estimate: 249856
readahead02    0  TINFO  :  readahead calls made: 269
readahead02    1  TPASS  :  offset is still at 0 as expected
readahead02    0  TINFO  :  read_testfile(0) took: 1644675 usec
readahead02    0  TINFO  :  read_testfile(1) took: 2239703 usec
readahead02    0  TINFO  :  read_testfile(0) read: 67072000 bytes
readahead02    0  TINFO  :  read_testfile(1) read: 31821824 bytes
readahead02    2  TPASS  :  readahead saved some I/O
readahead02    0  TINFO  :  cache can hold at least: 65824 kB
readahead02    0  TINFO  :  read_testfile(0) used cache: 65520 kB
readahead02    0  TINFO  :  read_testfile(1) used cache: 34420 kB
readahead02    3  TPASS  :  using cache as expected


Thank you.

Best regards
Naresh Kamboju

>
> Regards,
> Jan
