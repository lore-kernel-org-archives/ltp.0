From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Sep 2019 11:50:23 +0200
Subject: [LTP] [PATCH v2 2/3] shell: Introduce TST_TIMEOUT variable
In-Reply-To: <CAEemH2duVbDqZ3UG3aHi4rQPFr-g-yxy3q-Jfw8p+2KV9ta=Tw@mail.gmail.com>
References: <20190913125823.17314-1-pvorel@suse.cz>
 <20190913125823.17314-3-pvorel@suse.cz>
 <CAEemH2f4oeSvN-p7xSzjo2ZFvndxjX2sQ+M9f6fYV_bN2ewn=A@mail.gmail.com>
 <20190917165520.GA30320@x230>
 <CAEemH2cHYS6jd4DCzJsy-vKLqShcFO6fU_-Rk=zxu=yD=7YLVg@mail.gmail.com>
 <20190918082421.GA11711@x230>
 <CAEemH2duVbDqZ3UG3aHi4rQPFr-g-yxy3q-Jfw8p+2KV9ta=Tw@mail.gmail.com>
Message-ID: <20190918095023.GA31233@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> On Wed, Sep 18, 2019 at 4:24 PM Petr Vorel <pvorel@suse.cz> wrote:

> > ...

> > > So, maybe that could be as a reason to disable float support for
> > > $LTP_TIMEOUT_MUL?

> > Maybe I'm missing something, therefore explaining the intent of the code.
> > (int was handled in if tst_is_int "$LTP_TIMEOUT_MUL"; then):

> I'm not blaming the int/float judgment, there is no problem. My concern is:

> If the $LTP_TIMEOUT_MUL is float and awk command is missing, how things
> will be going?

> It will break at:
>     tst_test_cmds awk
> right?
Yes. The concern is described in the commit message (but it should also be in
wiki page I guess): you want float => you need awk. You don't have float, just
set it as int (which will affect also C).
Does it make sense? Is it useful?

> Given that break on float number handling, why not declare only support
> integer for $LTP_TIMEOUT_MUL?
Sure, we can do it. But I propose to do it for C as well otherwise setup valid
for C will be breaking shell. But that's a backward incompatibility change.
That's why I suggested IMHO the least intrusive change (but maybe I'm wrong).
Anyone else having strong opinion?

> I hope I explained clearly this time, haha ;-)
Sure, sorry to be slow :).

Kind regards,
Petr
