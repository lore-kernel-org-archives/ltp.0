From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 May 2021 17:16:14 +0200
Subject: [LTP] [COMMITTED] [PATCH] Revert "docparse: Fix heading levels"
In-Reply-To: <20210512135458.12444-1-chrubis@suse.cz>
References: <20210512135458.12444-1-chrubis@suse.cz>
Message-ID: <YJvxPmk1YRzErjEZ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> This reverts commit 04a7608fe4f7fe2c267216d8b90acf019bdea824.

> Fixes build with asciidoc that otherwise failed with:

> ...
> asciidoc: ERROR: filters.txt: line 4: only book doctypes can contain level 0 sections
> ...
> asciidoc: ERROR: all-tests.txt: line 4: only book doctypes can contain level 0 sections

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Acked-by: Petr Vorel <pvorel@suse.cz>

I'm sorry for breaking the build, thanks for fixing it!
That was actually the reason why I used shifted level, but I didn't remember.
Thus I'll send a patch today for enhanced docparse testing.

Kind regards,
Petr
