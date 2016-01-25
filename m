From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jan 2016 17:41:29 +0100
Subject: [LTP] test.sh and ROD redirection
In-Reply-To: <56A64CCE.8040306@oracle.com>
References: <20160121135150.GA18731@rei.lan> <56A1F33A.4000807@oracle.com>
 <20160125111654.GA30655@rei.lan> <20160125134520.GE30655@rei.lan>
 <56A64CCE.8040306@oracle.com>
Message-ID: <20160125164129.GA2763@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +	for arg; do
> > +		if [ "$arg" == ">" ]; then
> 
> I would change it to
>          if [ "${arg:0:1}" == ">" ]; then
>                  arg=${arg:1}

That does work only in bash.

The easiest portable way I can come up with is:

	if [ "${arg#\>}" != "$arg" ]; then
		arg=${arg#\>}
	fi

> > +			flag=1
> > +			continue
> May be break here, so we don't need the next if block.

Right.

> > +		fi
> > +
> > +		if [ -n "$flag" ]; then
> > +			break
> > +		fi
> > +		cmd="$cmd $arg"
> 
> But what if the rest of args has something else, e.g. 2>&1 ?

Hmm, we can look for that in the $@ as well but nobody is using ROD with
that at the moment. We can think about this later ideally when there is
need for this.

-- 
Cyril Hrubis
chrubis@suse.cz
