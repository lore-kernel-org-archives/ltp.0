From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Dec 2019 12:10:56 +0100
Subject: [LTP] [PATCH 1/2] lib: add tst_request_hugepages
In-Reply-To: <CAEemH2doR7C6J4ROgLw=cJsWfH2-6y8-YwDwdGM8coH6ovM6_Q@mail.gmail.com>
References: <20191128084506.7587-1-liwang@redhat.com>
 <20191203104917.GA2844@rei>
 <CAEemH2d0KJ_oi7j5sjcT=uUo28crB_hCs-gJzvWhczvKOG-mdA@mail.gmail.com>
 <CAEemH2doR7C6J4ROgLw=cJsWfH2-6y8-YwDwdGM8coH6ovM6_Q@mail.gmail.com>
Message-ID: <20191204111056.GB32161@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > if the .needs_hugepages is set to an expected number, we should verify
> > strictly if the system can provide that.
> >
> 
> Oh, I guess maybe I misunderstand your suggestion here. you mean just to
> let .needs_hugepages = 1 but not set an expected number, right? if so, that
> will more easy to achieve.

We do have tests that needs more than 1 hugepage, there are tests that
do numa migration so we likely need the needs_hugepages to be unsigned
integer that represents the number of required hugepages.

> >> Also this fails to cleanup after itself, we have to restore the system
> >> after the test, which is one more reason why we need .needs_hugepages in
> >> the tst_test structure because the test library can cleanup after the
> >> test with that.
> >>
> >
> > Agree, I will add the save/restore part for this.
> >
> 
> Or just go with .save_restore in the testcase?

I guess that best option would be to call tst_sys_conf_save_str() in the
test library if we decided to change the nr_hugepages file.

-- 
Cyril Hrubis
chrubis@suse.cz
