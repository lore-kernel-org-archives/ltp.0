From: Mimi Zohar <zohar@linux.ibm.com>
Date: Fri, 28 Aug 2020 12:32:27 -0400
Subject: [LTP] [LTP v4 3/5] IMA: Refactor datafiles directory
In-Reply-To: <20200828132825.GA12601@x230>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-4-pvorel@suse.cz> <20200828131856.GA29915@dell5510>
 <20200828132825.GA12601@x230>
Message-ID: <67e8920833abf5f1b77fa59e90bdee3d4eb9262d.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 2020-08-28 at 15:28 +0200, Petr Vorel wrote:
> Hi,
> 
> > > +SUBDIRS	:= ima_*
> I guess this could fix it:
> SUBDIRS	:= $(shell ls ima_*) 

Other LTP makefiles are using "wildcard".  Like this - $(wildcard
ima_*/)?

Mimi
> 
> I'm surprised that glob does not work on SUBDIRS.
> 
> > It looks this broke build on out-of-tree build:
> > https://travis-ci.org/github/linux-test-project/ltp/builds/722003659
> > https://travis-ci.org/github/linux-test-project/ltp/jobs/722003661
> > https://travis-ci.org/github/linux-test-project/ltp/jobs/722003662
> > https://travis-ci.org/github/linux-test-project/ltp/jobs/722003663
> > ...
> 
> Kind regards,
> Petr


