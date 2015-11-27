From: Li Wang <liwang@redhat.com>
Date: Fri, 27 Nov 2015 12:06:30 +0800
Subject: [LTP] [PATCH v2] hugetlb/hugemmap: add new testcase hugemmap06.c
In-Reply-To: <565749D5.4060306@oracle.com>
References: <1448506977-12479-1-git-send-email-liwang@redhat.com>
 <5656CF53.3030409@oracle.com>
 <CAEemH2fxCDRtB7jSazdBjAMzxaK0U2GwNZKLuAq00EDzbW679A@mail.gmail.com>
 <565749D5.4060306@oracle.com>
Message-ID: <CAEemH2ex70uchgYCMGy4hFEk0jpFzS=ofEerH30J_=n4gDVHfg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Fri, Nov 27, 2015 at 2:05 AM, Alexey Kodanev <alexey.kodanev@oracle.com>
wrote:

>
> Hi,
> On 11/26/2015 03:25 PM, Li Wang wrote:
> ...
> OK, but I meant that either we need to remove "sz" variable and use "i *
> hpage_size" or
> make it straightforward as "i" doesn't influence on the actual size passed
> to mmap and threads.
>
> So that both of the loops looks the same.
>
> Also to use the full range of declared arrays, we should do as follows or
> declare them as ARSZ - 1:
>
> struct mp mmap_sz[ARSZ];
> pthread_t tid[ARSZ];
>
> sz = ARSZ + 1;
>
> ...
>
> for (i = 0; i < ARSZ; ++i, --sz) {
>     mmap_sz[i].sz = sz;
>     mmap_sz[i].addr = addr;
>     ...
> }
>
> for (i = 0; i < ARSZ; ++i) {
>     pthread_join(...);
>
> }
>

looks like this form is better. thanks!


>
>> +               mmap_sz[i].sz = sz;
>>> +               mmap_sz[i].addr = addr;
>>> +
>>> +               TEST(pthread_create(tid + i, NULL, thr, &mmap_sz[i]));
>>>
>>
>> This is not right, use tid[i] ( = tid + sizeof(pthread_t) * i), not tid +
>> i.
>>
>
> sorry, probably you want say this:
>
>         (pthread_t *)((char *)tid + sizeof(pthread_t) * i)
>
> but I think the original way is right.
>
>
> Yes, you are right, sorry for misleading you.
>
> I would recommend to use the same style in one function, so
>
> TEST(pthread_create(tid + i, NULL, thr, mmap_sz + i));
> or
> TEST(pthread_create(&tid[i], NULL, thr, &mmap_sz[i]));
>

yeah, it is more neatly. agreed.


> ...
>
>     /* Call tst_flush() flush any output in the buffer. */
>     tst_flush();
>
>     /* Mask out TINFO result from the exit status. */
>     exit(T_exitval & ~TINFO);
> }
>
> I didn't saw there anyplace call the cleanup() function. :(
>
>
> Right, I've read the mail thread recently about changing cleanup() to be
> declared as a signal handler before
> and somehow thought it is already implemented in LTP...
>
> Thanks,
> Alexey
>
>
ok, let me post patch v3.

-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151127/a4dd7305/attachment.html>
