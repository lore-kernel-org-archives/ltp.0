From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 May 2019 17:06:20 +0200
Subject: [LTP] [PATCH v2 1/2] numa: fix numa test error with
 non-continuous nodes
In-Reply-To: <CAEemH2e6WURWFkMneL6vdEwPpbwxj0Lt=HjpfSYdyzxnhGdODQ@mail.gmail.com>
References: <20190508084447.18191-1-liwang@redhat.com>
 <20190509071605.GB6096@dhcp-9-109-247-167.in.ibm.com>
 <CAEemH2e=9eRgj_1H50dY_=fEsL3vsZbxexxUceJhW24ebsQ1Kg@mail.gmail.com>
 <20190509091911.GA8751@dhcp-9-109-247-167.in.ibm.com>
 <CAEemH2e6WURWFkMneL6vdEwPpbwxj0Lt=HjpfSYdyzxnhGdODQ@mail.gmail.com>
Message-ID: <20190514150619.GA4394@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > diff --git a/testcases/kernel/numa/numa01.sh
> > b/testcases/kernel/numa/numa01.sh
> > index 33393ac8d..47c18edd6 100755
> > --- a/testcases/kernel/numa/numa01.sh
> > +++ b/testcases/kernel/numa/numa01.sh
> > @@ -94,6 +94,7 @@ setup()
> >  test1()
> >  {
> >         Mem_curr=0
> > +       node_index=0
> >
> >         for node in $nodes_list; do
> >                 numactl --cpunodebind=$node --membind=$node support_numa
> > alloc_1MB &
> > @@ -101,7 +102,8 @@ test1()
> >
> >                 TST_RETRY_FUNC "check_for_support_numa $pid" 0
> >
> > -               Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB"
> > |bc)
> > +               Mem_curr=$(echo "$(extract_numastat_p $pid $node_index) *
> > $MB" |bc)
> > +               let node_index++
> >
> 
> I guess it can be work, but the disadvantage of that is we have to involve
> a new variable(node_index) in each of the tests (from test1 to test10).
> Hence I don't think it is much better than my patch. For which way to go,
> I'd leave this to Cyril to make a choice. Or, maybe he has different
> thoughts on this:).

I actually do not care that much about the numa01.sh tests, because
these are broken in more ways than this and were never correct to begin
with.

I've started to rewrite these into proper tests, the set_mempolicy() was
first part of that effort, the mbind() tests are continuation of that
and the end goal is to get rid of these broken tests eventually.

-- 
Cyril Hrubis
chrubis@suse.cz
