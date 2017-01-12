From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 12 Jan 2017 04:07:09 -0500 (EST)
Subject: [LTP] [RFC] [PATCH] safe_macros: Add fallback pwrite() and
 pread() declarations
In-Reply-To: <20170112090232.GA16875@rei.lan>
References: <20170102154707.GA30109@rei.lan> <20170111144126.GA9518@rei.lan>
 <1178986959.1715131.1484209995886.JavaMail.zimbra@redhat.com>
 <20170112090232.GA16875@rei.lan>
Message-ID: <365395850.1733202.1484212029508.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 12 January, 2017 10:02:32 AM
> Subject: Re: [LTP] [RFC] [PATCH] safe_macros: Add fallback pwrite() and pread() declarations
> 
> Hi!
> > > I was thinking about this, and I think that we should rather go with a
> > > safer approach, i.e. moving the safe_pread/safe_pwrite into a separate
> > > header. Something as the following patch.
> > 
> > +1 for safer approach, I didn't know about glibc macros.
> > Does this affect oldlib too?
> 
> Not anymore, there was one user with zero offset which was converted to
> plain old SAFE_WRITE() and these two safe macros were then removed from
> oldlib safe macros in f4b028122.

Ah, I see. No objections to patch from my side.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
