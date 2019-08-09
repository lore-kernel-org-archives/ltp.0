From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 9 Aug 2019 12:07:01 +0200
Subject: [LTP] [PATCH v3 4/4] build: Move
 -Werror-implicit-function-declaration from make to build.sh
In-Reply-To: <20190809093354.GA13178@rei.lan>
References: <20190806164523.557-1-pvorel@suse.cz>
 <20190809093354.GA13178@rei.lan>
Message-ID: <20190809100701.GB27030@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > +CFLAGS="${CFLAGS:--Werror-implicit-function-declaration}"

> Shouldn't this be -Werror=implicit-function-declaration ?
Yes, it is. '${CFLAGS:-' part is POSIX shell substitute (${parameter:-[word]}
from [1]), the result is '-Werror=implicit-function-declaration' when CFLAGS is
empty or not set.
I might change it as

I might change it to more readable form:
DEFAULT_CFLAGS="-Werror-implicit-function-declaration"
CFLAGS="${CFLAGS:-$DEFAULT_CFLAGS}"

> Hmm, looks like both variants actually work, but the gcc manual speaks
> only about -Werror= one.


> Otherwise it looks good, acked.
Thx! Although I plan to send some RFC for moving ffsb as a subproject, it has a
low priority. So I'll merge this with your ack.

Kind regards,
Petr

[1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02
