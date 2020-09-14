From: Cixi Geng <gengcixi@gmail.com>
Date: Mon, 14 Sep 2020 15:52:37 +0800
Subject: [LTP] LTP release
In-Reply-To: <CAEemH2eJCUuf=SQF_GdQ7U9q_8+BD9LsxPAgwuJS9wx8zBzNww@mail.gmail.com>
References: <20200908073138.GB2475@yuki.lan>
 <CAEemH2cHvM_KD7W6fyX6z3bc0qfVtkp=yEM8MDvvohouyj5N2w@mail.gmail.com>
 <20200908153659.GA16066@yuki.lan>
 <CAEemH2eq0fwF8zt1uez5vuwM0vtrLtoFd_45sFqE=iQ8hpudfQ@mail.gmail.com>
 <CAEemH2es3sMSfAar8Xj4_Vr+2nsD0isPws4v=8=csLyYROAQGQ@mail.gmail.com>
 <20200909131327.GA3241@yuki.lan> <20200909132703.GB3241@yuki.lan>
 <CAEemH2e+Ck8M22gdgL0OQ24ekBPyDu4FwGrdG+da9E62UZWjRQ@mail.gmail.com>
 <CAEemH2eJCUuf=SQF_GdQ7U9q_8+BD9LsxPAgwuJS9wx8zBzNww@mail.gmail.com>
Message-ID: <CAF12kFs+Wzm2rt5uE7WoHDXZSpdtZaZPgspKTACpYnw7zR+sgA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril:
Can we merge the uart device driver testcase and the device-discover framework ?
So that we can continue write other device driver case in LTP.
I am looking forward contribute to ltp on the driver test .

https://patchwork.ozlabs.org/project/ltp/list/?series=185240
https://patchwork.ozlabs.org/project/ltp/list/?series=195151

Li Wang <liwang@redhat.com> ?2020?9?10??? ??5:23???
>
>
>
> On Thu, Sep 10, 2020 at 3:19 PM Li Wang <liwang@redhat.com> wrote:
>>
>>
>>
>> On Wed, Sep 9, 2020 at 9:26 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>>>
>>> Hi!
>>> > Also I would like to get rid of the -fno-optimize-sibling-calls in the
>>> > Makefile, this makes the test a bit fragile and less portable.
>>
>>
>> I'm not very sure, let me think/check a while.
>
>
> From the document, it could also help prevents optimization purposes.
> I think we can have a try, if no more issues, that will be great.
>
>>
>>
>>>
>>> /*
>>>  * Returns negative number if stack grows down, possitive if stack grows up
>>>  */
>>> static int stack_dir(void)
>>> {
>>>         intptr_t addr = addr_func();
>>>
>>>         printf("%p %p\n", &addr, (void*)addr);
>>
>>
>> This method may be doable, but the second %p print (nil), I don't why.
>
>
> The reason seems that the local variable is revoked after the function
> is calling, so we get NULL of the local variable address. It works as we
> expected when introducing a global pointer to save and return the '&a'.
>
> --
> Regards,
> Li Wang
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
