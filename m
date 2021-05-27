From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 27 May 2021 16:44:12 +0200
Subject: [LTP] [RFC PATCH 1/1] doc: Split test-writing-guidelines
In-Reply-To: <YK+QeafN4q6IUvOn@yuki>
References: <20210526154949.4473-1-pvorel@suse.cz>
 <YK+QeafN4q6IUvOn@yuki>
Message-ID: <YK+wPLPBEHxH5gmq@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > Test Writing Guidelines wiki page is too long, thus split it
> > into 3 parts:

> > 1) generic part (only first chapter, the same URL)
> > 2) C test API (2.2 chapter, 4. Common problems)
> > 3) shell test API

> > Unfortunately this breaks users' bookmarks.

> > Start numbering in headers from 1 on each page (links are broken
> > anyway).

> > NOTE: in order to have '...' formatting as code,
> > main header ====== was needed to add on the page.

> The split looks good to me, acked.
Thank to you all, merged.
Unfortunately I left two things, thus two more small fixes were needed.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > See it:
> > https://github.com/pevik/ltp/wiki/Test-Writing-Guidelines

> This page should be updated, at least the paragraph about commenting code
> should now explain top level comment format.

> The backward compatibility should be improved as well, since we have
> kernel config parser now as well, etc.

> I guess that I should sit down and write a patch for that one once the
> split is applied.

Agree to all.

Kind regards,
Petr
