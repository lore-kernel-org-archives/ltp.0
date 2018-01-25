From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 25 Jan 2018 14:59:00 +0800
Subject: [LTP] [RFC] [PATCH] lib/tst_test: Use CLOCK_MONOTONIC for -I
 option.
In-Reply-To: <CAEemH2fR0Q3as6YJBkQK3VZ0_sdc0Rubqk0of+n0NTf8PtocwA@mail.gmail.com>
References: <20180122141931.12464-1-chrubis@suse.cz>
 <CAEemH2fR0Q3as6YJBkQK3VZ0_sdc0Rubqk0of+n0NTf8PtocwA@mail.gmail.com>
Message-ID: <5A698034.6060909@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 2018/01/25 13:50, Li Wang wrote:
>
>
> On Mon, Jan 22, 2018 at 10:19 PM, Cyril Hrubis <chrubis@suse.cz 
> <mailto:chrubis@suse.cz>> wrote:
>
>     ​...
>
>     -       return tv.tv_sec * 1000 + tv.tv_usec / 1000;
>     +       return tst_timespec_to_ms(ts);
>
>
>
> ​Both patches(include the old-lib one) looks good.
>
> I just have a small question about function tst_timespec_to_ms(), why 
> the t.tv_nsec plus 500000 when convert to msec?
Hi Li,

It seems to round up/down the decimal produced by converting nesc to msec.
If the decimal is greater than 0.5,  round up it. If not, round down it.

Thanks,
Xiao Yang

>
> static inline long long tst_timespec_to_ms(struct timespec t)
> {
>     return t.tv_sec * 1000 + (t.tv_nsec + 500000) / 1000000;
> }
> ​
>
>
> -- 
> Li Wang
> liwang@redhat.com <mailto:liwang@redhat.com>
>
>
>



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180125/f9723f6c/attachment.html>
