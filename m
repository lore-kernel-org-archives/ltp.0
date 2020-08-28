From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Aug 2020 14:53:00 +0200
Subject: [LTP] [PATCH v2] travis: Use centos:7 instead of centos:6
In-Reply-To: <20200828105504.GC10501@yuki.lan>
References: <20200825064706.GA7135@x230>
 <1598339667-24948-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eS0PS=hmpiWBzkfBQ3cO4K2u2bVgcO5ZK4fz9N+xg7uQ@mail.gmail.com>
 <716a3ffc-fa20-01df-a63f-86a5a50239af@cn.fujitsu.com>
 <20200828105504.GC10501@yuki.lan>
Message-ID: <20200828125300.GA25839@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Hi!
> > Does have anything block this patch? Or, we should listen some advise 
> > from Jan and Cyril?

> I would be for dropping centos 6 (if nobody objects) after next release,
> which will happen in a couple of weeks anyways.

> So for now on I would be for adding centos 7, so that the next release
> compiles cleanly both on centos 6 and 7.

> Then we can work on our minimal requirements and drop obsolete code.
Make sense. So I merged the original patch.

Kind regards,
Petr
