From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Mar 2018 17:35:00 +0100
Subject: [LTP] Errored: linux-test-project/ltp#699 (master - 67c95fb)
In-Reply-To: <5aa68a846c12_43fcf924d5e1c1134186@742623e8-1050-46c6-b205-a80535524ffb.mail>
References: <linux-test-project/ltp+352345577+errored@travis-ci.org>
 <5aa68a846c12_43fcf924d5e1c1134186@742623e8-1050-46c6-b205-a80535524ffb.mail>
Message-ID: <20180313163500.2ks5yeax64ldndyo@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Build Update for linux-test-project/ltp
> -------------------------------------

> Build: #699
> Status: Errored

> Duration: 14 minutes and 43 seconds
> Commit: 67c95fb (master)
> Author: Richard Palethorpe
> Message: Add read_all file systems test

> While using a shell script I wrote, which dumps the contents of /sys and
> /proc (submitted in a separate patch), I found some minor kernel bugs. There
> is already a test specifically for /proc however it is attempting to verify
> the behavior of particular files. This test is more general and can be applied
> to any file system.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>

> View the changeset: https://github.com/linux-test-project/ltp/compare/3de6dcba463e...67c95fbbfc3a

> View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/352345577?utm_source=email&utm_medium=notification

Travis is getting really bad. Not surprising that this is false positive (my attempt to
fix travis in a59e44928 "travis: Trying to make travis more reliable" didn't help), but we
didn't get mail about failure of build #702 3f2ff1490 ("Add regression test for CVE-2017-17053"):
https://travis-ci.org/linux-test-project/ltp/builds/352813245
which correctly shows failure only for cross-compilation (missing asm/ldt.h, which is only
for x86 architecture).

I fixed it in f3cbd3403 ("cve: Fix compilation for non x86 architectures").
https://travis-ci.org/linux-test-project/ltp/builds/352917608

Kind regards,
Petr
