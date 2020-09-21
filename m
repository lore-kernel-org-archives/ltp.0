From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Sep 2020 11:47:14 +0200
Subject: [LTP] [PATCH v6] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <CAEemH2d_m16MhGrjxWHCeQ0BU9Fa562TVjaa+C_ecnPYhCfthw@mail.gmail.com>
References: <20200918171710.19227-1-chrubis@suse.cz>
 <CAEemH2d_m16MhGrjxWHCeQ0BU9Fa562TVjaa+C_ecnPYhCfthw@mail.gmail.com>
Message-ID: <20200921094714.GA2311@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > + *   address.
> > + *
> > + *   Kernel default 'stack_guard_gap' size is '256 * getpagesize()'.
> > + *
> > + *   The stack memory map would look like:
> > + *
> > + *   |  -  -  -   reserved  size   -  -  -  |
> > + *
> > + *   +-- - - - --+------------+-------------+
> > + *   | 256 pages |  unmapped  |   mapped    |
> > + *   +-- - - - --+------------+-------------+
> > + *                            | mapped size |
> > + *   ^           |  -  -  stack size  -  -  |
> > + *   start
> > + *               ^                          ^
> > + *               stack bottom       stack top
> > + *

...

> > +static void *allocate_stack(size_t stack_size, size_t mapped_size)
> > +{
> > +       void *start, *stack_top, *stack_bottom;
> > +
> > +       long reserved_size = 256 * page_size + stack_size;
> > +
> > +       start = SAFE_MMAP(NULL, reserved_size, PROT_READ | PROT_WRITE,
> > +                         MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +       SAFE_MUNMAP(start, reserved_size);
> > +
> > +       SAFE_MMAP((start + reserved_size - mapped_size), mapped_size,
> > PROT_READ | PROT_WRITE,
> > +                 MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS | MAP_GROWSDOWN,
> > +                 -1, 0);
> > +
> > +       stack_top = start + reserved_size;
> > +       stack_bottom = start + reserved_size - stack_size;
> >
> 
> As the stack grows down, shouldn't grow from stack_bottom to stack_top?
> which
> means stack_bottom = start + reserved_size.

That depends on the definition of top and bottom. For me it makes sense
that the the stack grows from top to the bottom because it grows down,
which is consistent with the MAP_GROWSDOWN flag.

Also this is really the reason why I added the ASCII art to the top
level comment of the test in order to make clear how these terms are
used in the code.

-- 
Cyril Hrubis
chrubis@suse.cz
