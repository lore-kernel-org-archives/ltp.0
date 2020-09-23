From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Sep 2020 11:10:07 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: More readable syntax
In-Reply-To: <CAEemH2coWxUma1Pm7E-MEz6xHx0V9NFyNcTEU57F3e_7gMBynA@mail.gmail.com>
References: <20200922144237.9865-1-pvorel@suse.cz>
 <CAEemH2coWxUma1Pm7E-MEz6xHx0V9NFyNcTEU57F3e_7gMBynA@mail.gmail.com>
Message-ID: <20200923091007.GA12109@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> On Tue, Sep 22, 2020 at 10:42 PM Petr Vorel <pvorel@suse.cz> wrote:

> > "for cmd; do" works the same way as "for cmd in $*; do", but the latter
> > is more readable. Also sync the code with tst_require_cmds().

> > Fixes: dba1d50cb ("tst_test.sh: Add test cmd helper tst_check_cmds()")

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>


> Reviewed-by: Li Wang <liwang@redhat.com>
Thanks for a review, merged.

Kind regards,
Petr
