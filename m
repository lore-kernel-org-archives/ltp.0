From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Jan 2021 18:03:37 +0800
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
In-Reply-To: <YBExXT8HzFAGsTNI@yuki.lan>
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>
 <CAEemH2csSFf7Ujz8H+KV7hTdmDVsxn5_oW2JZbwY=NsJUSat_w@mail.gmail.com>
 <2021012714540739834212@chinatelecom.cn>
 <CAEemH2dhpbm19HEaHkhv1WE+70VkDjM9C5L1-KJZqPX2G2BgrQ@mail.gmail.com>
 <CAEemH2cwEzLr0dXvskn-hprn0-iOCr=rrLPgDUE1YdbnHu=5AQ@mail.gmail.com>
 <YBExXT8HzFAGsTNI@yuki.lan>
Message-ID: <CAEemH2frpP09ZXJDB4n-4nDBYgaSCEEwe8Fe==dp92WF7ohU9w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jan 27, 2021 at 5:23 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > I sent to you the case swapping01 solving this(via FILE_LINES_SCANF)
> > > already, feel free to take an reference:
> > >
> > >
> https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/swapping/swapping01.c#L85
> > >
> >
> > Or, maybe we can extract this process into a function and put it in
> > tst_memutils.h, to convinently reuse by other testcases too?
> >
> > void tst_get_MemAvailable(void);
>
> Please do not use CamelCase.
>

+1
Sorry, I just pasted the name by the editor, and YES, we should avoid that.


> It should be tst_get_mem_available(void) and it should also return
> unsigned long.
>

Absolutely right.


liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn> wrote:

In this testcase,we first check MemAvailable. If MemAvailable doesn't
> exist,then use info.freeram.
> Maybe not other cases need do these.
>

Yes, but we also could make use of tst_get_mem_available() here because,
in the patch, you're trying to avoid that (MemFree > MemAvailable)
situation.
If the fix is correct, we just need to get both and choose the smaller one
to use, isn't it?



> Have a question about using macro SAFE_READ_MEMINFO get MemAvailable
>> value,
>> Some old kernels maybe not privode "MemAvailable" field, which will
>> broken.
>>
>
The most different of SAFE_* macro is that will exit with TBROK if not
get it expected. As Cyril proposes another one FILE_LINES_SCANF
has no such concern.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210127/22cc467d/attachment-0001.htm>
