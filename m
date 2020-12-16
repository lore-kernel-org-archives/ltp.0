From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Dec 2020 20:15:32 +0100
Subject: [LTP] [PATCH 1/1] Docparse: Escape | in table content
In-Reply-To: <X9ovkdN27zTsK+PN@pevik>
References: <20201216143244.8180-1-pvorel@suse.cz> <X9oc1p0Z7LbBhKr0@yuki.lan>
 <X9ojaYZkNuwOOsyk@pevik> <X9ooMiuT3DKHwHjJ@yuki.lan>
 <X9ovkdN27zTsK+PN@pevik>
Message-ID: <X9pc1MSXJetCuPTk@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > Hi!
> > > BTW I wonder how to fix .test_variants in JSON:
> > > "test_variants": "ARRAY_SIZE"

> > > It's in many tests, e.g.  testcases/kernel/syscalls/clock_gettime/clock_gettime02.c.

> > I guess that we can filter out test_variants for now, I do not think
> > that it will be useful for the metadata that much.

> +1, I'll do it.

Actually, thinking about it twice I'd quite like to have all tags.
Here test variant is for me info that test either test both raw syscall and libc
wrapper or these tests have support for time64 (Viresh Kumar's patches).

So for me would be enough boolean info, not the actual number of variants.

Kind regards,
Petr
