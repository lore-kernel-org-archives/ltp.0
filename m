From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 17 Mar 2021 11:05:03 +0100
Subject: [LTP] [PATCH 1/2] pec: Convert to the new API
In-Reply-To: <YFHNDN1CEcBo6oMG@pevik>
References: <20210315092844.991073-1-lkml@jv-coder.de> <YFHNDN1CEcBo6oMG@pevik>
Message-ID: <87117f6f-58e7-8b68-38c3-be5b080e86b6@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 3/17/2021 10:34 AM, Petr Vorel wrote:
> BTW: would it make sense to rename runtest/connectors to runtest/netlink
> and move code from testcases/kernel/connectors/ to testcases/kernel/netlink/?
Maybe kernel/netlink/connector/. Connector is an abstraction on top of 
netlink with a slightly
different interface than pure netlink (eg. cn_msg instead of nlmsghdr).
There are only very few other modules, that use this interface at the 
moment (MS HyperV, MD,? uvesafb? and dallas' 1-wire).

The question is: Is the interface the correct think to categorize by? If 
the interface (i.e. netlink) is used for categorization, then some of 
the crypto tests should also be in this netlink category.

J?rg
