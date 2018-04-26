From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Apr 2018 15:47:26 +0200
Subject: [LTP] [PATCH] commands: Remove all test cases
In-Reply-To: <20180426132418.19495-2-schlad@suse.de>
References: <20180426132418.19495-1-schlad@suse.de>
 <20180426132418.19495-2-schlad@suse.de>
Message-ID: <20180426134726.GA14157@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Test cases testing commands are often outdated or not maintained.
> Those test cases also do not fit in with current LTP project status.

> Signed-off-by: Sebastian Chlad <schlad@suse.de>
> ---
this is controversial, as some people might be using some of them.
But I'd be for removing most of these - these are mostly smoke tests which should be
in upstream repositories (I guess live projects has better tests than these), where they
have better change to stay up to date.
Upstream tests are then can be run by packagers (and IMHO they're run, if they're
available).

IMHO LTP should aim to test kernel, not userspace tools for Linux distros.


Kind regards,
Petr
