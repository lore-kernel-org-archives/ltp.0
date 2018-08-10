From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 10 Aug 2018 08:13:57 +0800
Subject: [LTP] [PATCH] syscalls/fsetxattr02.c: Fix the failure of
 opening device files
In-Reply-To: <20180809145723.5e6s3okx6rci2qdj@mobile.celeiro.br>
References: <1533744069-24715-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180809145723.5e6s3okx6rci2qdj@mobile.celeiro.br>
Message-ID: <5B6CD8C5.1040709@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/08/09 22:57, Rafael David Tinoco wrote:
>> --- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
>> +++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
>> @@ -52,11 +52,13 @@
>>   #define FILENAME "fsetxattr02testfile"
>>   #define DIRNAME  "fsetxattr02testdir"
>>   #define SYMLINK  "fsetxattr02symlink"
>> -#define FIFO     "fsetxattr02fifo"
>> -#define CHR      "fsetxattr02chr"
>> -#define BLK      "fsetxattr02blk"
>> +#define FIFO     "/dev/fsetxattr02fifo"
>> +#define CHR      "/dev/fsetxattr02chr"
>> +#define BLK      "/dev/fsetxattr02blk"
> Thanks for catching this!! Minor issue: This will break OFFSET logic for
> tst_res() messages. They are skipping 11 chars because all files started
> with "fsetxattr02".
Hi Rafael,

Sorry for this rough fix, and i will send v2 patch as you suggested.

Thanks,
Xiao Yang
> -Rafael
>
>
>



