From: Li Wang <liwang@redhat.com>
Date: Mon, 14 Sep 2020 11:40:40 +0800
Subject: [LTP] [PATCH v5] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <CAEemH2cXY+-Dgq8PB-ZunzRnjM1iH0KiB5gK5=CLnFDSEiKLdQ@mail.gmail.com>
References: <20200911035533.30538-1-liwang@redhat.com>
 <20200911130836.GA2582@yuki.lan>
 <CAEemH2fPRTh6drs=h=U7OG07SZDgpDfEB0xRadF8Y1FbaHR8Nw@mail.gmail.com>
 <20200911145730.GA6157@yuki.lan>
 <CAEemH2cXY+-Dgq8PB-ZunzRnjM1iH0KiB5gK5=CLnFDSEiKLdQ@mail.gmail.com>
Message-ID: <CAEemH2foCpQqDdBNZ8A5OcpoKzLTUn1Od+KE8TSMN=vk-F5=kA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Sep 14, 2020 at 11:06 AM Li Wang <liwang@redhat.com> wrote:

>
> ...
>
>
>> But still the code wasn't exactly right, because the lowest address of
>> the stack in the previous code was stack - stack_size, which would be
>> start of the unmapped region and the size of the stack would be 2 *
>> stack_size, as we expected the mapping to grow.
>>
>
> No, I don't think so, the lowest address of the stack in the previous code
> is:
>     stack = start + total_size - size;
> and we pass this stack pointer to ptrehad_attr_setstack() is correct here,
> indeed the stack really starts at stack + stack_size, that's internal
> steps.
>

Here print debug info to verify that stack grows down from 'stack + size'
address:

mmap18.c:99: INFO: start = 0x7f4831293000, stack - size = 0x7f4831393000,
stack = 0x7f48313b3000, stack + size = 0x7f48313d3000
mmap18.c:110: INFO: &limit = 0x7f48313d1ee8, limit = 0x7f4831397000
mmap18.c:110: INFO: &limit = 0x7f48313d1ec8, limit = 0x7f4831397000
mmap18.c:110: INFO: &limit = 0x7f48313d1ea8, limit = 0x7f4831397000
mmap18.c:110: INFO: &limit = 0x7f48313d1e88, limit = 0x7f4831397000
mmap18.c:110: INFO: &limit = 0x7f48313d1e68, limit = 0x7f4831397000
mmap18.c:110: INFO: &limit = 0x7f48313d1e48, limit = 0x7f4831397000
mmap18.c:110: INFO: &limit = 0x7f48313d1e28, limit = 0x7f4831397000
mmap18.c:110: INFO: &limit = 0x7f48313d1e08, limit = 0x7f4831397000
mmap18.c:110: INFO: &limit = 0x7f48313d1de8, limit = 0x7f4831397000
...

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200914/2a1cc6d4/attachment.htm>
