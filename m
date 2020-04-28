From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 28 Apr 2020 16:26:43 +0300
Subject: [LTP] [PATCH 2/2] fanotify: Test with tst_variant both raw
 syscall and libc
In-Reply-To: <20200428113501.24711-2-pvorel@suse.cz>
References: <20200428113501.24711-1-pvorel@suse.cz>
 <20200428113501.24711-2-pvorel@suse.cz>
Message-ID: <CAOQ4uxjTh5r3JWVzt6Gazh61Cb1Fr7Y90k1mXn=q2WbsSRs2NQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 28, 2020 at 2:35 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
>
> patchset is based on Amir's patchset [1], which I'd prefer to have
> merged before.
>
> libc wrappers for fanotify_init() and fanotify_mark() are trivial, so it
> might not make sense to test both variants. WDYT?
>
> Kind regards,
> Petr
>
> [1] https://patchwork.ozlabs.org/project/ltp/list/?series=171631&state=*

FWIW, I have no objection to these changes.

I trust that you tested build with all supported configurations, because
I am not good at reviewing portable code.

Thanks,
Amir.
