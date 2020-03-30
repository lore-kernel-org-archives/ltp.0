From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Mar 2020 13:31:00 +0200
Subject: [LTP] [PATCH 1/6] lib: Implement .needs_cmds
In-Reply-To: <20200330070309.GA4571@dell5510>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <20200327213924.18816-2-pvorel@suse.cz>
 <CAEemH2c2Rq9x53fr2-KRaLpJ55xbuwVO96YWzJXAEdgcx2vvCQ@mail.gmail.com>
 <20200330070309.GA4571@dell5510>
Message-ID: <20200330113100.GC9845@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +2.2.35 Checking for required binaries
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> > Maybe better to talk commands but not binaries, since not all of the
> > commands are binary, there is possible python, perl or shell executable
> > file need check too. Isn't it?
> +1

Acked with this change.

-- 
Cyril Hrubis
chrubis@suse.cz
