From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 07 Feb 2019 15:38:58 +0100
Subject: [LTP] [PATCH] ustat: Fix EFAULT in 32bit compatability mode
In-Reply-To: <20190207130746.GB20833@dell5510>
References: <20190202001727.13269-1-smuckle@google.com>
 <20190207101835.641-1-rpalethorpe@suse.com>
 <532035050.101837579.1549541815701.JavaMail.zimbra@redhat.com>
 <20190207130746.GB20833@dell5510>
Message-ID: <87k1ib8xz1.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Jan,
>
>> > From looking at glibc, this test may also be broken on mips, but I am not
>> > sure
>> > if that matters. AFAICT on all other platforms glibc always casts to uint
>> > after performing a sanity check..
>
>> LGTM, LTP is using only 0 (and -1 for errno tests), so it shouldn't matter.
> I'm sorry I missed your mail, so pushed without your ack.
>
>> What about ustat02? Are you planning on sending something similar for that test?
> It's not needed for ustat02. Is it because *tc[test].dev in ustat02 is
> pointer?

I don't think so, but AFAICT ustat02 is still valid because passing the
wrong data type still has the desired effect of creating an invalid
buffer pointer in the bad address test. On the invalid parameter test,
only the first 32bits of dev are checked before EINVAL is thrown, so
again, it doesn't matter.

So I won't send another patch, but I am not against adding the cast
either.

>
> Kind regards,
> Petr


--
Thank you,
Richard.
