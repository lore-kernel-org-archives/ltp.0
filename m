From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 3 Sep 2018 13:30:15 +0200
Subject: [LTP] [PATCH 1/1] runltp: Remove RHOST setup
In-Reply-To: <20180903105017.31106-1-pvorel@suse.cz>
References: <20180903105017.31106-1-pvorel@suse.cz>
Message-ID: <20180903113015.GA21765@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> To be honest, I'd prefer removing -N option from runltp or replace it
> with info "Run network tests via network.sh script" (+ remove
> scenario_groups/network).

Hmm, that may be a good solution for the moment, but in the long term we
may want to have a single tool to run all our tests

> I'm looking forward the day this crazy script is replaced with something
> more convenient.

Yes indeed, but it seems that I will need another hackweek to make the
proof of concept more usable...

-- 
Cyril Hrubis
chrubis@suse.cz
