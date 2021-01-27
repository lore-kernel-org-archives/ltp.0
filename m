From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jan 2021 10:24:45 +0100
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
In-Reply-To: <CAEemH2cwEzLr0dXvskn-hprn0-iOCr=rrLPgDUE1YdbnHu=5AQ@mail.gmail.com>
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>
 <CAEemH2csSFf7Ujz8H+KV7hTdmDVsxn5_oW2JZbwY=NsJUSat_w@mail.gmail.com>
 <2021012714540739834212@chinatelecom.cn>
 <CAEemH2dhpbm19HEaHkhv1WE+70VkDjM9C5L1-KJZqPX2G2BgrQ@mail.gmail.com>
 <CAEemH2cwEzLr0dXvskn-hprn0-iOCr=rrLPgDUE1YdbnHu=5AQ@mail.gmail.com>
Message-ID: <YBExXT8HzFAGsTNI@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I sent to you the case swapping01 solving this(via FILE_LINES_SCANF)
> > already, feel free to take an reference:
> >
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/swapping/swapping01.c#L85
> >
> 
> Or, maybe we can extract this process into a function and put it in
> tst_memutils.h, to convinently reuse by other testcases too?
> 
> void tst_get_MemAvailable(void);

Please do not use CamelCase.

It should be tst_get_mem_available(void) and it should also return
unsigned long.

-- 
Cyril Hrubis
chrubis@suse.cz
