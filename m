From: xieziyao <xieziyao@huawei.com>
Date: Tue, 20 Apr 2021 07:36:25 +0000
Subject: [LTP] [PATCH 2/2] syscalls/unshare: convert unshare02 to the
 new API
In-Reply-To: <YH2OrwsqdO231sNB@yuki>
References: <20210419122246.7706-1-xieziyao@huawei.com>
 <20210419122246.7706-3-xieziyao@huawei.com> <YH2OrwsqdO231sNB@yuki>
Message-ID: <96d27b37fa9245978e69679822916089@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I just re-checked the latest code and made changes on your suggestions:
1. Add setup() and cleanup() to set uid to "nobody" for EPERM tests;
2. Modify the incorrect code style.

Please see: https://patchwork.ozlabs.org/project/ltp/patch/20210420072939.202584-1-xieziyao@huawei.com/

Thanks so much for your review!

Best Regards,
Ziyao

-----Original Message-----
From: Cyril Hrubis [mailto:chrubis@suse.cz] 
Sent: Monday, April 19, 2021 10:08 PM
To: xieziyao <xieziyao@huawei.com>
Cc: ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 2/2] syscalls/unshare: convert unshare02 to the new API

Hi!
> 1. Convert unshare02 to the new API;
> 2. Check whether the returned value is correct in the child process 
> instead of the parent process; 3. Add a test case: use the CLONE_NEWNS 
> parameter as a non-root user and the expected return value is EPERM.

The EPERM check fails if the test is executed by a root. LTP tests usually setuid() to "nobody" for EPERM tests if executed as a root.

The TC should be lowercase but that is very minor.

Apart from these it's a really good cleanup.

--
Cyril Hrubis
chrubis@suse.cz
