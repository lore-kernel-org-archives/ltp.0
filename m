From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 6 May 2021 15:49:54 +0800
Subject: [LTP] [PATCH 2/3 v2] syscalls/chown: Rewrite chown/chown04.c
 with the new api
In-Reply-To: <YJAFz/tdPN6GWCWl@yuki>
References: <20210430094513.162499-1-xieziyao@huawei.com>
 <20210430094513.162499-3-xieziyao@huawei.com> <YJAFz/tdPN6GWCWl@yuki>
Message-ID: <e6bc2969-eab8-a333-49a6-f2577ff75444@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Cyril,

I just re-checked the latest code and submit the v3 version based on 
your suggestions.

Please see: 
https://patchwork.ozlabs.org/project/ltp/patch/20210506074621.167505-1-xieziyao@huawei.com/

Thanks very much!

Kind Regards,
Ziyao

On 2021/5/3 22:16, Cyril Hrubis wrote:
> Hi!
>> 2. Add MAP_PRIVATE_EXCEPT_UCLINUX to SAFE_MMAP() for uClinux systems:
>>     mmap() doesn't support MAP_PRIVATE on uClinux systems, so use
>>     MAP_PRIVATE_EXCEPT_UCLINUX instead, which will skip the option on uClinux.
>>     If MAP_PRIVATE really is required, the test can not be run on uClinux.
> 
> We no longer support uClinux, just remove the support from the test as
> well.
> 
