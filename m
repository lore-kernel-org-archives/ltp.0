From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Feb 2021 14:31:16 +0100
Subject: [LTP] [PATCH v2 5/5] close_range: Add test
In-Reply-To: <YCZ/v82SPHjCtPI2@yuki.lan>
References: <20210211174543.25003-1-rpalethorpe@suse.com>
 <20210211174543.25003-6-rpalethorpe@suse.com>
 <YCZ9FaUwcitx3hNL@pevik> <YCZ/v82SPHjCtPI2@yuki.lan>
Message-ID: <YCaDJAlQOEF5wulw@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > >  .../kernel/syscalls/close_range/.gitignore    |   1 +
> > >  .../kernel/syscalls/close_range/Makefile      |  10 +
> > >  .../syscalls/close_range/close_range01.c      | 200 ++++++++++++++++++

> > It looks like you haven't added close_range01 to runtest file.
> > It should probably go to syscalls and Cyril can add it before merging.

> That's what I did along with a few more minor changes and pushed.
Great :).

> > Patchset LGTM and compiles ok.

> Sorry I haven't included your review in the tags.
np :). Thanks for handling this.

Kind regards,
Petr
