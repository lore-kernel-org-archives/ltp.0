From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 5 Apr 2019 15:32:13 +0800
Subject: [LTP] [PATCH 1/2] m4: Use common LTP_CHECK_LIBC_FUNCS to check
 libc implementations
In-Reply-To: <20190405071324.GA30802@dell5510>
References: <1553765807-31789-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190328151228.GA6002@x230> <20190404103131.GB20565@rei.lan>
 <20190404115851.GA20924@dell5510> <5CA6C840.9010707@cn.fujitsu.com>
 <20190405071324.GA30802@dell5510>
Message-ID: <5CA7047D.2080606@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/04/05 15:13, Petr Vorel wrote:
> Hi Xiao, Cyril,
>
>> Thanks for your comment.
>> I will send v2 patch as you suggested. :-)
> v2 has LTP_CHECK_LIBC_FUNCS in m4/ltp-libc-funcs.m4.
> IMHO it'd be better to have simple AC_CHECK_FUNCS() in configure.ac, i.e. the
> same way we handle AC_CHECK_HEADERS(). It might not be good to mix configure.ac
> and m4/ltp-*.m4, but I guess general functions like this is easier to find in
> configure.ac than in some of m4/ltp-*.m4.
Hi Petr,

Sorry, I missed your last comment.
It seems easier to remove LTP_CHECK_LIBC_FUNCS directly.

I will send v3 patch soon.

Best Regards,
Xiao Yang
>
> Kind regards,
> Petr
>
>> Best Regards,
>> Xiao Yang
>> On 2019/04/04 19:58, Petr Vorel wrote:
>>> Hi,
>>>>> Note about formatting: maybe it'd be easier to edit the file if each function
>>>>> was on separate line.
>>>> Agreed, also we have AC_CHECK_FUNCS() in the configure.ac so the best
>>>> step would be moving these there as well.
>>> +1 (easier to find general things like this in configure.ac than in m4/ltp-*.m4.
>>>> Other than that this is a great cleanup, thanks for doing this.
>>> Kind regards,
>>> Petr
>
>
>
>
>
>
>
>



