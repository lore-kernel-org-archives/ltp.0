From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 2 May 2016 06:06:05 -0400 (EDT)
Subject: [LTP] LTP pre-release testing and freeze
In-Reply-To: <20160502094552.GB11884@rei.lan>
References: <20160420143031.GB4004@rei>
 <1728203866.1199576.1461839113790.JavaMail.zimbra@redhat.com>
 <20160428122625.GA25587@rei>
 <1274865023.2004095.1462180208523.JavaMail.zimbra@redhat.com>
 <20160502094552.GB11884@rei.lan>
Message-ID: <662877346.2024597.1462183565734.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 2 May, 2016 11:45:52 AM
> Subject: Re: [LTP] LTP pre-release testing and freeze
> 
> Hi!
> > > It seems that mapping PER_LINUX32 to PER_LINUX is a common practice on
> > > 64 bit, maybe we should just skip that personality on anything than
> > > x86_64.
> > 
> > Agreed. I can send a patch.
> 
> That would be just one ifdef, you can push that directly to the git
> repo.

Tested (on s390) and pushed.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
