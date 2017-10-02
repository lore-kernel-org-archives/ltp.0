From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 2 Oct 2017 17:36:16 +0200
Subject: [LTP] [PATCH 1/1] syscalls, lib: Use SAFE_{BIND, LISTEN,
 SOCKET} macros
In-Reply-To: <20171002152109.GA3736@rei>
References: <20170929231036.32262-1-pvorel@suse.cz>
 <87bmlpx195.fsf@our.domain.is.not.set>
 <20171002122920.rpurivi6x46duh4c@dell5510>
 <878tgtwqk7.fsf@our.domain.is.not.set>
 <20171002150417.jodtfynklflxe5pl@dell5510>
 <20171002152109.GA3736@rei>
Message-ID: <20171002153616.k6fkz7fpzh2shzdc@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > > > 	... when != x & TFAIL

> > > What does the last line do? I am guessing it prevents the substitution
> > > if it finds TFAIL anywhere in the above expression.
> > Precisely :-).

> Shouldn't that be when != e & TFAIL? As far as I can tell the x is not
> used in the matching part, or did I miss something?
Sure, you're right, Cyril. Now I got your question Richard.
I'm surprised that it work with x (result is the same).


Kind regards,
Petr
