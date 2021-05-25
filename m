From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 25 May 2021 15:47:50 +0200
Subject: [LTP] [RFC PATCH 0/4] Auto review and Coccinelle
In-Reply-To: <87sg2akj01.fsf@suse.de>
References: <20210524144745.10887-1-rpalethorpe@suse.com>
 <YKzp0rxGfaxL1blw@yuki> <87sg2akj01.fsf@suse.de>
Message-ID: <YK0ABlx8wyHPp0Xf@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I guess that having it in travis as a post commit check would be better
> > than nothing.
> >
> > Pre commit hook would be ideal but requiring coccinelle installed for
> > LTP development would increase the bar for contribution too much I
> > guess.
> 
> I fear this defeats my primary goal of giving very quick feedback
> without involving patch submission. This makes me think of clang-tidy
> (clang-tools?) again. It will probably be more difficult to write LTP
> specific checks, but I guess every desktop Linux distro less than 10
> years old has Clang?

As far as I can tell clang is generally present on modern distributions
while coccinelle tends to be problematic on some distributions. It's a
great tool but it seems that there is a shortage of maintainers that can
maintain ocaml packages.

> I don't think there is much else I can do than try writing the same
> check in clang as well. See how that goes...

If that works well enough I would vote to a switch to clang-tidy.

> Anyway, we could copy the kernel to some extent. Make it so running
> 
> make coccicheck
> 
> or
> 
> make clang-tidy
> 
> or more generic
> 
> make check
> 
> Will recursively run the checks on the files under the current
> directory?

Sounds like a good plan.

-- 
Cyril Hrubis
chrubis@suse.cz
