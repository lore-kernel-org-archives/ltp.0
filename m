From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Nov 2020 20:56:18 +0100
Subject: [LTP] [PATCH 1/1] net/traceroute01: Check also -T flag
In-Reply-To: <cf76949d-32a7-7b2d-4d5b-6117676ecea6@oracle.com>
References: <20201112173609.4123-1-petr.vorel@suse.com>
 <20201119152300.05ef03b0@kmaincent-XPS-13-7390>
 <20201119154132.GA16438@pevik>
 <cf76949d-32a7-7b2d-4d5b-6117676ecea6@oracle.com>
Message-ID: <20201119195618.GA3181@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 19.11.2020 18:41, Petr Vorel wrote:
> > Hi Kory, Alexey,

> >> Hello Petr,

> >> Just find out you didn't merge your patch which makes the code cleaner. :)
> > Waiting for Alexey's review.
> > Also hesitate about tracepath6 symlink to traceroute being always installed
I meant here traceroute6 symlink to traceroute.
> > on all distros (hopefully yes).

> Hi Petr,

> From the subject it seems you are adding a new check for -T flag
> but it is actually for -I option?
Good catch, thanks!

> I think it's ok using symlink or -4/-6,
If nobody complains I'd keep symlink version as it can check
traceroute from iputils. -4/-6 is more portable. If anybody complains and we
revert it back, I'd also put back iputils related warning.

> it is also adding an extra
> check for ipv6 that $(tst_ipaddr rhost) is indeed ipv6.
Sorry, I didn't get this.

BTW ack this change?

Kind regards,
Petr
