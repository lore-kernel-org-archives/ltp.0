From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Jul 2019 13:56:32 +0800
Subject: [LTP] [PATCH] tst_test.sh: Use $LTP_TIMEOUT_MUL also in
 TST_RETRY_FN_EXP_BACKOFF()
In-Reply-To: <20190712134328.20528-1-pvorel@suse.cz>
References: <20190712134328.20528-1-pvorel@suse.cz>
Message-ID: <CAEemH2cdOO1XxmMUm+2VqaExGAPJbxSep4JXHjSZzT48_49Q-A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

If timeout occurred in the exp backoff macro, we could pass a bit more time
to it and use prototype directly.

    e.g.   TST_RETRY_FN_EXP_BACKOFF "$1" "$2" "more_time"

And yes, we actually can't guarantee a proper time value for all kinds of
platforms. So I agree on involve $LTP_TIMEOUT_MUL to exp backoff macro.

Btw, shouldn't we also apply this change to the C prototype too?
On Fri, Jul 12, 2019 at 9:43 PM Petr Vorel <pvorel@suse.cz> wrote:

> ...

-                       tst_brk TBROK "\"$tst_fun\" timed out"
> +                       tst_brk TBROK "\"$tst_fun\" timed out! If you are
> running on slow machine, try exporting LTP_TIMEOUT_MUL"
>

"..., try exporting LTP_TIMEOUT_MUL > 1" ?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190718/04f9d61f/attachment.htm>
