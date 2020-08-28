From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Aug 2020 15:28:25 +0200
Subject: [LTP] [LTP v4 3/5] IMA: Refactor datafiles directory
In-Reply-To: <20200828131856.GA29915@dell5510>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-4-pvorel@suse.cz>
 <20200828131856.GA29915@dell5510>
Message-ID: <20200828132825.GA12601@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > +SUBDIRS	:= ima_*
I guess this could fix it:
SUBDIRS	:= $(shell ls ima_*) 

I'm surprised that glob does not work on SUBDIRS.

> It looks this broke build on out-of-tree build:
> https://travis-ci.org/github/linux-test-project/ltp/builds/722003659
> https://travis-ci.org/github/linux-test-project/ltp/jobs/722003661
> https://travis-ci.org/github/linux-test-project/ltp/jobs/722003662
> https://travis-ci.org/github/linux-test-project/ltp/jobs/722003663
> ...

Kind regards,
Petr
