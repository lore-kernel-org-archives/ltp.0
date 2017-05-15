From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 15 May 2017 09:16:29 -0400 (EDT)
Subject: [LTP] [PATCH v2] [RFC] pselect01: Tune thresholds
In-Reply-To: <20170515131329.GA12586@rei.suse.de>
References: <20170512141658.26810-1-chrubis@suse.cz>
 <495691788.11461692.1494842630946.JavaMail.zimbra@redhat.com>
 <20170515123556.GA8280@rei.lan>
 <1832031935.11522951.1494853219630.JavaMail.zimbra@redhat.com>
 <20170515131329.GA12586@rei.suse.de>
Message-ID: <487209384.11529526.1494854189805.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > I guess that the 50us is included in the 250us already. So what about
> > > adding the line you sugests and decreasing the 250us to 200us?
> > 
> > We can do that, but looking again at  PR_GET_TIMERSLACK, it is supported
> > since 2.6.28, so we'd need to skip older kernels or fall back to a
> > default of 50us.
> 
> Let's sort that out after the release, I will commit v2 as it is, ok?

ACK

Regards,
Jan
