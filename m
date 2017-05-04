From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 4 May 2017 21:25:41 +0200
Subject: [LTP] [RFC PATCH v5 0/3] Simplify network setup
In-Reply-To: <7643d4a3-2aa5-7713-a634-4344f0d64233@oracle.com>
References: <20170503160751.1634-1-pvorel@suse.cz>
 <8a43347a-716f-7ce6-2758-e5eda838e265@oracle.com>
 <20170504134613.tyinrlvw4iagn2lh@dell5510>
 <7643d4a3-2aa5-7713-a634-4344f0d64233@oracle.com>
Message-ID: <20170504192541.d27ovqyzyz2pdkvu@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > Right, I'll remove requirement network prefix to be < 8 (IPv4) resp. 16 (IPv6).
> > There are other restrictions you probably don't like:
> > * Don't use 32 (IPv4) and 128 (IPv6): I'd keep this restriction. What do you think?
> > * Require to use the same prefix: I'd keep it for now.

> I'm for a warning message that some network/stress tests not supporting
> such config.
Although I think prefix (mask) 32 resp. 128 doesn't make much sense, I'll remove both
restrictions. If I have enough time I'll implement use of different network variables for
local and remote hosts.

Thanks for your time and comments!


Kind regards,
Petr
