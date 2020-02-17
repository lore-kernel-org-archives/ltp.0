From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Feb 2020 12:02:30 +0100
Subject: [LTP] [PATCH 4/7] syscalls/fsmount: New tests
In-Reply-To: <CAEemH2fMTb3pk-NbqkjFhOiMY4NCO25GROomCAm810NkOj3R+Q@mail.gmail.com>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <1c61c673a02152c30edac0e25438257c23c3322e.1581680021.git.viresh.kumar@linaro.org>
 <CAEemH2f2pR1KhLAoKKphzh9fP++yyALbv4TiAh=4Vyv0M3SEdw@mail.gmail.com>
 <20200217082931.vbjkg2f53lek4uf3@vireshk-i7>
 <CAEemH2c28zj-+pec+sgoLzCq6iV627YvyH2hRpQN98eYZ_8geg@mail.gmail.com>
 <20200217095810.GC13398@dell5510>
 <CAEemH2dZboTZX00t0Kt6n_-sV+9StvJ24-ZLpdU3xFegBuLncQ@mail.gmail.com>
 <CAEemH2fMTb3pk-NbqkjFhOiMY4NCO25GROomCAm810NkOj3R+Q@mail.gmail.com>
Message-ID: <20200217110230.GA18700@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> >> So we can either add it to many places or detect this old glibc and
> >> compile with
> >> -D_GNU_SOURCE (but this might break other things).


> > -1 remove old Glibc is a bad choice.


> Sorry, that's a typo. I mean detect Glibc version is not a good idea:).
Agree. IMHO mostly we should use lapi than libc headers (+ put system headers
into lapi files), that'd keep old distros working.

Kind regards,
Petr
