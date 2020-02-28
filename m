From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 28 Feb 2020 17:41:22 +0800
Subject: [LTP] [PATCH v3 1/2] syscalls/fcntl30: clean up && add more
 range test
In-Reply-To: <1d62bf3e-3f34-fd05-8662-08ff16523673@cn.fujitsu.com>
References: <20200127162016.GD30831@rei.lan>
 <1580969073-27367-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200221160351.GA26393@rei.lan>
 <8d1a7c73-7122-2c3d-6a73-024bed066966@cn.fujitsu.com>
 <20200224142034.GA2210@rei>
 <1d62bf3e-3f34-fd05-8662-08ff16523673@cn.fujitsu.com>
Message-ID: <9e73a02e-7169-7229-8bc0-2ac84129bf31@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

> Hi
> 
>> Hi!
>>>> I was playing with the test and it seems that the kernel allocation may
>>>> fail even for much smaller sizes for various reasons. I guess that
>>>> memory framentation on long running systems may be the culprit here
>>>> because kmalloc() allocates physically continuous memory.
>>>>
>>>> I guess that the safest bet here would be limiting the maximal size we
>>>> try to resize the pipe and succeed to something as 8MB which would be
>>>> something as 32 pages to allocate.
>>>>
>>> Agree.
>>>> At the same time I would just define the size we expect to fail with
>>>> ENOMEM to 1<<30 and that would save us from this architecture specific
>>>> trickery that will probably fail on stranger architectures anyway.
>>> On 64kb page size, it will over 1 <<30 for ENOMEM error .I think we can
>>> test MAX_SIZE+pg_size(< 1<<31) for ENOMEM error. If? beyond 1<<31,
>>> expect EINVAL error.
>>
>> Hmm, maybe we can just double the size in a loop until we hit either
>> ENOMEM or EINVAL then and fail the test if we hit them too soon.
> I plan to remove this max test because of unknown kmalloc fail, test 
> range as below
> 
>  ??????? {0, 0, 0, 1, "set a value of below page size"},
>  ??????? {0, 0, 0, 1, "set a normal value"},???????????? //under 
> non-privileged user,maybe 128k (<1024k )
>  ??????? {0, 0, 1, 1, "set a value of below page size"},
>  ??????? {0, 0, 1, 1, "set a normal value"},??? // test 8M as you 
> suggested,
>  ??????? {0, 0, 1, 0, "set a value beyond max"},? //expect EINVAL or ENOMEM
> };
> 
> What do you think about it?
Ping.
diff as below:
diff --git a/testcases/kernel/syscalls/fcntl/fcntl30.c 
b/testcases/kernel/syscalls/fcntl/fcntl30.c
index 860d42e8d..28cdee165 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl30.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl30.c
@@ -31,8 +31,7 @@ static struct tcase {
         {0, 0, 0, 1, "set a value of below page size"},
         {0, 0, 0, 1, "set a normal value"},
         {0, 0, 1, 1, "set a value of below page size"},
-       {0, 0, 1, 1, "set a normal value"},
-       {0, 0, 1, 1, "set a max value"},
+       {0, 0, 1, 1, "set a normal value(8M)"},
         {0, 0, 1, 0, "set a value beyond max"},
  };

@@ -145,13 +144,10 @@ static void setup(void)
         tcases[2].setsize = (1 << pg_shift) - 1;
         tcases[2].expsize = 1 << pg_shift;

-       tcases[3].setsize = 2 << pg_shift;
-       tcases[3].expsize = 2 << pg_shift;
+       tcases[3].setsize = 1 << 23;
+       tcases[3].expsize = 1 << 23;

-       tcases[4].setsize = 1 << shift;
-       tcases[4].expsize = 1 << shift;
-
-       tcases[5].setsize = (1 << shift) + 1;
+       tcases[4].setsize = (1 << shift) + 1;

         pw = SAFE_GETPWNAM("nobody");
  }

Best Regards
Yang Xu
> 
> Best Regards
> Yang Xu
>>
> 
> 
> 


