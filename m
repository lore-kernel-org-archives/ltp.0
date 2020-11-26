From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 26 Nov 2020 09:30:53 +0100
Subject: [LTP] [PATCH] realtime/m4: Re-add define for robust mutexattr
 APIs
In-Reply-To: <20201119113816.GH2785@yuki.lan>
References: <20201119095227.921830-1-lkml@jv-coder.de>
 <20201119113816.GH2785@yuki.lan>
Message-ID: <8dc13989-88bf-1727-1dbd-83a2163ffb03@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 11/19/2020 12:38 PM, Cyril Hrubis wrote:
> Hi!
> The code switched to the POSIX variants later on so I wonder if we even
> need this configure check or if we can remove the ifdefs from the
> testcases completely.
either that or this patch. At least at the moment these tests are 
completely broken.
I am not sure how long pthread_mutexattr_*roboust* api is part of posix 
and if ltp is supposed to be supported on platforms, that may not 
implement it.

But should accepting this patch wouldn't do any harm for now, but would 
fix the tests. In the future it can still be removed completely.

J?rg

PS: @Cyril Sorry for the resending this, forgot to include the mail list

