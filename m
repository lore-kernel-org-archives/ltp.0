From: Michael Moese <mmoese@suse.de>
Date: Thu, 11 Jan 2018 13:36:23 +0100
Subject: [LTP] [PATCH v2] Add regression test for CVE-2017-17052
In-Reply-To: <87o9m0k2dn.fsf@rpws.prws.suse.cz>
References: <20180110155505.28433-1-mmoese@suse.de>
 <87o9m0k2dn.fsf@rpws.prws.suse.cz>
Message-ID: <20180111123623.6hcnodqfrae3ix7y@linux.suse>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Richardm
On Thu, Jan 11, 2018 at 01:26:28PM +0100, Richard Palethorpe wrote:
> Welcome to LTP :-)
Thank you. I will be working on LTP now, so expect to see me here 
more often.

> > +#include "tst_safe_sysv_ipc.h"
> 
> It is better to use a shared mapping created with mmap. The SYSV safe
> macros are only for testing SYSV shared memory itself and otherwise
> should be avoided.
Yes, I agree on that. I had a discussion with Cyril yesterday, 
he explained this subject to me. I already implemented the change, but
was not yet able to fully test this. 

I will resend the patch, but I guess it is a good idea to relax and see
if anyone has additional remarks (so we don't end with a v10) :-)


Thanks,
Michael

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
