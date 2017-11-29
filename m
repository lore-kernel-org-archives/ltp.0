From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Nov 2017 09:27:43 +0100
Subject: [LTP] [RFC PATCH 1/4] travis: Add build script
In-Reply-To: <CAEemH2evorTPAHpnYjydKcvwYha27zYSPZGKLZe+97Mni7N7vA@mail.gmail.com>
References: <20171128232130.4843-1-pvorel@suse.cz>
 <20171128232130.4843-2-pvorel@suse.cz>
 <CAEemH2evorTPAHpnYjydKcvwYha27zYSPZGKLZe+97Mni7N7vA@mail.gmail.com>
Message-ID: <20171129082743.d5i5stufxmn25twr@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> How about adding a new function for ltp build out of tree?

> build_out_of_tree()
> {
>        echo "===== build ltp out of tree ====="
> ...
> }
I'm planning it, but first we need to actually fix out of tree build.
Well, It's not broken, but it does not install all files (make install is
broken), so technically I could add it.

> > +case "$1" in
> > +       -h|--help|help) usage; exit 0;;


>             -o|--out) build="build_out_of_tree";;

> > +       32) build="build_32";;
> > +       *) build="build_native";;
I decided not to use getopts, as we'd have to use getopt from util-linux (getopts shell
builtin does not handle long opts.


Kind regards,
Petr

