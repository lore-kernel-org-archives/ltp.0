From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Jan 2020 16:32:08 +0100
Subject: [LTP] [PATCH 1/1] tst_device: use raw syscall in the
 tst_device.h
In-Reply-To: <20200110152607.GB23359@rei.lan>
References: <20200110151443.212842-1-pvorel@suse.cz>
 <20200110152607.GB23359@rei.lan>
Message-ID: <20200110153208.GA219598@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> Hi!
> > tested on
> > https://travis-ci.org/pevik/ltp/builds/635305638

> > Please anybody ack and merge, so we can move on with merging other
> > things before git freeze.

> Acked once and if the travis run finishes green.
Merged. As I wrote, 3 broken Debian testing jobs are related to bug in libtirpc
1.2.5, which are fixed by following commit.

Kind regards,
Petr
