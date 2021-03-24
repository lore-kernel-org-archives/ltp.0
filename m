From: liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn>
Date: Wed, 24 Mar 2021 17:26:59 +0800
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>, 
 <YBE03REJywKIlM0X@yuki.lan>, 
 <2021012718043566596022@chinatelecom.cn>, 
 <CAEemH2dA0T1F3wsdwtG2hsfDUUJsY8gFeTLTHyGz+pu034gH4g@mail.gmail.com>, 
 <202103051352110688245@chinatelecom.cn>, 
 <CAEemH2cW9djj3sN8j9Xj_A5iNB9DLhYYkK=nu8ypaOtiYMnLyw@mail.gmail.com>
Message-ID: <202103241726592002447@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li Wang,
I think your patch is good.
1.CommitLimit is the memory that can be allocated by application.
2.ioctl_sg01 in serveral machines with your patch,the result is passed.

Thanks!
    
From: Li Wang
Date: 2021-03-05 17:02
To: liuxp11@chinatelecom.cn
CC: Cyril Hrubis; ltp; mdoucha
Subject: Re: Re: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01 invoked oom-killer
Hi Xinpeng,

On Fri, Mar 5, 2021 at 1:52 PM liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn> wrote:
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -36,6 +36,13 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
        if (info.freeram - safety < maxsize / info.mem_unit)
                maxsize = (info.freeram - safety) * info.mem_unit;

 ==>Thanks,but the maxsize original code need to be deleted,Right?

No, the maxsize code is also useful, it needs to define the value in
most common situations(i.e. CommitLimit > MemAvailable).

But I'm still hesitating to use ComitLimit as the threshold for 'maxsize'.
Because according to the Linux document, it says that only take effort
when overcommit_memory is setting to 2. But our test system all set 0
by default.

   "This limit is only adhered to if strict overcommit accounting is enabled
    (mode 2 in 'vm.overcommit_memory')."
    see: https://github.com/torvalds/linux/blob/master/Documentation/filesystems/proc.rst

Seems to use CommitLimit looks a bit strict and strange to test.

And I even think the way to use MemAvailable is acceptable if
MemFree > MemAvailable, just like what you did in your last patch.

I'm still not very sure so far~
(But one thing I can confirm that MemAvailable < MemFree is correct behavior sometimes)

 

+       /*
+        * To respect CommitLimit to prevent test invoking OOM killer,
+        * this may appear on system with a smaller swap-disk (or disabled).
+        */
+       if (SAFE_READ_MEMINFO("CommitLimit:") < SAFE_READ_MEMINFO("MemAvailable:"))
+               maxsize = SAFE_READ_MEMINFO("CommitLimit:") * 1024 - (safety * info.mem_unit);
+
        blocksize = MIN(maxsize, blocksize);
        map_count = maxsize / blocksize;
        map_blocks = SAFE_MALLOC(map_count * sizeof(void *));
 

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210324/39164c88/attachment.htm>
