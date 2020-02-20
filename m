From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Feb 2020 08:52:52 +0100
Subject: [LTP] [PATCH V2 01/10] tst_device: Add tst_ismount() helper
In-Reply-To: <20200220071923.vyr7lpftidkgbi6g@vireshk-i7>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <199f58740e42bbdbcba0c847c194f62d2b3bb37b.1582104018.git.viresh.kumar@linaro.org>
 <CAEemH2e9fhUVU3DbpXCEimL0k8eGLuuSRcicq4NYOk_zELLqMw@mail.gmail.com>
 <20200220071923.vyr7lpftidkgbi6g@vireshk-i7>
Message-ID: <20200220075252.GA2860622@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> > Sorry, I think the return value should be '1' if it has been mounted
> > already.

> > e.g
> > These codes will make people confused about whether it's
> > mounted successfully or not.

> > if (tst_ismount(MNTPOINT))
> >         tst_brk(TBROK | TERRNO, "device not mounted");

> I kept the return 0 on success thing here as well, but maybe yeah, it
> should return 1 on success here.

Most of the functions returns 1 or -1 on failure. But here it's this approach
really confusing, because the name and purpose. So I'd also be for 0 on failure and 1
on success.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
