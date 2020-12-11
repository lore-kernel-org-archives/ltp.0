From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Dec 2020 18:45:56 +0800
Subject: [LTP] [PATCH v2 00/10] Introduce TST_EXP_MACROS
In-Reply-To: <20201210141548.10982-1-chrubis@suse.cz>
References: <20201210141548.10982-1-chrubis@suse.cz>
Message-ID: <CAEemH2epbXuk-npooQWxHW3THOX-3k-_9PpREqNO5hLZ9=__hA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Dec 10, 2020 at 10:15 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> This patchset adds TST_EXP_MACROS() implementation.
>
> These macros are intended to simplify and unify syscall unit tests.
>
> This patchset converts a few testcases to use TST_EXP_MACROS() it's
> intenteded to serve as an example since there is a lot of testcases that
> could use them as well.
>
> Also the documentation for these macros is ommited at this point, I will
> add it in a case that we agree to include them in the test library.
>
>
> Changes in v2:
>
> - renamed the macros so that it's more clear that they do
> - added documentation to test-writing-guidelines
> - minor fixed in the converted testcases
>

One more point, we might have to handle the unsupported syscall
issue in TST_EXP_*. Otherwise, we can NOT make use of these
macros in tests like madvise01.c. But, I agree to merge patchset
as V2, and solve that in follow-up changes.

For the series:
Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201211/2c269794/attachment-0001.htm>
