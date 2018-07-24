From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Jul 2018 10:52:34 +0200
Subject: [LTP] [RFC PATCH 1/1] pounder21: Remove
In-Reply-To: <20180724054937.GA25333@dell5510>
References: <20180723122911.10714-1-pvorel@suse.cz>
 <1784802899.35188200.1532349973680.JavaMail.zimbra@redhat.com>
 <CAEemH2ez26eEbpcuKx2nd7WhKeR2tEP6BSGkWpsEYmK733PB1g@mail.gmail.com>
 <20180724054937.GA25333@dell5510>
Message-ID: <20180724085234.GA8655@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I occasionally use the pounder suit as a stress test to run more than 24
> > hours.
> 
> > But I'm OK to remove it from the latest ltp because it has long time no
> > substantive updating and the version I used is always ltp-full-20150903.
> 
> Well, if anyone uses it, I would keep it. The reason why is not compiled by
> default is probably because being incompatible with our make system.  But it
> looks quite neglected as it downloads and builds 2.6.39 (the last 2.6.x
> release).

Well that may still be a reason to remove it, if nobody maintains the
code it will break sooner or later...

-- 
Cyril Hrubis
chrubis@suse.cz
