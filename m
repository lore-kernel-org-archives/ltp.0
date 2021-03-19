From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 19 Mar 2021 10:01:25 +0100
Subject: [LTP] [PATCH v2 1/2] doc: Document test tags
In-Reply-To: <CAEemH2cGPW5KkS2rzU7PcZrLQaF9=O88n-rtOaHtHFoZaCYOSQ@mail.gmail.com>
References: <20210318181641.2062-1-pvorel@suse.cz>
 <20210318181641.2062-2-pvorel@suse.cz>
 <CAEemH2cGPW5KkS2rzU7PcZrLQaF9=O88n-rtOaHtHFoZaCYOSQ@mail.gmail.com>
Message-ID: <YFRoZfYwvXssI+4A@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Petr Vorel <pvorel@suse.cz> wrote:

> +Glibc git commit in a regression test for a glibc bug:
> > +[source,c]

> > +-------------------------------------------------------------------------------
> > +struct tst_test test = {
> > +       ...
> > +       .tags = (const struct tst_tag[]) {
> > +               {"glibc-git", "574500a108be"},
> > +               {}
> > +       }
> > +};

> > +-------------------------------------------------------------------------------
> > +
> > +[source,c]

> > +-------------------------------------------------------------------------------
> > +struct tst_test test = {
> > +       ...
> > +       .tags = (const struct tst_tag[]) {
> > +               {"glibc-git", "574500a108be"},
> > +               {}
> > +       }
> > +};


> I go through many times for the above two structures, but am not see any
> difference:).
Lol :). Thanks for pointing copy paste error, I'll remove the second one.

Kind regards,
Petr
