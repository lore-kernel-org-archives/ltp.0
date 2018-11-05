From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 5 Nov 2018 10:05:02 -0500 (EST)
Subject: [LTP] [RFC PATCH 0/2] Cleanup runtests containing duplicate
 definitions
In-Reply-To: <CAEemH2fxHBmWmuj314ZdB+E2i2wXBtOg40SrSgt2Vxtqcns=0Q@mail.gmail.com>
References: <20181015201819.10868-1-pvorel@suse.cz>
 <20181105114301.GA3591@dell5510>
 <CAEemH2fxHBmWmuj314ZdB+E2i2wXBtOg40SrSgt2Vxtqcns=0Q@mail.gmail.com>
Message-ID: <863155656.69419841.1541430302026.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Jan, did we internal ltp-lite take reference from the ltplite file?

Probably only at the beginning, when original author of beaker test
forked ltplite runtest file. I've been using syscalls/other runtest
files, since those are more up to date.

> I wanna
> know how do we customize our internal ltp-lite testcases.

syscalls + cherry-picked tests from other runtest files.
We might be getting off-topic w.r.t this mailing list.

Regards,
Jan

> 
> -- Sending by my PH1 phone.
> 
> On Mon, Nov 5, 2018, 19:43 Petr Vorel <pvorel@suse.cz wrote:
> 
> > Hi,
> >
> > > anyone using these? Objections?
> > > IMHO there is no point trying to keep them sync.
> > It looks like no objection to this, so I'll remove it.
> >
> > Kind regards,
> > Petr
> >
> 
