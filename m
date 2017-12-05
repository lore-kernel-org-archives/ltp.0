From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Dec 2017 19:58:56 +0100
Subject: [LTP] [RFC PATCH v2 0/5] Travis enhancements
In-Reply-To: <20171204164421.GD21055@rei>
References: <20171201154641.27407-1-pvorel@suse.cz>
 <20171204164421.GD21055@rei>
Message-ID: <20171205185856.v77wzjlrvkgcwygu@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > It seems to be rule running only 5 containers at a time, so 11th build slowes
> > building about 4 min (18 min vs. 22 min). Which build would you remove?

> Well we do the build without any additional libs with gcc-7, we may as
> well switch it to clang-3.9 and drop the build with clang-3.9 with the
> additional libraries, that way we wouldn't lost much coverage.
gcc-7 is used for out-of-tree (gcc-6 was used in v3 for build with minimal dependencies)
OK clang-3.9 is now used only for build with minimal dependencies and it's the only build
of this type.
https://travis-ci.org/pevik-travis/ltp/builds/312014219

BTW: I'm planning to add also arm32 cross-compile build in near future. To keep only 10
jobs, I'll replace gcc-6 normal with all dependencies by it.


Kind regards,
Petr
