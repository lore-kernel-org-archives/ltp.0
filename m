From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 01 Aug 2017 09:42:55 +0200
Subject: [LTP] [PATCH] syscalls/keyctl04: new test for thread keyring
	memory leak
In-Reply-To: <20170731205704.GA41369@gmail.com>
References: <20170728211313.89836-1-ebiggers3@gmail.com>
 <87mv7lghr8.fsf@our.domain.is.not.set> <20170731205704.GA41369@gmail.com>
Message-ID: <87fudbhgxs.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Eric Biggers writes:

> Hi Richard, thanks for reviewing!
>
> On Mon, Jul 31, 2017 at 09:58:19AM +0200, Richard Palethorpe wrote:
>>
>> Thanks for contributing this test! We now have a directory
>> (testcases/cve) and runtest file dedicated to CVE regression tests. So
>> please atleast add it to the CVE runtest file.
>>
>
> I'll add it to 'runtest/cve' but will leave it in the syscalls/keyctl directory.
> I don't like the idea of putting "CVE regression tests" in a separate directory
> because then it will be harder to find all the tests for a given syscall or
> feature.

OK, this is fine. There is no particular filing structure which fits
every test and usage case. I was never particularly sure if having all
the tests with a CVE number in the same place would be a good idea,
although it makes filing some of them a lot easier.

>
>> > +#include "config.h"
>> > +#ifdef HAVE_LINUX_KEYCTL_H
>> > +# include <linux/keyctl.h>
>> > +#endif
>>
>> Please just include the definitions for keyctl in the test like:
>> https://github.com/richiejp/ltp/blob/cve/testcases/cve/cve-2016-7042.c
>> The vulnerability is still exploitable on systems without this header.
>>
>> On a related note; we should create a fallback header in include/lapi
>> for keyutils as there are a few tests which use it.
>>
>
> It's including the Linux UAPI header (from include/uapi/linux/keyctl.h), not
> even the libkeyutils header.  Is using UAPI headers really not allowed in LTP?
> I see tons of other tests that include <linux/${foo}.h>.
>
> Eric

The sys headers are preferred (or whatever user land library is most
commonly used) if there is one available because they are deemed to be
more stable and commonly available. Failing that the linux UAPI headers
can be used, but usually we will try to ensure the test will still run
even if the headers are missing or incomplete. Which, unfortunately, is
not that uncommon amongst LTP users even with the glibc headers.

There are a few tests using either keyutils or keyctl.h, so maybe we can
abstract them both away behind headers in the LTP lib, but that is not
necessarily your concern, I'm just writing it for the record.

--
Thank you,
Richard.
