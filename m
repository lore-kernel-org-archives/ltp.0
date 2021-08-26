From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 26 Aug 2021 10:02:33 +0800
Subject: [LTP] [PATCH 3/7] epoll_ctl: Add test for epoll_ctl03
In-Reply-To: <YSUSj8qaWPfMF1/w@yuki>
References: <20210817064924.127970-1-xieziyao@huawei.com>
 <20210817064924.127970-4-xieziyao@huawei.com> <YSUSj8qaWPfMF1/w@yuki>
Message-ID: <c4cfffb4-c58a-8f34-5254-fbfadcc68ab8@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Cyril,

>> +static void run_all(void)
>> +{
>> +	unsigned int index, events_bitmap;
>> +
>> +	for (index = 0; index < WIDTH_EPOLL_EVENTS; index++) {
>> +		events_bitmap = ((EPOLLIN * ((index & 0x01) >> 0)) |
>> +				(EPOLLOUT * ((index & 0x02) >> 1)) |
>> +				(EPOLLPRI * ((index & 0x04) >> 2)) |
>> +				(EPOLLERR * ((index & 0x08) >> 3)) |
>> +				(EPOLLHUP * ((index & 0x10) >> 4)) |
>> +				(EPOLLET * ((index & 0x20) >> 5)) |
>> +				(EPOLLONESHOT * ((index & 0x40) >> 6)) |
>> +				(EPOLLRDHUP * ((index & 0x80) >> 7)));
> 
> I guess that we can as well add a IS_BIT_SET() macro that would do:
> 
> #define IS_BIT_SET(val, bit) (((val) & (1<<(bit))) >> (bit))
Looks good, thanks. I've added this macro to include/tst_bitmap.h in the 
v2 patchset, other changes have also been applied.

Besides, I've used a different outlook email to submit and hope it 
doesn't cause misunderstandings.

> 
> And use that here instead.
> 
> Otherwise it looks good.
> 

Please see: https://patchwork.ozlabs.org/project/ltp/list/?series=259628

Thanks for your review.

-- 
Best Regards,
Xie Ziyao
E-mail:ziyaoxie@outlook.com
