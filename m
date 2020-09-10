From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Sep 2020 15:19:19 +0800
Subject: [LTP] LTP release
In-Reply-To: <20200909132703.GB3241@yuki.lan>
References: <20200908073138.GB2475@yuki.lan>
 <CAEemH2cHvM_KD7W6fyX6z3bc0qfVtkp=yEM8MDvvohouyj5N2w@mail.gmail.com>
 <20200908153659.GA16066@yuki.lan>
 <CAEemH2eq0fwF8zt1uez5vuwM0vtrLtoFd_45sFqE=iQ8hpudfQ@mail.gmail.com>
 <CAEemH2es3sMSfAar8Xj4_Vr+2nsD0isPws4v=8=csLyYROAQGQ@mail.gmail.com>
 <20200909131327.GA3241@yuki.lan> <20200909132703.GB3241@yuki.lan>
Message-ID: <CAEemH2e+Ck8M22gdgL0OQ24ekBPyDu4FwGrdG+da9E62UZWjRQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 9, 2020 at 9:26 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Also I would like to get rid of the -fno-optimize-sibling-calls in the
> > Makefile, this makes the test a bit fragile and less portable.
>

I'm not very sure, let me think/check a while.


> /*
>  * Returns negative number if stack grows down, possitive if stack grows up
>  */
> static int stack_dir(void)
> {
>         intptr_t addr = addr_func();
>
>         printf("%p %p\n", &addr, (void*)addr);
>

This method may be doable, but the second %p print (nil), I don't why.

# ./test
0x3ffe70feb48 (nil)
418387128
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200910/9cc9af0d/attachment.htm>
