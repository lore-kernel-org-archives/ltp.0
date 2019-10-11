From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 10:17:35 +0200
Subject: [LTP] [RFC PATCH v4 3/5] shell: Add timeout shell API tests
In-Reply-To: <20191009143635.GF7561@rei.lan>
References: <20190930145916.20465-1-pvorel@suse.cz>
 <20190930145916.20465-4-pvorel@suse.cz>
 <20191009143635.GF7561@rei.lan>
Message-ID: <20191011081735.GB31207@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > +DATA="
> > +timeout01.sh||0
> > +timeout02.sh||0
> > +timeout02.sh|foo|32
> > +timeout02.sh|2|0
> > +timeout02.sh|1.1|0
> > +timeout02.sh|-10|32
> > +"
> > +
> > +echo "Testing timeout in shell API"
> > +echo
> > +
> > +failed=0
> > +IFS="
> > +"

> Do we have to change IFS here? It should be set to space, tab, and
> newline by default, so the loop over $DATA should work correctly
> anyways.
Again, thanks for catching this.
It's a left over from prototyping, where I had spaces in some data rows,
therefore it was needed.

> > +for i in $DATA; do
> > +	file=$(echo $i | cut -d'|' -f1)
> > +	timeout=$(echo $i | cut -d'|' -f2)
> > +	exp_exit=$(echo $i | cut -d'|' -f3)

Unless you want me to do else with tst_test_cmds in tst_test.sh,
I'll merge with changes you found.

Kind regards,
Petr
