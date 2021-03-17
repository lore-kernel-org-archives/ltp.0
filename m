From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Mar 2021 10:54:31 +0100
Subject: [LTP] [PATCH] open_posix: Remove hardcoded /tmp
In-Reply-To: <CAEemH2e5xZvJQSYgBXqhgEpqYyQyM=VTb6sWBJr0REzBDVnr5A@mail.gmail.com>
References: <20210316130036.1838169-1-lkml@jv-coder.de>
 <CAEemH2dxiFi_6VUOpyaufkOecE8TCi-m8bVT=xY9GREzOfKW-A@mail.gmail.com>
 <4e99e625-07f1-e0c1-ab23-30f0ee8e59ef@jv-coder.de>
 <CAEemH2ej++f-e17ifn2eFqaQJmECgei62nXR7LnD-X1ypQ3czQ@mail.gmail.com>
 <dbebbb6b-b2d1-c95a-3a8d-d92aae7a83f3@jv-coder.de>
 <CAEemH2e5xZvJQSYgBXqhgEpqYyQyM=VTb6sWBJr0REzBDVnr5A@mail.gmail.com>
Message-ID: <YFHR13zKL9XZtdya@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > In fact useless, and nobody cares about the temp file name.
> > > But that'll make naming make some sense or tidy, IMO.
> > >
> > >     I just decided to keep it, so files, that are not deleted
> > >     automatically
> > >     can be identified as belonging to the test.
> > >     If I would implement this, then only in the macro definition.
> > >
> > >
> > > If I was the author, prefer to do that in macro definition too:).
> > If it makes you happy, I think this can be done while merging.
> >
> 
> Patch applied with two minor tweaks. Thanks!

Can we please fix the macro name?

The open posix testsuite uses PTS_ prefix instead of LTP_.

Also the tempfile.h header should have GPLv2-or-later SPDX header.

-- 
Cyril Hrubis
chrubis@suse.cz
