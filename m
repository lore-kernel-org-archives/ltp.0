From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 14 May 2018 21:39:01 +0200
Subject: [LTP] network stress route-change-if test
In-Reply-To: <659899b6-63c8-8be0-5289-298dc9beba9d@oracle.com>
References: <20180510162714.c2hdgj3eamhcderg@dell5510>
 <de6cbd3b-8c6e-4d48-5a92-7ec062a4bc17@oracle.com>
 <20180511105613.6pzrq3cmt6x7thvl@dell5510>
 <659899b6-63c8-8be0-5289-298dc9beba9d@oracle.com>
Message-ID: <20180514193901.hqvu25tbu726cdmv@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> >> Assuming those test are using different interfaces just to load the
> >> machine more, the tests should be rewritten to use a single interface.
> > route-change-if is about switching route between (at least) 2 interfaces.
> > Therefore it must have 2 interfaces available.

> What about creating additional virtual devices for this test like
> macvlan and switch between them?
Good idea.
I'm just thinking whether using ns-udpsender is enough (it's hard to make it fail).

> > The test has similar scenario as if-route-adddel, but it's not the same.
> > So, delete the test as we don't support it?
> > I think it's valid scenario, but we don't have support which test requires.


Kind regards,
Petr
