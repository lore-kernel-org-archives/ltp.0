From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 8 Oct 2019 13:02:43 +0200
Subject: [LTP] [PATCH] getdents: Fix build under glibc 2.30
In-Reply-To: <20191008105025.GB9170@rei.lan>
References: <20191008093218.15801-1-pvorel@suse.cz>
 <20191008105025.GB9170@rei.lan>
Message-ID: <20191008110243.GA23860@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > glibc commit b8b3d5a14e ("Linux: Move getdents64 to <dirent.h>")
> > moved the declaration from <unistd.h> to <dirent.h> to match the
> > location of the declaration in musl.

> > Thus we need to include both <dirent.h> and <unistd.h> for getdents64().

> > Using getdents64() declaration requires on both glibc and musl
> > _GNU_SOURCE definition, thus move it to to getdents.h.

> I would rather go for _GNU_SOURCE being defined in the testcases rather
> than hiding it in the getdenst.h header and depending on the order.

> Other than that it's fine.

Make sense. Thanks for a review, merged with this change.

Kind regards,
Petr
