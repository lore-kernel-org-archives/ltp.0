From: Domenico Andreoli <domenico.andreoli@linux.com>
Date: Mon, 10 Apr 2017 14:31:54 +0200
Subject: [LTP] [PATCH 1/2] open_posix_testsuite: Fix recursive build
In-Reply-To: <20170406152448.GA4977@rei.lan>
References: <20170405085821.13121-1-pvorel@suse.cz>
 <20170406152448.GA4977@rei.lan>
Message-ID: <20170410123154.GB20255@localhost>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Apr 06, 2017 at 05:24:49PM +0200, Cyril Hrubis wrote:
> Hi!

Hallo,

> > -top_srcdir?=		.
> > +open_posix_srcdir := $(if $(top_srcdir),$(top_srcdir)/testcases/open_posix_testsuite,$(abspath .))
> 
> I wonder if we want to be consistent with the rest of the LTP
> buildsystem define the top_srcdir ?= ../.. here so that we could use
> it below in both cases when the make is executed in the open posix
> directory or from the top level Makefile.

The important part is the use of abspath somewhere, these variables
are referenced also from processes running in different subdirs.

This is quite visible in the automatically generated makefiles.

> > diff --git a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
> > index 67a60c8cb..d50d517ae 100755
> > --- a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
> > +++ b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
> > @@ -22,7 +22,7 @@ generate_locate_test_makefile() {
> >  
> >  	echo "Generating $maketype Makefiles"
> >  
> > -	locate-test --$maketype | sed -e 's,^./,,g' > make-gen.$maketype
> > +	locate-test --$maketype $top_srcdir | sed -e 's,^./,,g' > make-gen.$maketype
> >  	generate_makefiles make-gen.$maketype $*

I had great troubles in enabling this step

Domenico

-- 
3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
