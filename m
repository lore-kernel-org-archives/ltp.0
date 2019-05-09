From: Li Wang <liwang@redhat.com>
Date: Thu, 9 May 2019 15:54:15 +0800
Subject: [LTP] [PATCH v2 1/2] numa: fix numa test error with
 non-continuous nodes
In-Reply-To: <20190509071605.GB6096@dhcp-9-109-247-167.in.ibm.com>
References: <20190508084447.18191-1-liwang@redhat.com>
 <20190509071605.GB6096@dhcp-9-109-247-167.in.ibm.com>
Message-ID: <CAEemH2e=9eRgj_1H50dY_=fEsL3vsZbxexxUceJhW24ebsQ1Kg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 9, 2019 at 3:16 PM Balamuruhan S <bala24@linux.vnet.ibm.com>
wrote:

> On Wed, May 08, 2019 at 04:44:46PM +0800, Li Wang wrote:
> > Numa test failed on such machine which has non-continuous numa nodes,
> > it gets wrong data because of the below syntax rule is not applicable
> > to that special situation.
> >   ` numastat -p $pid |awk '/^Total/ {print $'$((node+2))'}'
> > In this patch, we fix that via a bit complex way of awk to get the
> > allocated memory in specified node.
> >
> >   # numactl -H
> >   available: 2 nodes (0,8)
> >   node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18
> >                19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34
> >                35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50
> >                51 52 53 54 55 56 57 58 59 60 61 62 63
> >   node 0 size: 257741 MB
> >   node 0 free: 253158 MB
> >   node 8 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79
> >                80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
> >                96 97 98 99 100 101 102 103 104 105 106 107 108
> >                109 110 111 112 113 114 115 116 117 118 119 120
> >                121 122 123 124 125 126 127
> >   node 8 size: 261752 MB
> >   node 8 free: 240933 MB
> >   node distances:
> >   node   0   8
> >     0:  10  40
> >     8:  40  10
> >
> >   # numastat -p $pid
> >   Per-node process memory usage (in MBs) for PID 34168 (support_numa)
> >                              Node 0          Node 8           Total
> >                     --------------- --------------- ---------------
> >   Huge                         0.00            0.00            0.00
> >   Heap                         0.00            0.12            0.12
> >   Stack                        0.00            0.06            0.06
> >   Private                      1.62            1.50            3.12
> >   ----------------  --------------- --------------- ---------------
> >   Total                        1.62            1.69            3.31
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Cc: Chunyu Hu <chuhu@redhat.com>
> > Cc: Cyril Hrubis <chrubis@suse.cz>
> > ---
> >  testcases/kernel/numa/numa01.sh | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/testcases/kernel/numa/numa01.sh
> b/testcases/kernel/numa/numa01.sh
> > index 33393ac8d..7f3dee849 100755
> > --- a/testcases/kernel/numa/numa01.sh
> > +++ b/testcases/kernel/numa/numa01.sh
> > @@ -52,9 +52,18 @@ TST_NEEDS_CMDS="awk bc numactl numastat"
> >  extract_numastat_p()
> >  {
> >       local pid=$1
> > -     local node=$(($2 + 2))
> > -
> > -     echo $(numastat -p $pid |awk '/^Total/ {print $'$node'}')
> > +     local node=$2
> > +
> > +     echo $(numastat -p $pid |               \
> > +             awk -v node=$node '/Node/ {     \
> > +             gsub("Node", "");               \
> > +             for (i=0; i<NF; i++)            \
> > +                     if ($i == node)         \
> > +                             col=i+1;        \
> > +                     next                    \
> > +             }                               \
> > +             /^Total/ {print $col}'          \
> > +     )
> >  }
>
> If we can use extract_numastat_p0 with node_index then the existing code
> works, for example if can index while iterating $node_list and use this
> with extract_numastat_p0 then it should work.
>

Hi Bala,

Sorry, I don't fully understand what's you mean here :(. Could you explain
something more for this method?



>
> This is just my thoughts, please feel free to correct me if I miss or
> it is something wrong. Thanks!
>
> -- Bala
> >
> >  check_for_support_numa()
> > @@ -363,7 +372,16 @@ test9()
> >               pid=$!
> >               TST_RETRY_FUNC "check_for_support_numa $pid" 0
> >
> > -             Mem_huge=$(echo $(numastat -p $pid |awk '/^Huge/ {print
> $'$((node+2))'}'))
> > +             Mem_huge=$(echo $(numastat -p $pid |    \
> > +                     awk -v node=$node '/Node/ {     \
> > +                     gsub("Node", "");               \
> > +                     for (i=0; i<NF; i++)            \
> > +                             if ($i == node)         \
> > +                                     col=i+1;        \
> > +                             next                    \
> > +                     }                               \
> > +                     /^Huge/ {print $col}')          \
> > +             )
> >               Mem_huge=$((${Mem_huge%.*} * 1024))
> >
> >               if [ "$Mem_huge" -lt "$HPAGE_SIZE" ]; then
> > --
> > 2.20.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190509/81d3c6c9/attachment.html>
