From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 7 May 2018 14:13:12 +0200
Subject: [LTP] [PATCH 1/1] ipneigh01: Replace TCONF error message with
 TINFO
In-Reply-To: <c6c5f26d-8fea-7419-3b0c-e4977afbf296@suse.de>
References: <20180503113637.21573-1-asmorodskyi@suse.com>
 <2943ea0b-0487-0136-bd1c-6d90bf80385f@oracle.com>
 <20180504144103.mglidc376gvtb25z@dell5510>
 <c6c5f26d-8fea-7419-3b0c-e4977afbf296@suse.de>
Message-ID: <20180507121312.mptzta7aggizjnlo@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Anton, Alexey,

> Hi Alexey

> This is my first attempt to contribute to LTP project. Disadvantage of th=
is
> is the fact that I can ask some obvious for you question ( hope you will
> forgive me that) , but advantage that I have a fresh look so I can point =
out
> to something that is wrong but you just get used too.

> First of all let's clarify something not related to this PR directly :


> > > And why it is more appropriate? TCONF is not an error message.
> In LTP documentation TCONF defined as - "The test case was not appropriate
> for the current hardware or software configuration". So I would not call =
it
> error too but I would say that it is some flavor of "SKIPPED" state.
> Where you want to say "this test case can't run currently so I can't say =
if
> it is passed or failed"
You can see it in in tst_resm() in testcases/lib/test.sh
    case "$ret" in
    TPASS|TFAIL)
    TST_COUNT=3D$((TST_COUNT+1));;
    esac

This is legacy API, new API behaves differently, see testcases/lib/tst_test=
.sh and doc:
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-w=
riting-a-testcase-in-shell
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-w=
riting-a-test-in-c
Legacy API is in maintenance mode (only bugfixes are allowed), some things =
aren't optimal
and not going to change).

> Second thing which needs to be taken in consideration=C2=A0 I clarified w=
ith Petr
> Vorel in conversation outside this ML - test counter changed only on TPASS
> or TFAIL. This lead us to really confusing log output :

> 1.
>    ipneigh01 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> 2.
>    ipneigh01 1 TINFO: set local addr 10.0.0.2/24
> 3.
>    ipneigh01 1 TINFO: set local addr fd00:1:1:1::2/64
> 4.
>    ipneigh01 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> 5.
>    ipneigh01 1 TINFO: set remote addr 10.0.0.1/24
> 6.
>    ipneigh01 1 TINFO: set remote addr fd00:1:1:1::1/64
> 7.
>    ipneigh01 1 TINFO: Network config (local -- remote):
> 8.
>    ipneigh01 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> 9.
>    ipneigh01 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> 10.
>    ipneigh01 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> 11.
>    ipneigh01 1 TCONF: 'arp cmd doesn't support IPv6, skipping test-case
> 12.
>    ipneigh01 1 TINFO: Stress auto-creation of NDISC cache entry
> 13.
>    ipneigh01 1 TINFO: by pinging 'fd00:1:1:1::1' and deleting entry again
> 14.
>    ipneigh01 1 TINFO: with 'ip neigh del fd00:1:1:1::1 dev ltp_ns_veth2'
> 15.
>    ipneigh01 1 TPASS: verified adding/removing of NDISC cache entry

> Please correct me if I missing something but I read this like "ok we can't
> run this test case because arp cmd doesn't support IPv6 , ah but wait test
> case is passed ".

> After all discussions around that patch and all info which I gain I can
> agree that changing TCONF with TINFO was bad idea , but if we will just
> "fix" issue by changing TST_TOTAL value to 1 ( if I correctly understand
> your suggestion )
> this will not remove this confusion.
There are 2 options:
1) a quick solution: for IPv6 change TST_TOTAL=3D1 and remove TCONF (skip i=
t quietly)
2) add command parameter to test and call it 2x in runtest file for IPv4 (a=
rp and ip) and
only once for (ip) for IPv6. See this commit, which does the same:
d1291fda8 network/interface: Split tests to test only one command per test
In this case might be better to migrate test into new shell API first (but =
not required).

> Only valid fix which I see is change behavior of LTP to change test case
> counter after TCONF which makes total sense for me , but most probably I
> missing something and you had some reasons to not changing counter on TCO=
NF
> messages. Can you please elaborate them ?


Kind regards,
Petr
