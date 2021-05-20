From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 20 May 2021 19:10:57 +0800
Subject: [LTP] [PATCH 2/2] syscalls/sendfile: Convert sendfile09 to the
 new API
In-Reply-To: <YKTcWhMGotujEYLK@yuki>
References: <20210519084655.52780-1-xieziyao@huawei.com>
 <20210519084655.52780-3-xieziyao@huawei.com> <YKTcWhMGotujEYLK@yuki>
Message-ID: <e17ffbb2-2c2a-bd15-9e8c-cd2795e566cd@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

>> + * Testcase copied from sendfile02.c to test the basic functionality of
>> + * the sendfile(2) system call on large file. There is a kernel bug which
>> + * introduced by commit 8f9c0119d7ba and fixed by commit 5d73320a96fcc.
>                              ^
> 	Here as well the commit that introduced the bug should go to
> 	.tags.
Changed for sendfile{08, 09}, thanks a lot.

>> + * [Restrictions]
> 
> So far we had only [Description] and [Algorithm] but adding
> [Restrictions] sounds reasonable.
> 
>>    *
>> - * RESTRICTIONS
>> - *        Only supports 64bit systems and kernel 2.6.33 or above
>> + * Only supports 64bit systems and kernel 2.6.33 or above.
> 
> I guess that there is no point in mentioning the kernel version here, we
> have it in the tst_test structure and it's exported from that structure
> into the metadata as well.Changed and moved [Restrictions] to [Description].

>> +#ifdef TST_ABI32
>> +tst_brkm(TCONF, "This test is only for 64bit");
>> +#endif
> 
> Does this even compile on 32bit?
> 
> HINT: You can compile LTP for 32bit with ./configure CFLAGS=-m32 LDFLAGS=-m32
Sorry about this mistake and I fixed it with modifications above in the 
v2 version.

Please see: https://patchwork.ozlabs.org/project/ltp/list/?series=244863

Thanks for your review, Cyril.

Kind Regards,
Ziyao
