From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 Jun 2019 18:34:19 +0200
Subject: [LTP] [PATCH 1/2] inotify: Add SAFE_MYINOTIFY_INIT{,
	1}() helpers
In-Reply-To: <20190613131018.GA29926@rei.lan>
References: <20190605072126.19856-1-pvorel@suse.cz>
 <20190613131018.GA29926@rei.lan>
Message-ID: <20190613163418.GB24675@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> These two patches are obviously OK.
Thanks for review.

> Well I we were pedantic the licence change should be in a separate
> patch, but I guess that it's fine as it is.
I'll replace license text to SPDX in all tests using new API in separate commit.

> Also we should probably switch to the inotify_init() from sys/inotify.h
> and drop the my from the functions and macros, but that could be done in
> a subsequent patch.
Merged. I'll do it in a separate patch.

Kind regards,
Petr
