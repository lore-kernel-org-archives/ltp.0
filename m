From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Dec 2018 16:55:02 +0100
Subject: [LTP] [PATCH 1/1] travis: Use gcc 8 and clang 7
In-Reply-To: <20181211152527.GD1180@rei>
References: <20181207093126.12901-1-pvorel@suse.cz> <20181211152527.GD1180@rei>
Message-ID: <20181211155502.GB12977@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > Replacing gcc 5 with gcc 8 and clang 4 with clang 7.
> > This gives us shiny new versions, older and very old ones, while
> > still keeping the same number of jobs.

> The gcc one is hard choice gcc-5 is not that old yet, but we sure want
> to have bleeding edge there to prepare for tomorrow and we do have
> gcc-4.9 and gcc-6 so it's probably Ok.
I guess keeping 10 jobs is reasonable, but we can add more toolchains, if some
version is important for somebody.
The oldest gcc available repository [1] is 4.4 (our is 4.9), clang 3.5 (our oldest is 3.9).
=> I can use these older ones.


Kind regards,
Petr

[1] https://launchpad.net/~ubuntu-toolchain-r/+archive/ubuntu/test?field.series_filter=
