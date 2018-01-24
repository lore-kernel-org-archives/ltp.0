From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 24 Jan 2018 14:30:47 +0100
Subject: [LTP] [PATCH 00/19] Fix a bunch of warnings (mainly
 old-style-definition)
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124133047.xiasvjpxo4j6iy25@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Michael,
> Hi,
> I was able to find the time to fix a bunch of the warnings when building
> LTP. With a fex exceptions, this was fixig function definitions, like 
> changing int foo() to int foo(void) or changing old K&R-style to what you
> would expect. None of the changes was bigger than that. I did one patch per 
> file, and each of them was individually build-tested.

> Michael

Thanks :-).
Acked-by: Petr Vorel <pvorel@suse.cz>


Kind regards,
Petr
