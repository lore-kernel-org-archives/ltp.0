From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Sep 2019 15:53:27 +0200
Subject: [LTP] [PATCH v2 2/3] shell: Introduce TST_TIMEOUT variable
In-Reply-To: <CAEemH2d5imKVecBv_jB7VifdXbf9HZPFX=NAvT7Hgtjjq6VQdA@mail.gmail.com>
References: <20190913125823.17314-1-pvorel@suse.cz>
 <20190913125823.17314-3-pvorel@suse.cz>
 <CAEemH2f4oeSvN-p7xSzjo2ZFvndxjX2sQ+M9f6fYV_bN2ewn=A@mail.gmail.com>
 <20190917165520.GA30320@x230>
 <CAEemH2cHYS6jd4DCzJsy-vKLqShcFO6fU_-Rk=zxu=yD=7YLVg@mail.gmail.com>
 <20190918082421.GA11711@x230>
 <CAEemH2duVbDqZ3UG3aHi4rQPFr-g-yxy3q-Jfw8p+2KV9ta=Tw@mail.gmail.com>
 <20190918095023.GA31233@x230>
 <CAEemH2d5imKVecBv_jB7VifdXbf9HZPFX=NAvT7Hgtjjq6VQdA@mail.gmail.com>
Message-ID: <20190918135327.GA20793@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > > If the $LTP_TIMEOUT_MUL is float and awk command is missing, how things
> > > will be going?

> > > It will break at:
> > >     tst_test_cmds awk
> > > right?
> > Yes. The concern is described in the commit message (but it should also be
> > in
> > wiki page I guess): you want float => you need awk. You don't have float,
> > just
> > set it as int (which will affect also C).
> > Does it make sense? Is it useful?


> It's working, but not elegant. Not sure how many people will go through the
> documents for such tiny issues.

> Is there any possibility to handle float by default, and if no awk
> supporting, just round up the float to integer and use it do testing
> automatically?
Yep, that's better idea, thanks!
I'll print some info in case of forcing to round to int in v3.

Kind regards,
Petr
