From: Sandeep Patil <sspatil@android.com>
Date: Tue, 18 Jun 2019 13:25:01 -0700
Subject: [LTP] [PATCH v2 3/3] syscalls/bind01: convert to new library.
In-Reply-To: <20190613145507.GD29926@rei.lan>
References: <20190610002610.2187-1-sspatil@android.com>
 <20190610002610.2187-4-sspatil@android.com>
 <20190613145507.GD29926@rei.lan>
Message-ID: <20190618202501.GD203031@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 13, 2019 at 04:55:07PM +0200, Cyril Hrubis wrote:
> Hi!
> Pushed with minor changes, thanks.
> 
> However the test fails with -i 2 after this patch since on second
> iteration since the socket is already bind for the possitive test
> because we no longer close the socket after each iteration.

Ew, sorry about that. I guess I never ran it with the option as I only tried
what is listed in runtest.

I'll try it with '-i 2'.

> Looking at
> the bind tests we should move this one into a separate testcase and add
> a few more positive tests as well we seem to test only AF_INET,
> SOCK_STREAM combination which does not even cover ipv4 nor we attemp to
> connect to the socket that have been bind.

Agree, added to my to-do list. I am mostly burning through tests and
converting them to the new library manually.

> 
> > +// SPDX-License-Identifier: GPL-2.0
> 
> Changed this to GPL-2.0-or-later to match the original license.

I thought the original was GPL-2.0 (may be I misread the text, sorry).

> 
> And removed the NULL parameter from the TST_GET_UNUSED_PORT(), since
> newlib variant does not have the cleanup callback parameter.

Ack, thanks for doing this Cyril. Hopefully the next ones will apply without
edits ;0)

- ssp
