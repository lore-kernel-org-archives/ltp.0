From: Li Wang <liwang@redhat.com>
Date: Mon, 1 Aug 2016 15:36:31 +0800
Subject: [LTP] [PATCH] swapping: replace mem_free by mem_available
In-Reply-To: <1136451928.10175289.1470035714396.JavaMail.zimbra@redhat.com>
References: <1469000896-6122-1-git-send-email-liwang@redhat.com>
 <1594266875.9316113.1469705306083.JavaMail.zimbra@redhat.com>
 <20160801064319.GA20856@gmail.com>
 <1136451928.10175289.1470035714396.JavaMail.zimbra@redhat.com>
Message-ID: <20160801073631.GB20856@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 01, 2016 at 03:15:14AM -0400, Jan Stancek wrote:
> 
> ----- Original Message -----
> > 
> > How much should the X defined?
> 
> I'd say at least 10 as with original testcase.
> 
> > 
> > >   i++;
> > >   swapped = read_meminfo("SwapFree:");
> > >   sleep(1);
> > >   if (abs(swapped - read_meminfo("SwapFree:")) < 512)
> > 
> > Why set the limitation as 512?  why not 1024 or others?
> 
> I picked that by rule of thumb, the value should be smaller
> than what any system can write to swap within 1s. But if we
> go too low then some noise from background processes could be
> falsely recognized as swap usage.

Ok, thanks for the explanaiton. Patch V2 is coming.

Regards,
Li Wang
