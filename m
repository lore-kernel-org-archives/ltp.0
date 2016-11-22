From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 22 Nov 2016 05:47:39 -0500 (EST)
Subject: [LTP] new shell library
In-Reply-To: <20161122080252.GD5620@rei.lan>
References: <20161003145835.GD7583@rei.suse.cz>
 <1527497475.514457.1476284084454.JavaMail.zimbra@redhat.com>
 <20161027145806.GA25043@rei.lan>
 <827120068.2432301.1477908222614.JavaMail.zimbra@redhat.com>
 <20161114131216.GB25055@rei.lan> <20161122065033.GA5620@rei.lan>
 <1438742745.1396390.1479801272456.JavaMail.zimbra@redhat.com>
 <20161122080252.GD5620@rei.lan>
Message-ID: <118984060.1453340.1479811659429.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 22 November, 2016 9:02:52 AM
> Subject: Re: [LTP] new shell library
> 
> Hi!
> > > I did a few runs of that ltp git repo on SLES and Debian and caught a
> > > few typos and problems. Anything else I should do before we merge it
> > > into main LTP git?
> > 
> > If you can wait a bit with merge, I'll run commands runtest on few RHEL
> > distros (from ancient to current) to double check.
> 
> Sounds good.

Looks good. Only thing that failed was 'file' test on older distros,
because output of 'file' is slightly different for certain file types.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
