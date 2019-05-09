From: Li Wang <liwang@redhat.com>
Date: Thu, 9 May 2019 18:00:17 +0800
Subject: [LTP] [PATCH v2 1/2] numa: fix numa test error with
 non-continuous nodes
In-Reply-To: <20190509091911.GA8751@dhcp-9-109-247-167.in.ibm.com>
References: <20190508084447.18191-1-liwang@redhat.com>
 <20190509071605.GB6096@dhcp-9-109-247-167.in.ibm.com>
 <CAEemH2e=9eRgj_1H50dY_=fEsL3vsZbxexxUceJhW24ebsQ1Kg@mail.gmail.com>
 <20190509091911.GA8751@dhcp-9-109-247-167.in.ibm.com>
Message-ID: <CAEemH2e6WURWFkMneL6vdEwPpbwxj0Lt=HjpfSYdyzxnhGdODQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Bala,

On Thu, May 9, 2019 at 5:19 PM Balamuruhan S <bala24@linux.vnet.ibm.com>
wrote:

> [...snip...]
> > > > --- a/testcases/kernel/numa/numa01.sh
> > > > +++ b/testcases/kernel/numa/numa01.sh
> > > > @@ -52,9 +52,18 @@ TST_NEEDS_CMDS="awk bc numactl numastat"
> > > >  extract_numastat_p()
> > > >  {
> > > >       local pid=$1
> > > > -     local node=$(($2 + 2))
> > > > -
> > > > -     echo $(numastat -p $pid |awk '/^Total/ {print $'$node'}')
> > > > +     local node=$2
> > > > +
> > > > +     echo $(numastat -p $pid |               \
> > > > +             awk -v node=$node '/Node/ {     \
> > > > +             gsub("Node", "");               \
> > > > +             for (i=0; i<NF; i++)            \
> > > > +                     if ($i == node)         \
> > > > +                             col=i+1;        \
> > > > +                     next                    \
> > > > +             }                               \
> > > > +             /^Total/ {print $col}'          \
> > > > +     )
> > > >  }
> > >
> > > If we can use extract_numastat_p0 with node_index then the existing
> code
> > > works, for example if can index while iterating $node_list and use this
> > > with extract_numastat_p0 then it should work.
> > >
> >
> > Hi Bala,
> >
> > Sorry, I don't fully understand what's you mean here :(. Could you
> explain
> > something more for this method?
>
> instead of changing `extract_numastat_p0()` can do something like this ?


> diff --git a/testcases/kernel/numa/numa01.sh
> b/testcases/kernel/numa/numa01.sh
> index 33393ac8d..47c18edd6 100755
> --- a/testcases/kernel/numa/numa01.sh
> +++ b/testcases/kernel/numa/numa01.sh
> @@ -94,6 +94,7 @@ setup()
>  test1()
>  {
>         Mem_curr=0
> +       node_index=0
>
>         for node in $nodes_list; do
>                 numactl --cpunodebind=$node --membind=$node support_numa
> alloc_1MB &
> @@ -101,7 +102,8 @@ test1()
>
>                 TST_RETRY_FUNC "check_for_support_numa $pid" 0
>
> -               Mem_curr=$(echo "$(extract_numastat_p $pid $node) * $MB"
> |bc)
> +               Mem_curr=$(echo "$(extract_numastat_p $pid $node_index) *
> $MB" |bc)
> +               let node_index++
>

I guess it can be work, but the disadvantage of that is we have to involve
a new variable(node_index) in each of the tests (from test1 to test10).
Hence I don't think it is much better than my patch. For which way to go,
I'd leave this to Cyril to make a choice. Or, maybe he has different
thoughts on this:).

Anyway, thanks for your suggestion.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190509/55f8a078/attachment.html>
