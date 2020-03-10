From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Mar 2020 16:46:33 +0100
Subject: [LTP] [PATCH 1/2] nfs_lib: Unify testing on netns
In-Reply-To: <5b00a232-d175-9cb1-ba20-ccd5d6e93cdc@oracle.com>
References: <20200305192716.10313-1-pvorel@suse.cz>
 <5b00a232-d175-9cb1-ba20-ccd5d6e93cdc@oracle.com>
Message-ID: <20200310154633.GA25942@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thanks for your review!

> > There is no need to run tests on opposite client/server when using
> > $TST_USE_NETNS based setup. It's enough just to set lhost IP address.
> > This simplifies code a bit.

> It changes the testcase, this way nfs traffic will go through
> lo interface, the test won't use ltp_ns_veth* and netns.
Sorry, I didn't notice this.
BTW code nfs_setup_server could be run by tst_rhost_run() (code simplification),
but that's a detail.

> We could add the knob for this scenario with LTP_NFS_USE_NETNS={1|0}?
Is this scenario useful? It does not look to me as a real world scenario,
but if I'm wrong let's add it :).

Kind regards,
Petr
