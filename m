From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 Mar 2021 12:47:21 +0100
Subject: [LTP] [PATCH 1/2] pec: Convert to the new API
In-Reply-To: <87117f6f-58e7-8b68-38c3-be5b080e86b6@jv-coder.de>
References: <20210315092844.991073-1-lkml@jv-coder.de> <YFHNDN1CEcBo6oMG@pevik>
 <87117f6f-58e7-8b68-38c3-be5b080e86b6@jv-coder.de>
Message-ID: <YFHsSWLeaqwdAWzZ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi J?rg,

> Hi Petr,

> On 3/17/2021 10:34 AM, Petr Vorel wrote:
> > BTW: would it make sense to rename runtest/connectors to runtest/netlink
> > and move code from testcases/kernel/connectors/ to testcases/kernel/netlink/?
> Maybe kernel/netlink/connector/. Connector is an abstraction on top of
+1

> netlink with a slightly
> different interface than pure netlink (eg. cn_msg instead of nlmsghdr).
> There are only very few other modules, that use this interface at the moment
> (MS HyperV, MD,? uvesafb? and dallas' 1-wire).
I'd still put it into netlink and try to put there more general netlink
subsystem tests. My objection is that runtest/connectors has only single test
and connectors is very generic name.

> The question is: Is the interface the correct think to categorize by? If the
> interface (i.e. netlink) is used for categorization, then some of the crypto
> tests should also be in this netlink category.
Thus maybe add some of relevant tests also into runtest/netlink? We shave some
kind of duplicity (see runtest/cve, it contains some tests which are also in
runtest/syscalls). That would also justify creating runtest/netlink (because
having just single test for legacy connector interface in runtest/netlink does
not sound good to me).

Kind regards,
Petr

> J?rg
