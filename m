From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 11 Dec 2018 03:26:41 -0500 (EST)
Subject: [LTP] [PATCH v4] fzsync: limit sampling time
In-Reply-To: <87k1khmn8z.fsf@rpws.prws.suse.cz>
References: <8361c9b264ceb4c212319fcb366d85a854495ffe.1543912963.git.jstancek@redhat.com>
 <1713839002.84458666.1544449224828.JavaMail.zimbra@redhat.com>
 <87k1khmn8z.fsf@rpws.prws.suse.cz>
Message-ID: <611481988.85005143.1544516801404.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hell Jan,
> 
> Jan Stancek <jstancek@redhat.com> writes:
> 
> > ----- Original Message -----
> >> Fixes: #429
> >> 
> >> Sampling can take considerably longer time on single CPU
> >> and very slow systems. This patch limits sampling time to
> >> 1/2 of fuzzing runtime. If we don't have enough samples by
> >> that time, stop sampling and use stats we gathered so far.
> >
> > @Richard: Are you OK with v4 (with %% typo fixed)?
> 
> Yes, thanks.

Pushed.

Regards,
Jan
