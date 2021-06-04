From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Jun 2021 13:34:19 +0200
Subject: [LTP] [RFC PATCH 0/2] Libclang based analyzer
In-Reply-To: <YLnvOpNr3HlTLWWP@pevik>
References: <20210603154825.30165-1-rpalethorpe@suse.com>
 <YLnGIJWPf2XsAdTt@pevik> <875yyuj91v.fsf@suse.de>
 <YLnvOpNr3HlTLWWP@pevik>
Message-ID: <YLoPu+To+U+x2md7@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> run-{c,shell}-api-tests is IMHO too long, but I was thinking about
> check-{,c,shell}-api. But maybe you're right, let's wait for others opinions.

I would vote for tests to be executed by 'make test' and the checks that
Ritchie implements should be started by 'make check'.

Even the kernel script is called checkpatch.pl so this would be
consistent with the terms used in Linux kernel.

-- 
Cyril Hrubis
chrubis@suse.cz
