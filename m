From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Oct 2017 10:36:15 +0200
Subject: [LTP] [RFC PATCH 1/7] net/tcp_cmds: Remove rwho test
In-Reply-To: <2b595bc0-c7be-782f-9592-da206498f84a@oracle.com>
References: <20171018135001.30382-1-pvorel@suse.cz>
 <20171018135001.30382-2-pvorel@suse.cz>
 <2b595bc0-c7be-782f-9592-da206498f84a@oracle.com>
Message-ID: <20171026083615.g2nwz4kkf27z3h2d@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> On 10/18/2017 04:49 PM, Petr Vorel wrote:
> > rwhod daemon is way too old to bother to test it.

> As far as I remember, another problem with this test is that it's not
> really applicable for automated runs because rwho requires someone to
> be logged in to the machine for about 2 min to make it pass.

> I'm ok with removing it.

> Thanks,
> Alexey

Thanks, I pushed it.

Please if you agree with other tests to be deleted, ack it.
I'd be for deleting at least finger, echo, rlogin and rdist, as Vapier asked for keeping rcp
and rsh. IMHO these project should test their code themselves, I'd prefer LTP concern more
about the Linux kernel itself, not about *anything* it runs on linux distribution
(including networking).


Kind regards,
Petr
