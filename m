From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 31 Jul 2019 15:09:47 +0800
Subject: [LTP] [PATCH v6 3/3] syscalls/copy_file_range02: increase
 coverage and remove EXDEV test
In-Reply-To: <20190730132613.GA3614@dell5510>
References: <5D30200B.4050306@cn.fujitsu.com>
 <1564030915-3211-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1564030915-3211-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190730132613.GA3614@dell5510>
Message-ID: <5D413EBB.2010802@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> Hi,
>
> ...
>> diff --git a/include/lapi/fs.h b/include/lapi/fs.h
> ...
>> +/* Referred form linux kernel include/linux/fs.h */
>> +#ifdef TST_ABI64
>> + #define MAX_LFS_FILESIZE   ((loff_t)LLONG_MAX)
>> +#else
>> + #define MAX_LFS_FILESIZE   ((loff_t)ULONG_MAX<<  PAGE_SHIFT)
> Build fails on i386 on Debian stable [1] [2] due PAGE_SHIFT undeclared.
> I guess including<sys/user.h>  fixes it.
>
Hi Petr

  Thanks for you pointing out it.  I will include this header file.


> Kind regards,
> Petr
>
> [1] https://api.travis-ci.org/v3/job/565467338/log.txt
> [2] https://travis-ci.org/pevik/ltp/builds/565467337
>
>
> .
>



