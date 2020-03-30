From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Mar 2020 10:44:07 +0200
Subject: [LTP] [PATCH 5/6] lib: Implement SAFE_RUN_CMD() macro (new API
 only)
In-Reply-To: <CAEemH2fusvyGAnDmfFEYqhnsbHwzrT+B3+FFD6bnJGpz3oB-QA@mail.gmail.com>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <20200327213924.18816-6-pvorel@suse.cz>
 <CAEemH2fusvyGAnDmfFEYqhnsbHwzrT+B3+FFD6bnJGpz3oB-QA@mail.gmail.com>
Message-ID: <20200330084407.GA12844@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Thanks for your work on this.


> > +static inline void safe_run_cmd(const char *file, const int lineno,
Old code. 'static inline' shouldn't be here.

> > +                                                          const char
> > *const argv[],


> Be cautious of the code indent here, otherwise patchset looks good.
Thanks!


> > +                             const char *stdout_path,
> > +                             const char *stderr_path)
> > +{

Kind regards,
Petr
