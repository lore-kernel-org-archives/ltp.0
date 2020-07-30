From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 30 Jul 2020 12:16:43 +0200
Subject: [LTP] [PATCH 1/1] semctl: Fix 32 bit build
In-Reply-To: <20200730094842.GB3457@yuki.lan>
References: <20200730092637.487-1-pvorel@suse.cz>
 <20200730094842.GB3457@yuki.lan>
Message-ID: <20200730101643.GA6381@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> >  testcases/kernel/syscalls/ipc/semctl/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/testcases/kernel/syscalls/ipc/semctl/Makefile b/testcases/kernel/syscalls/ipc/semctl/Makefile
> > index 99971a7db..2559b4c28 100644
> > --- a/testcases/kernel/syscalls/ipc/semctl/Makefile
> > +++ b/testcases/kernel/syscalls/ipc/semctl/Makefile
> > @@ -8,6 +8,6 @@ LTPLIBS = ltpipc ltpnewipc
> >  include $(top_srcdir)/include/mk/testcases.mk

> >  semctl01 semctl02 semctl03 semctl04 semctl05 semctl06 semctl07: LDLIBS += -lltpipc
> > -semctl08: LDLIBS += -lltpnewipc
> > +semctl08: LDLIBS = -lltpnewipc -lltp

> If nothing else this may break things if user passed something in
> LDLIBS, so it should be:

> LDLIBS = -lltpnewipc $(LDLIBS)

Thanks! I tried that before, but without ':' before '=':
semctl08: LDLIBS = -lltpnewipc $(LDLIBS)
Makefile:12: *** Recursive variable 'LDLIBS' references itself (eventually).  Stop.

Assigning as := fixes that:
-semctl08: LDLIBS += -lltpnewipc
+semctl08: LDLIBS := -lltpnewipc $(LDLIBS)

Sorry for overlooking obvious error.

> And I guess the safest rule would be to add the -lltp* libraries first,
> because naturally none of the code in LTP but the test depends on these.
Are you're going to fix by changing order somewhere in include/mk/?
Or shell I push the fix with your ack?
I'd prefer proper fix so commits like this or 22f510de8 ("Fix static linking
with musl-fts") aren't needed any more.

Kind regards,
Petr
