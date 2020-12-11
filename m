From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Dec 2020 14:34:01 +0100
Subject: [LTP] [PATCH v2 00/10] Introduce TST_EXP_MACROS
In-Reply-To: <CAEemH2epbXuk-npooQWxHW3THOX-3k-_9PpREqNO5hLZ9=__hA@mail.gmail.com>
References: <20201210141548.10982-1-chrubis@suse.cz>
 <CAEemH2epbXuk-npooQWxHW3THOX-3k-_9PpREqNO5hLZ9=__hA@mail.gmail.com>
Message-ID: <X9N1SZjbKOTeJvSd@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> One more point, we might have to handle the unsupported syscall
> issue in TST_EXP_*. Otherwise, we can NOT make use of these
> macros in tests like madvise01.c. But, I agree to merge patchset
> as V2, and solve that in follow-up changes.

We should add versions that will take zero terminated array of errnos
that should end up in TCONF later on, but as said I want to convert the
easy cases for now.

> For the series:
> Acked-by: Li Wang <liwang@redhat.com>

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
