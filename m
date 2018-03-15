From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Mar 2018 12:44:56 +0100
Subject: [LTP] [PATCH 2/2] Add CVE-2017-18075,
 pcrypt mishandles freeing instances
In-Reply-To: <20180314225849.GD183724@gmail.com>
References: <20180314145427.2738-1-rpalethorpe@suse.com>
 <20180314145427.2738-2-rpalethorpe@suse.com>
 <20180314225849.GD183724@gmail.com>
Message-ID: <20180315114456.GA17877@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >  runtest/cve                    |   1 +
> >  testcases/cve/.gitignore       |   1 +
> >  testcases/cve/cve-2017-18075.c | 201 +++++++++++++++++++++++++++++++++++++++++
> 
> Thanks for writing an LTP test for this!
> 
> Just my 2 cents, but I think it is insane to be naming tests after CVE numbers
> instead of putting them in an appropriate place, like a crypto/ directory for
> this one.  People aren't going to remember what "CVE-2017-18075" is.  I'm even
> the person who fixed this bug and requested this CVE, and I still didn't
> recognize the CVE number; this patch only drew my attention because the subject
> line mentioned pcrypt.  (And now I see that I missed the recent test for the
> modify_ldt() use-after-free bug because the patch subject line and description
> only mentioned "CVE-2017-17053".)

Agreed, the numbers suck, I have to read everything twice to avoid
typos.

Maybe we should name the test files after the kernel subsystem with an
increasing counter as a last resort.

> I suggest putting this NETLINK_CRYPTO stuff in a common location that can be
> used by other tests too.  This will not be the last crypto API bug.  The
> definitions for AF_ALG probably should be there too; though AF_ALG isn't used by
> this test, many crypto bugs I've fixed or seen fixed recently are accessible
> through it.  (E.g. see commit ecaaab564978, "crypto: salsa20 - fix
> blkcipher_walk API usage" or commit e57121d08c38, "crypto: chacha20poly1305 -
> validate the digest size".  Sorry, I was a bit lazy by just putting reproducers
> in the commit messages and not writing "real" tests.)  It would be great to have
> helper functions in LTP for testing the crypto API, so that they don't have to
> be repeated in every test.

We do have include/lapi/ headers for that purpose, we may as well put it
there.

-- 
Cyril Hrubis
chrubis@suse.cz
