From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 18 Oct 2019 10:02:13 +0200
Subject: [LTP] [PATCH] timer_getoverrun/2-3: increase tolerance for
 overshoot
In-Reply-To: <908344166.6934710.1571385536128.JavaMail.zimbra@redhat.com>
References: <77c71c80-0ca2-6f67-d628-d337a13539d7@jv-coder.de>
 <81c89bbde27ede0ef4291df60186bdcd293a3db5.1571219422.git.jstancek@redhat.com>
 <20191017125442.GB31415@rei.lan>
 <908344166.6934710.1571385536128.JavaMail.zimbra@redhat.com>
Message-ID: <a14f1623-7552-793b-c5e6-7ef48c53a983@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Am 18.10.2019 um 09:58 schrieb Jan Stancek:
> ----- Original Message -----
>> Hi!
>> I wonder if we can measure the sleep with monotonic clock, then we can
>> be more precise, since we would know how much we overshoot. But it's
>> probably not worth of complicating the code.
>>
>> Either way I'm fine with this version as well, acked.
> I pushed current patch. If we find it's still causing issues
> I'll look into the idea with monotonic clock.
>
Thanks for fixing this. I'd like to mention, that CLOCK_MONOTONIC is an
optionalfeature in posix. I do not know if there are systems missing it,
that might run these test.

J?rg

