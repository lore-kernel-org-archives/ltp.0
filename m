From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 13 Feb 2020 11:03:44 +0800
Subject: [LTP] [PATCH v3] aio02: Drop O_DIRECT flag for tmpfs
In-Reply-To: <1078491624.7198409.1581514672304.JavaMail.zimbra@redhat.com>
References: <5E43C9A1.8090807@cn.fujitsu.com>
 <1581502051-17240-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1078491624.7198409.1581514672304.JavaMail.zimbra@redhat.com>
Message-ID: <5E44BC90.1050908@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/2/12 21:37, Jan Stancek wrote:
>
> ----- Original Message -----
>> tmpfs doesn't support O_DIRECT flag, drop it. So user still can run aio02
>> with different filesystem by mounting specified filesystem on $TMPDIR.
>>
>> Also remove unused static value initialization.
>>
>> Reviewed-by: Xiao Yang<ice_yangxiao@163.com>
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   testcases/kernel/io/aio/aio02.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
> Acked-by: Jan Stancek<jstancek@redhat.com>
>
>
Hi all,

Thanks, I will push it with a minor change:
Keep original tc->flags and change cloned new_flags for tmpfs so that 
running aio02
in loops can report the 'Drop ...' hint for each changed subtest.  As below:
Without the change:
-----------------------------------------------------------------------------------
[root@Fedora-30 aio]# ./aio02 -i 2
tst_test.c:1215: INFO: Timeout per run is 0h 05m 00s
aio02.c:210: INFO: Drop O_DIRECT flag for tmpfs
aio02.c:218: PASS: WRITE: O_WRONLY | O_TRUNC | O_DIRECT | O_LARGEFILE | 
O_CREAT
aio02.c:210: INFO: Drop O_DIRECT flag for tmpfs
aio02.c:218: PASS: READ : O_RDONLY | O_DIRECT | O_LARGEFILE
aio02.c:218: PASS: WRITE: O_RDWR | O_TRUNC
aio02.c:218: PASS: READ : O_RDWR
aio02.c:218: PASS: WRITE: O_WRONLY | O_TRUNC
aio02.c:218: PASS: READ : O_RDONLY
aio02.c:218: PASS: WRITE: O_WRONLY | O_TRUNC | O_DIRECT | O_LARGEFILE | 
O_CREAT
aio02.c:218: PASS: READ : O_RDONLY | O_DIRECT | O_LARGEFILE
aio02.c:218: PASS: WRITE: O_RDWR | O_TRUNC
aio02.c:218: PASS: READ : O_RDWR
aio02.c:218: PASS: WRITE: O_WRONLY | O_TRUNC
aio02.c:218: PASS: READ : O_RDONLY
...
-----------------------------------------------------------------------------------
With the change:
-----------------------------------------------------------------------------------
[root@Fedora-30 aio]# ./aio02 -i 2
tst_test.c:1215: INFO: Timeout per run is 0h 05m 00s
aio02.c:212: INFO: Drop O_DIRECT flag for tmpfs
aio02.c:220: PASS: WRITE: O_WRONLY | O_TRUNC | O_DIRECT | O_LARGEFILE | 
O_CREAT
aio02.c:212: INFO: Drop O_DIRECT flag for tmpfs
aio02.c:220: PASS: READ : O_RDONLY | O_DIRECT | O_LARGEFILE
aio02.c:220: PASS: WRITE: O_RDWR | O_TRUNC
aio02.c:220: PASS: READ : O_RDWR
aio02.c:220: PASS: WRITE: O_WRONLY | O_TRUNC
aio02.c:220: PASS: READ : O_RDONLY
aio02.c:212: INFO: Drop O_DIRECT flag for tmpfs
aio02.c:220: PASS: WRITE: O_WRONLY | O_TRUNC | O_DIRECT | O_LARGEFILE | 
O_CREAT
aio02.c:212: INFO: Drop O_DIRECT flag for tmpfs
aio02.c:220: PASS: READ : O_RDONLY | O_DIRECT | O_LARGEFILE
aio02.c:220: PASS: WRITE: O_RDWR | O_TRUNC
aio02.c:220: PASS: READ : O_RDWR
aio02.c:220: PASS: WRITE: O_WRONLY | O_TRUNC
aio02.c:220: PASS: READ : O_RDONLY
...
-----------------------------------------------------------------------------------

Thanks,
Xiao Yang


