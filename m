From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 09 Oct 2017 13:23:52 +0200
Subject: [LTP] [RFC PATCH v2 0/7] Fix 32-bit cross compilation
In-Reply-To: <20171009110101.3329-1-pvorel@suse.cz>
References: <20171009110101.3329-1-pvorel@suse.cz>
Message-ID: <87mv507eev.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

I think this also requires a fix for libaio. Currently we just check for
libaio.h in configure.ac.

-- 
Thank you,
Richard.
