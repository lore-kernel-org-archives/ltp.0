From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 May 2018 13:01:10 +0200
Subject: [LTP] [PATCH 2/2] network/route: Rewrite route-change-gw into
	new API
In-Reply-To: <cfa4f035-9052-147b-4d6d-2b6ecfe4cf31@oracle.com>
References: <20180517103527.23542-1-pvorel@suse.cz>
 <20180517103527.23542-2-pvorel@suse.cz>
 <cfa4f035-9052-147b-4d6d-2b6ecfe4cf31@oracle.com>
Message-ID: <20180518110110.zeabusjbiq2lq263@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 17.05.2018 13:35, Petr Vorel wrote:
> > Drop route command (use just ip command), simplify


> I think the commit message should be more descriptive about the
> changes being made...
Make sense, I'll do.

> don't remember why the rewritten test is
> not using background traffic and not changing gateway anymore?
The current implementation was based on your suggestion for route-change-dst [1] (I'll
mention that in commit message), which uses ns-udpsender.  The other patch [2] is
changing gateway.

Tests used ns-udpsender in previous implementation and we decided to keep it as  use
background traffic isn't sufficient enough [3].

But ns-udpsender isn't good enough, as it doesn't check whether destination receive it [4].
And indeed you can pass it to any destination and it will not fail, e.g.:
ns-udpsender -f 4 -D 1.2.3.4 -p 1 -o -s 1472

I guess we need to write another helper, which will listen for packets on remote side.
Any recommendations/ideas on it?


Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2017-August/005367.html
[2] https://lists.linux.it/pipermail/ltp/2018-May/008152.html
[3] http://lists.linux.it/pipermail/ltp/2017-July/005125.html
[4] http://lists.linux.it/pipermail/ltp/2017-August/005336.html
