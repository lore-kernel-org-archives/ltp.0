From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 4 Jan 2018 09:19:23 +0100
Subject: [LTP] [RFC PATCH v2 2/4] lapi/socket.h: Move definitions from
 netstress.c
In-Reply-To: <20171227084211.GA17258@x230>
References: <20171221192739.4868-1-pvorel@suse.cz>
 <20171221192739.4868-3-pvorel@suse.cz>
 <8186d043-06db-94a3-1da3-c2e57e42597b@oracle.com>
 <20171227084211.GA17258@x230>
Message-ID: <20180104081923.snicgzqmtsem46hj@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey, Cyril,

> > The other patches in this set look good, thanks!
> Just one exception, if you don't mind:
> I use lapi/netinet_in.h instead of lapi/in.h. I don't like inconsistency (other headers in
> lapi don't use prefix), but using just in.h is confusing, as there is also linux/in.h, as
> Cyril pointed out.

Merged whole patche-set.

Kind regards,
Petr
