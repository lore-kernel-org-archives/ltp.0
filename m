From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Sep 2018 19:31:21 +0200
Subject: [LTP] [PATCH 1/1] runltp: Remove RHOST setup
In-Reply-To: <20180903113015.GA21765@rei>
References: <20180903105017.31106-1-pvorel@suse.cz>
 <20180903113015.GA21765@rei>
Message-ID: <20180903173121.GA13332@dell5510>
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
Just to clarify: network tests are able to run by either runner (runltp or
network.sh). It's just the issue that runltp in inflexible for network tests.
It's because all network tests load tst_net.sh themselves.
So with the new runner, network tests will be able to be run by it anyway.

> > I'm looking forward the day this crazy script is replaced with something
> > more convenient.

> Yes indeed, but it seems that I will need another hackweek to make the
> proof of concept more usable...


Kind regards,
Petr
