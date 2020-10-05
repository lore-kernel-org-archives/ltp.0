From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 5 Oct 2020 10:15:46 -0400 (EDT)
Subject: [LTP] [PATCH 04/11] docparse: Add README
In-Reply-To: <20201005133054.23587-5-chrubis@suse.cz>
References: <20201005133054.23587-1-chrubis@suse.cz>
 <20201005133054.23587-5-chrubis@suse.cz>
Message-ID: <135581472.16896262.1601907346856.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> +Open Points
> +===========
> +
> +There are stil some loose ends. Mostly it's not well defined where to put
> +things and how to format them.
> +
> +* Some of the hardware requirements are already listed in the tst\_test.
> Should
> +  we put all of them there?
> +
> +* What would be the format for test documentation and how to store things
> such
> +  as test variants there?

I'm assuming you don't mean ".test_variants" here, but runtest entries
using same binary with different parameters. Currently we have a "tag"
that can refer to binary+parameters pair. Which is also useful, for
skipping tests - e.g. they run long, they are broken, or older kernel
is known to crash - we have a list of checks that modify runtest files
before actual run to avoid running into known issues (or save time).

> +
> +So far this proof of concept generates a metadata file. I guess that we need
> +actual consumers which will help to settle things down, I will try to look
> into
> +making use of this in the runltp-ng at least as a reference implementation.
> --
> 2.26.2
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> 

