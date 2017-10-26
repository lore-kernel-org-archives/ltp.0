From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Oct 2017 16:25:24 +0200
Subject: [LTP] [RFC PATCH 1/7] net/tcp_cmds: Remove rwho test
In-Reply-To: <ba581b16-797f-be55-03f6-4fe631588a7c@oracle.com>
References: <20171018135001.30382-1-pvorel@suse.cz>
 <20171018135001.30382-2-pvorel@suse.cz>
 <2b595bc0-c7be-782f-9592-da206498f84a@oracle.com>
 <20171026083615.g2nwz4kkf27z3h2d@dell5510>
 <ba581b16-797f-be55-03f6-4fe631588a7c@oracle.com>
Message-ID: <20171026142524.hcim7vn7bbdlh4fr@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 10/26/2017 11:36 AM, Petr Vorel wrote:
> > ...
> > Please if you agree with other tests to be deleted, ack it.
> > I'd be for deleting at least finger, echo, rlogin and rdist, as Vapier asked for keeping rcp
> > and rsh. IMHO these project should test their code themselves, I'd prefer LTP concern more
> > about the Linux kernel itself, not about *anything* it runs on linux distribution
> > (including networking).

> By running those tests youare also verifying kernel TCP stack and
> network drivers.
Sure :-). But it's question, whether it's a best way to test it with testing complicated
apps like FTP or DNS servers (error in these hardly ever find a problem in kernel API,
or drivers, more likely it's a bug in test itself or configuration problem).

IPsec and interface related tests looks to me much more relevant (are in a good shape
after you fixed them and use only basic user space tools like ip).

BTW content of runtest/commands might be better to have in util-linux testing repo, where
there are some anyway [1].

> Looking at rlogin, it's the only one among them which is convertedto
> newer API
> already, let's keep it along with the rcp, rsh, they are inthe same
> packages.
> Acked the rest.
Thanks for acking, I kept these three, deleted rest.

> I guess we should also change default network configuration to SSH.
+1.


Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/tests
