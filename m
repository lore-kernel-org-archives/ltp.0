From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 19 Nov 2018 16:40:04 +0100
Subject: [LTP] [PATCH v4 1/2] net: Add tst_net_run helper
In-Reply-To: <37a6f27b-096e-8701-b8ee-4132d10ef889@oracle.com>
References: <20181113163008.9093-1-pvorel@suse.cz>
 <09aff1dd-a89f-479b-49da-c0c776b08b91@oracle.com>
 <20181116142411.GA24956@dell5510>
 <37a6f27b-096e-8701-b8ee-4132d10ef889@oracle.com>
Message-ID: <20181119154004.GB26645@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> >>> Maybe we could signal where error occurred:
> >>> * return 0: ok on both lhost and rhost
> >>> * return 1: failure on lhost
> >>> * return 2: failure on rhost
> >>> * return 3: failure on both lhost and rhost


> >> It is only when there is no "safe" option, right?
> > yes, as safe exit with TCONF and warning.

> >> when doing cleanup?
> > IMHO in any "non-safe" run.

> >> Could we print TWARN message inside tst_net_run() in such case?
> > I wanted tst_net_run() to behave similarly as tst_rhost_run(), which doesn't
> > warn about it. So I propose to add warning to both functions, but also add -q
> > flag (quiet), which suppress this warning.

> I think we don't need it for tst_rhost_run() as it is clear where the
> error has happened. Unlike tst_net_run() without safe option.
OK, make sense, I'll put it just into tst_net_run().


> > The reason for quiet mode is, that (I suppose) there are cases when some
> > features is tested and TWARN isn't wanted. Some examples (looks -s is used often
> > in cleanup functions):

> '-s' is used often in cleanup with tst_rhost_run()?
Sorry, I was wrong. Previously I meant tst_rhost_run *without -s* option.

tst_rhost_run with -s option in cleanup is only in 2 files:
testcases/network/mpls/mpls_lib.sh
testcases/network/tcp_cmds/sendfile/sendfile01
Maybe that's a mistake (unlike C functions where error in SAFE_* continue with
warning, in shell it exits during cleanup).

Without -s we don't get any warning, which is often desirable.
=> I'll put warning and -q switch to suppress it only into tst_net_run().


Kind regards,
Petr
