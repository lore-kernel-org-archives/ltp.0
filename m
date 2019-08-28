From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Wed, 28 Aug 2019 12:15:02 +0200
Subject: [LTP] [PATCH v4 0/4] Basic eBPF tests
In-Reply-To: <2001459109.8602383.1566978371578.JavaMail.zimbra@redhat.com>
References: <20190826111024.19053-1-chrubis@suse.cz>
 <1492475067.8173800.1566829761941.JavaMail.zimbra@redhat.com>
 <1566977183.6539.10.camel@suse.de>
 <2001459109.8602383.1566978371578.JavaMail.zimbra@redhat.com>
Message-ID: <1566987302.6539.21.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 2019-08-28 at 03:46 -0400, Jan Stancek wrote:
> ----- Original Message -----
> > On Mon, 2019-08-26 at 10:29 -0400, Jan Stancek wrote:
> > > 
> > > ----- Original Message -----
> > > > I've ended up playing with the patchset and fixed a few loose
> > > > ends
> > > > on
> > > > the map test and as I had the code at hand I decided to send v4
> > > > instead
> > > > of pointing out the mistakes in a review.
> > > > 
> > > > There were numerous small changes for the map test:
> > > > 
> > > > * Make sure the key buffer is sized exactly for the content
> > > > 
> > > > * Initialized the array/hash element value in test setup
> > > > 
> > > > * Made the code flow a bit more obvious, it was hard to tell
> > > > which
> > > >   part was run for n == 0 and which for n == 1
> > > > 
> > > > Also it looks that for me the test that loads the eBPF program
> > > > ends
> > > > up
> > > > with EPERM randomly at about 10th iteration both as
> > > > unpriviledged
> > > > and
> > > > priviledged user, which is really strange.
> > > 
> > > There's one EPERM I can reproduce reliably with bpf_map test,
> > > which
> > > appears
> > > to originate from "bpf_charge_memlock".
> > > 
> > > There's a deferred component to map freeing, and unchange appears
> > > to
> > > be part of it:
> > >   bpf_map_release
> > >     bpf_map_put
> > >       INIT_WORK(&map->work, bpf_map_free_deferred);
> > >         (deferred) bpf_uncharge_memlock
> > > 
> > > When I lower max locked memory, it's easy to hit:
> > > # ulimit  -l 128; ./bpf_map01 -i 100
> > > ...
> > > bpf_map01.c:52: CONF: bpf() requires CAP_SYS_ADMIN on this
> > > system:
> > > EPERM
> > > 
> > > Can you try bumping max locked memory to some high value and
> > > check
> > > if that helps your case?
> > 
> > # for i in 64 128 256 1024; do
> >     echo $i;
> >     ulimit -l $i;
> >     ./bpf_prog01 -i 100 |& grep -P 'passed|CONF';
> > done
> > 
> > 64
> > CONF: bpf() requires CAP_SYS_ADMIN on this system: EPERM
> > passed   16
> > 
> > 128
> > CONF: bpf() requires CAP_SYS_ADMIN on this system: EPERM
> > passed   16
> > 
> > 256
> > CONF: bpf() requires CAP_SYS_ADMIN on this system: EPERM
> > passed   32
> > 
> > 1024
> > CONF: bpf() requires CAP_SYS_ADMIN on this system: EPERM
> > passed   192
> > 
> > 
> > Which produce almost the same results.
> > Same approach with `bpf_map01` differs a lot. Sometimes all pass,
> > sometimes none.
> 
> Seems to make difference for me on 5.2:
> 
> # cat bench.sh; sh bench.sh 
> for i in 128 256 512 1024 4096 65536; do
>         echo $i;
>         ulimit -l $i;
>         ./bpf_prog01 -i 100 |& grep -P 'passed|CONF';
>         sleep 4;
> done
> 
> 128
> bpf_prog01.c:114: CONF: bpf() requires CAP_SYS_ADMIN on this system:
> EPERM
> passed   32
> 256
> bpf_prog01.c:114: CONF: bpf() requires CAP_SYS_ADMIN on this system:
> EPERM
> passed   64
> 512
> bpf_prog01.c:114: CONF: bpf() requires CAP_SYS_ADMIN on this system:
> EPERM
> passed   128
> 1024
> passed   200
> 4096
> passed   200
> 65536
> passed   200
> 

I ran it again and now my results looks like yours...
