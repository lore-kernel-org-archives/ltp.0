From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jul 2020 19:36:06 +0200
Subject: [LTP] [PATCH v2 6/7] net/test: Add basic testing for
 tst_rhost_run
In-Reply-To: <9a30538f-bb7b-3fb9-7102-2f75b2d7de8c@163.com>
References: <20200710172044.21592-1-pvorel@suse.cz>
 <20200710172044.21592-7-pvorel@suse.cz>
 <5F155DB2.8080709@cn.fujitsu.com> <20200720115345.GA21201@dell5510>
 <9a30538f-bb7b-3fb9-7102-2f75b2d7de8c@163.com>
Message-ID: <20200720173606.GB20642@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> > > Hi Petr,
> > > 1) Do you want to discard stderr as well? For example:
> > > -------------------------------------------------
> > > # which gre >/dev/null
> > > /usr/bin/which: no gre in
> > > (/opt/ltp/testcases/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/root/bin)
> > That's not needed because tst_rhost_run already redirect stderr to stdout.

> Hi Petr,

> I think you means tst_rhost_run -c 'which grep' >/dev/null rather than
> tst_rhost_run -c 'which grep > /dev/null'

> The current code just discard stdout, for example:

> -------------------------------------------------------

> [root@Fedora-30-workstation net]# ./tst_rhost_run.sh
> ...
> tst_rhost_run 1 TINFO: NETNS: ns_exec 3079 net,mnt sh -c " which gre >
> /dev/null || echo RTERR" 2>&1
> which: no gre in (./../../../../testcases/lib/:/usr/share/Modules/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/root/bin:/opt/ltp/testcases/bin)
I'm sorry, I accidentally tested on which version from debianutils which prints
also errors to stdout. which from GNU which (used in openSUSE/SLES, Fedora/RHEL)
prints errors to stderr => you're right stderr should be redirected.
On the other hand when not redirected, you can see PATH.


Kind regards,
Petr
