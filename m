From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 4 May 2017 15:46:13 +0200
Subject: [LTP] [RFC PATCH v5 0/3] Simplify network setup
In-Reply-To: <8a43347a-716f-7ce6-2758-e5eda838e265@oracle.com>
References: <20170503160751.1634-1-pvorel@suse.cz>
 <8a43347a-716f-7ce6-2758-e5eda838e265@oracle.com>
Message-ID: <20170504134613.tyinrlvw4iagn2lh@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > There is still requirement network prefix to be < 8 (IPv4) resp. 16 (IPv6) as
> > then IPV{4,6}_NETWORK variables would be empty, which is not expected by tests
> > (they join it with address separators with {L,R}HOST_IPV{4,6}_HOST. Even we got
> > rid of reverse related variables we still need IPV{4,6}_NETWORK variables for
> > some tests.

> Hi Petr,

> But you removed such dependency on the prefix from test_net.sh  in
> the third patch... so we could just print the warning that configuration
> is not appropriate for the old tests, that is for stress/multicast,
> stress/route groups only.
Right, I'll remove requirement network prefix to be < 8 (IPv4) resp. 16 (IPv6).
There are other restrictions you probably don't like:
* Don't use 32 (IPv4) and 128 (IPv6): I'd keep this restriction. What do you think?
* Require to use the same prefix: I'd keep it for now.


Kind regards,
Petr
