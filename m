From: Petr Vorel <pvorel@suse.cz>
Date: Sun, 14 Apr 2019 11:59:09 +0200
Subject: [LTP] [RFC PATCH 1/3] cve/cve-2014-0196: Don't use libutil for
	Android
In-Reply-To: <20190412193929.GD124555@google.com>
References: <20190411233115.32744-1-pvorel@suse.cz>
 <20190411233115.32744-2-pvorel@suse.cz>
 <20190412193929.GD124555@google.com>
Message-ID: <20190414095909.GA17032@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sandeep,

> On Fri, Apr 12, 2019 at 01:31:13AM +0200, Petr Vorel wrote:
> > From: Petr Vorel <petr.vorel@gmail.com>

> > as it's not available for it.

> > Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> We've needed this for a while now and I always end up removing
> the libutil reference in the auto-generated gen.bp file. Thanks for
> fixing this Petr.

> Acked-by: Sandeep Patil <sspatil@android.com>
Thanks for your review, pushed this one.


Kind regards,
Petr
