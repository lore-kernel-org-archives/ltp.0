From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 15 May 2017 09:00:19 -0400 (EDT)
Subject: [LTP] [PATCH v2] [RFC] pselect01: Tune thresholds
In-Reply-To: <20170515123556.GA8280@rei.lan>
References: <20170512141658.26810-1-chrubis@suse.cz>
 <495691788.11461692.1494842630946.JavaMail.zimbra@redhat.com>
 <20170515123556.GA8280@rei.lan>
Message-ID: <1832031935.11522951.1494853219630.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > while looking at fs/select.c I noticed that it also takes
> > current->timer_slack_ns into account and uses that if
> > slack is smaller. Would it make sense to add ...?
> >   slack_per_scall = MAX(slack_per_scall, prctl(PR_GET_TIMERSLACK) / 1000);
> > The default is 50us, so maybe the 250us in formula covers this already?
> 
> I guess that the 50us is included in the 250us already. So what about
> adding the line you sugests and decreasing the 250us to 200us?

We can do that, but looking again at  PR_GET_TIMERSLACK, it is supported
since 2.6.28, so we'd need to skip older kernels or fall back to a
default of 50us.

Regards,
Jan
