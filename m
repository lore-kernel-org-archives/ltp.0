From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 12 Dec 2018 15:14:51 +0800
Subject: [LTP] [PATCH 2/2] lib/tst_test.c: Restrict that tst_brk() only
 works with TBROK/TCONF
In-Reply-To: <20181211151733.GC1180@rei>
References: <1541681733-18845-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1541681733-18845-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <60497535.71361444.1541699583188.JavaMail.zimbra@redhat.com>
 <5BE4F51E.3060900@cn.fujitsu.com>
 <1919219905.71573908.1541750091092.JavaMail.zimbra@redhat.com>
 <5BE542AD.4060207@cn.fujitsu.com>
 <1931132489.71956282.1541785920854.JavaMail.zimbra@redhat.com>
 <5BE8E59B.2020703@cn.fujitsu.com> <20181211151733.GC1180@rei>
Message-ID: <5C10B56B.9030809@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/12/11 23:17, Cyril Hrubis wrote:
> Hi!
>> You are right, and i will send a v3 patch as you suggested.
> Are you going to send v3?
>
> I think that we really should increase counters on tst_brk(), that was
> an oversight when I designed the library.
>
> However summing up TBROK and TFAIL under results->failed does not look
> right to me.
Hi Cyril,

Yes, I am going to send v3.
I will pass TBROK to results->broken and  TFAIL to results->failed in my 
v3 patch.
> Also I'm not sure if we want to convert TFAIL to TWARN inside of test
> cleanup. And even if we wanted that change it should most likely go in
> in a separate patch.
Why do we need to convert TBROK to TWARN in test cleanup?  Your fix 
patch(commit 6440c5d)
has avoided the Infinite loop in test cleanup, so can we just keep the 
actual result by removing
the existed conversion?

Best Regards,
Xiao Yang


