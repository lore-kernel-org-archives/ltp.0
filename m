From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Oct 2017 14:49:11 +0200
Subject: [LTP] [RFC PATCH v2 0/7] Fix 32-bit cross compilation
In-Reply-To: <87mv507eev.fsf@our.domain.is.not.set>
References: <20171009110101.3329-1-pvorel@suse.cz>
 <87mv507eev.fsf@our.domain.is.not.set>
Message-ID: <20171009124910.56ucyfavqmwcd7uh@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> I think this also requires a fix for libaio. Currently we just check for
> libaio.h in configure.ac.
Thanks! I'll include it in v3 (or in separate version in case v2 gets merged).


Kind regards,
Petr
