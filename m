From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 14 Aug 2017 11:55:30 +0200
Subject: [LTP] [RFC PATCH v7 11/11] network: Use tools to set up IPv4
 and IPv6 related variables
In-Reply-To: <022c99bb-86d0-494a-ec0b-a4a53dafaa72@oracle.com>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-12-pvorel@suse.cz>
 <2255e31f-0d8f-5aed-e288-6dde615d98a4@oracle.com>
 <20170727090331.olg3buhrhhs6h532@dell5510>
 <022c99bb-86d0-494a-ec0b-a4a53dafaa72@oracle.com>
Message-ID: <20170814095530.622kfa6vajissyzv@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,


> eval executes the output of tst_net_ip_prefix command there, not $(...),
> so basically it's the same as if we write:

> cmd="$(tst_net_ip_prefix)"

> On error $cmd is empty because you write to stderr, so eval returns 0.

> eval "$cmd"

> Or you could use '$(...)' instead of "$(...)", but in that case eval is
> kind of redundant.

Thanks for detailed explanation. We need eval (for export variables), so I'll use your
original version.


Kind regards,
Petr
