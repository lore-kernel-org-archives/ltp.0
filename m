From: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Thu, 11 Mar 2021 14:26:22 +0000
Subject: [LTP] [PATCH 1/3] open_posix_testsuite/generate-makefiles.sh:
 Avoid inconsistencies with make version
In-Reply-To: <YEjiYkuyGvs8QT8T@rei.lan>
References: <20210309155623.2457857-1-richard.purdie@linuxfoundation.org>
 <YEjiYkuyGvs8QT8T@rei.lan>
Message-ID: <ff5b641d8673eda9308b4176f0e52c4b2935c7ab.camel@linuxfoundation.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 2021-03-10 at 16:14 +0100, Cyril Hrubis wrote:
> Hi!
> Patchset pushed, thanks.
> 
> Also it looks like the wildcard used to be sorted but they removed that
> in a few make versions and nobody knows why:
> 
> https://stackoverflow.com/questions/40558385/gnu-make-wildcard-no-longer-gives-sorted-output-is-there-any-control-switch

Thanks. That decision in make was unfortunate and I think we'll be living 
with it for a while.

The good news is I think with these changes we have ltp behaving consistently
within Yocto Project :)

Cheers,

Richard

