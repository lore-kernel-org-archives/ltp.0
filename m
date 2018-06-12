From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Jun 2018 14:38:32 +0200
Subject: [LTP] [PATCH] [RFC] README.md: Add shortcut to running a single
 test
In-Reply-To: <20180612122609.GB31189@rei.lan>
References: <20180611123607.19390-1-chrubis@suse.cz>
 <20180612110209.xmsglkkwzvrxqur2@dell5510>
 <20180612122609.GB31189@rei.lan>
Message-ID: <20180612123832.7q2v7kocdd2icv4b@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > Nice idea. LGTM, just 2 typos found.

> Pushed with typos fixed, thanks for the review.
Actually I've noticed, that some shell tests expect to have LTPROOT defined,
like(move_pages.sh in testcases/kernel/syscalls/move_pages (which is going to be
removed anyway).
But we should decide how to handle LTPROOT (if it's needed, we should check for
it to be empty and warn).


Kind regards,
Petr
