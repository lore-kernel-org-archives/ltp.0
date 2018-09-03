From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Sep 2018 16:54:32 +0200
Subject: [LTP] [PATCH 1/1] runltp: Remove RHOST setup
In-Reply-To: <20180903113015.GA21765@rei>
References: <20180903105017.31106-1-pvorel@suse.cz>
 <20180903113015.GA21765@rei>
Message-ID: <20180903145432.GA21745@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Hi!
> > To be honest, I'd prefer removing -N option from runltp or replace it
> > with info "Run network tests via network.sh script" (+ remove
> > scenario_groups/network).

> Hmm, that may be a good solution for the moment, but in the long term we
> may want to have a single tool to run all our tests
Understand. In that case I'll apply this patch as it unifies the behavior with
network.sh.


> > I'm looking forward the day this crazy script is replaced with something
> > more convenient.

> Yes indeed, but it seems that I will need another hackweek to make the
> proof of concept more usable...

Thanks a lot for your work. I'll help at least with the testing.


Kind regards,
Petr
