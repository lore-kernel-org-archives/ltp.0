From: Nixiaoming <nixiaoming@huawei.com>
Date: Thu, 27 Sep 2018 15:27:13 +0000
Subject: [LTP] [PATCH v2] syscalls/fanotify11: new test for report
	thread id
In-Reply-To: <CAOQ4uxih8-_P2dRgBJ77-tFcw2bMYVopOFr23n735eUaCc__1w@mail.gmail.com>
References: <20180927101028.61686-1-nixiaoming@huawei.com>
 <CAOQ4uxih8-_P2dRgBJ77-tFcw2bMYVopOFr23n735eUaCc__1w@mail.gmail.com>
Message-ID: <E490CD805F7529488761C40FD9D26EF12A7D2D1F@DGGEMM527-MBS.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 27, 2018 at 7:58 PM  Amir Goldstein <amir73il@gmail.com> wrote:
>On Thu, Sep 27, 2018 at 1:58 PM nixiaoming <nixiaoming@huawei.com> wrote:
>>
>> syscalls/fanotify11
>> test fanotify_init with FAN_EVENT_INFO_TID
>>         data->pid is ID(pid)  of the thread that caused the event
>> test fanotify_init without FAN_EVENT_INFO_TID
>>         data->pid is ID(tgid) of the process that caused the event
>>
>> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
>> ---
>
>Here below the --- you can write your patch cover letter that son't be
>in commit message.
>
>When posting to the list you need to explicitly say that this in
>not testing an upstream feature, only RFC.
>Comments are welcome but test should NOT be merged at this point.
>
Thank you for your guidance
I will fix as soon as possible

>>  runtest/syscalls                                |   1 +
>>  testcases/kernel/syscalls/fanotify/.gitignore   |   1 +
......
>> +#define FAN_EVENT_INFO_TID 0x02000000
>> +#ifdef FAN_EVENT_INFO_TID
>
>What is the purpose of this? define and then ifdef? leftover?
>Please define this in fanotify.h inside ifndef
>Please see my branch fanotify_unpriv as example.
>
>You need only runtime check for kernel support. 
very sorry....
Here I made a very low-level mistake..

>
>> +
>> +#define BUF_SIZE 256
>> +#define gettid() syscall(SYS_gettid)
>> +
>> +static char fname[BUF_SIZE];
>> +
>> +static int tid;
>> +static int tgid;
>> +
>> +void *thread_create_file(void *arg LTP_ATTRIBUTE_UNUSED)
>> +{
>> +       int fd;
>> +       char tid_file[64] = {0};
>> +       char buf[64];
>> +
>> +       tid = gettid();
>> +       snprintf(tid_file, sizeof(tid_file), "%s/test_tid_%d", fname, tid);
>> +       fd = SAFE_OPEN(tid_file, O_RDWR|O_CREAT, 0600);
>> +       tst_res(TINFO, "file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
>> +       SAFE_WRITE(1, fd, tid_file, sizeof(tid_file));
>> +       lseek(fd, 0, SEEK_SET);
>> +       SAFE_READ(0, fd, buf, sizeof(buf));
>> +       SAFE_CLOSE(fd);
>> +       SAFE_UNLINK(tid_file);
>> +       pthread_exit(0);
>
>A good test is a simple test - this is way too much IMO.
>You can replace everything with a single SAFE_FILE_PRINTF(tid_file, "1");
>
Thank you for your guidance
I have re-updated the use case and verified it locally.
I will send a new patch later.

thanks
