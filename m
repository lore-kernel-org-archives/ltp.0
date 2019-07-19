From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Jul 2019 11:01:33 +0200
Subject: [LTP] [PATCH 1/2] shell: Use $LTP_TIMEOUT_MUL also in retry
 functions
In-Reply-To: <CAEemH2etXFYC-R1znaKCm_WyQDvAqT0fZafKLJGzTUU6uMEN1A@mail.gmail.com>
References: <20190718083943.7687-1-pvorel@suse.cz>
 <CAEemH2etXFYC-R1znaKCm_WyQDvAqT0fZafKLJGzTUU6uMEN1A@mail.gmail.com>
Message-ID: <20190719090133.GB30204@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > + That page is too long and without table of contents (not easy to
> > navigate in it; I tried to add TOC, but without success). Maybe adding
> > TOC or split the page to 3: 1) general info 2) C API 3) shell API would
> > help. WDYT?


> Personally, I think adding TOC may be a better choice, since we don't have
> the whole picture for the guidelines and usually hard to navigate in it.

> To split the guideline that probably leads to the new LTP-user to read more
> document pages. That's an annoying thing for me at least :).
Agree. I'll give TOC next try sooner or later :).

...
> >  _tst_setup_timer()
> >  {
> > -       LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
> > -
> >         local sec=$((300 * LTP_TIMEOUT_MUL))


> Maybe we need to check if the LTP_TIMEOUT_MUL is valid(>1) as what we do
> for C API?
Correct, sorry for omitting that => v3 needed.

Kind regards,
Petr
