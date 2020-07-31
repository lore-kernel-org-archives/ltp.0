From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 31 Jul 2020 07:34:43 +0200
Subject: [LTP] [PATCH v6 4/4] IMA: Add test for kexec cmdline measurement
In-Reply-To: <1596139131.25003.14.camel@kernel.org>
References: <20200728001301.31121-1-pvorel@suse.cz>
 <1596139131.25003.14.camel@kernel.org>
Message-ID: <20200731053443.GB3900@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi, Lachlan,

> On Tue, 2020-07-28 at 02:13 +0200, Petr Vorel wrote:
> > From: Lachlan Sneff <t-josne@linux.microsoft.com>

> > IMA policy can be set to measure the command line passed in the kexec
> > system call. Add a testcase that verifies that the IMA subsystem
> > correctly measure the cmdline specified during a kexec.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> > [ pvorel: improved setup, various LTP API cleanup ]
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Thanks, really nice.

> Missing is a short comment explaining the reason for the multiple
> tests.

Just to reduce duplicity with checks.

Anyway, finally merged, thanks a lot both!

Kind regards,
Petr
