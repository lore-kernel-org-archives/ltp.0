From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 31 Jul 2017 13:57:04 -0700
Subject: [LTP] [PATCH] syscalls/keyctl04: new test for thread keyring
 memory leak
In-Reply-To: <87mv7lghr8.fsf@our.domain.is.not.set>
References: <20170728211313.89836-1-ebiggers3@gmail.com>
 <87mv7lghr8.fsf@our.domain.is.not.set>
Message-ID: <20170731205704.GA41369@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard, thanks for reviewing!

On Mon, Jul 31, 2017 at 09:58:19AM +0200, Richard Palethorpe wrote:
> 
> Thanks for contributing this test! We now have a directory
> (testcases/cve) and runtest file dedicated to CVE regression tests. So
> please atleast add it to the CVE runtest file.
> 

I'll add it to 'runtest/cve' but will leave it in the syscalls/keyctl directory.
I don't like the idea of putting "CVE regression tests" in a separate directory
because then it will be harder to find all the tests for a given syscall or
feature.

> > +#include "config.h"
> > +#ifdef HAVE_LINUX_KEYCTL_H
> > +# include <linux/keyctl.h>
> > +#endif
> 
> Please just include the definitions for keyctl in the test like:
> https://github.com/richiejp/ltp/blob/cve/testcases/cve/cve-2016-7042.c
> The vulnerability is still exploitable on systems without this header.
> 
> On a related note; we should create a fallback header in include/lapi
> for keyutils as there are a few tests which use it.
> 

It's including the Linux UAPI header (from include/uapi/linux/keyctl.h), not
even the libkeyutils header.  Is using UAPI headers really not allowed in LTP?
I see tons of other tests that include <linux/${foo}.h>.

Eric
