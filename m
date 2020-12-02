From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Dec 2020 08:47:30 +0200
Subject: [LTP] [PATCH v5 00/10] Introduce SAFE_FANOTIFY_MARK() macro +
 cleanup
In-Reply-To: <20201201174214.24625-1-pvorel@suse.cz>
References: <20201201174214.24625-1-pvorel@suse.cz>
Message-ID: <CAOQ4uxhVu9YHMLj-YgosMPgvP1gNE=RpZPOWocuD0tGxGpj8GQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Dec 1, 2020 at 7:42 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> Changes v4->v5:
> * Fix issue with "fanotify: Add helper for FAN_REPORT_FID support on fs"
>   on fanotify01 (unwanted skipping tests). FAN_REPORT_FID is now tested
>   both for general support in kernel with fanotify_init() and support on
>   tested filesystem in fanotify_mark().
>
> * Fix issue with FAN_MARK_FILESYSTEM (new commit "fanotify: Add helper
>   for mark support check").
>
> * Split "[v4,2/6] fanotify: Handle supported features checks in setup()"
>   into two commits:
>   fanotify: Add helper for access permission check
>   fanotify: Add helper for event support check
>   (easier to review).
>
> * Drop commit "[v4,5/6] fanotify: Check FAN_REPORT_{FID, NAME} support"
>   => IMHO not needed now, as there are {REQUIRE_,}FANOTIFY_FAN_REPORT_FID_ERR_MSG()
>   helpers which check for FAN_REPORT_FID. Or am I'm wrong and you need it
>   for your patchset?

You are right.
My patch set can and will use FANOTIFY_FAN_REPORT_FID_ERR_MSG.

>   There will be needed to add also helper for FAN_REPORT_NAME/FAN_REPORT_DIR_FID
>   for fanotify10.c (for kernels > 5.1 && < 5.9), but this is now covered by check
>   in create_fanotify_groups() and I don't want to block your patchset even more.
>   And this helper should eliminate a need for check in safe_fanotify_init().
>

My patch set grows another test case with FAN_REPORT_NAME to fanotify09
so it is more than fare to leave that last cleanup to me ;-)

Looking forward for the merge of your work.
Thanks!

Amir.
