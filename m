From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 7 Feb 2019 14:07:46 +0100
Subject: [LTP] [PATCH] ustat: Fix EFAULT in 32bit compatability mode
In-Reply-To: <532035050.101837579.1549541815701.JavaMail.zimbra@redhat.com>
References: <20190202001727.13269-1-smuckle@google.com>
 <20190207101835.641-1-rpalethorpe@suse.com>
 <532035050.101837579.1549541815701.JavaMail.zimbra@redhat.com>
Message-ID: <20190207130746.GB20833@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> > From looking at glibc, this test may also be broken on mips, but I am not
> > sure
> > if that matters. AFAICT on all other platforms glibc always casts to uint
> > after performing a sanity check..

> LGTM, LTP is using only 0 (and -1 for errno tests), so it shouldn't matter.
I'm sorry I missed your mail, so pushed without your ack.

> What about ustat02? Are you planning on sending something similar for that test?
It's not needed for ustat02. Is it because *tc[test].dev in ustat02 is pointer?

Kind regards,
Petr
