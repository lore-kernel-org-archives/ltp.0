From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 31 Aug 2020 09:39:27 +0200
Subject: [LTP] [LTP v4 3/5] IMA: Refactor datafiles directory
In-Reply-To: <67e8920833abf5f1b77fa59e90bdee3d4eb9262d.camel@linux.ibm.com>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-4-pvorel@suse.cz>
 <20200828131856.GA29915@dell5510> <20200828132825.GA12601@x230>
 <67e8920833abf5f1b77fa59e90bdee3d4eb9262d.camel@linux.ibm.com>
Message-ID: <20200831073927.GA15642@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi,

> On Fri, 2020-08-28 at 15:28 +0200, Petr Vorel wrote:
> > Hi,

> > > > +SUBDIRS	:= ima_*
> > I guess this could fix it:
> > SUBDIRS	:= $(shell ls ima_*) 

> Other LTP makefiles are using "wildcard".  Like this - $(wildcard
> ima_*/)?
Thanks for a tip. But it looks like wildchard doesn't work on out-of-tree
either:

/usr/src/ltp/include/mk/generic_trunk_target.inc:97: *** SUBDIRS empty -- did you want generic_leaf_target instead?.  Stop.

It's visible only on powerpc64le-linux-gnu-gcc build, because that is the only
one from out-of-tree builds which also does make install.
(We removed make install from most of the builds in order  1) avoid sporadic
build failures due lack of space on Travis docker 2) safe time.)

Thus I fixed it in 4231003f3 with just simple listing the targets:
-SUBDIRS        := ima_*
+SUBDIRS        := ima_kexec ima_keys ima_policy

Kind regards,
Petr
