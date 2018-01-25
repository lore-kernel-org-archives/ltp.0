From: Li Wang <liwang@redhat.com>
Date: Thu, 25 Jan 2018 15:51:15 +0800
Subject: [LTP] [RFC] [PATCH] lib/tst_test: Use CLOCK_MONOTONIC for -I
	option.
In-Reply-To: <5A698034.6060909@cn.fujitsu.com>
References: <20180122141931.12464-1-chrubis@suse.cz>
 <CAEemH2fR0Q3as6YJBkQK3VZ0_sdc0Rubqk0of+n0NTf8PtocwA@mail.gmail.com>
 <5A698034.6060909@cn.fujitsu.com>
Message-ID: <CAEemH2fHLz+N1L=v3ioyhPwmi8ArKRaZ8tacbwrM6seUnGgNug@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, Jan 25, 2018 at 2:59 PM, Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> On 2018/01/25 13:50, Li Wang wrote:
>
>
>
> On Mon, Jan 22, 2018 at 10:19 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
>
>> ​...
>>
>> -       return tv.tv_sec * 1000 + tv.tv_usec / 1000;
>> +       return tst_timespec_to_ms(ts);
>>
>
>
> ​Both patches(include the old-lib one) looks good.
>
> I just have a small question about function tst_timespec_to_ms(), why the
> t.tv_nsec plus 500000 when convert to msec?
>
> Hi Li,
>
> It seems to round up/down the decimal produced by converting nesc to msec.
> If the decimal is greater than 0.5,  round up it. If not, round down it.
>
>
​Ah, yes. Thanks so much!​



-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180125/b399ad79/attachment.html>
