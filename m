From: Li Wang <liwang@redhat.com>
Date: Thu, 24 Jun 2021 16:37:02 +0800
Subject: [LTP] [PATCH 1/2] lib/tst_test: setup TCID earlier in do_setup()
In-Reply-To: <20210624081500.11715-1-aleksei.kodanev@bell-sw.com>
References: <20210624081500.11715-1-aleksei.kodanev@bell-sw.com>
Message-ID: <CAEemH2ca=ubrdg=EzjgcDBPBp-jVQ1r7dMSc9TH4KCrctSuN2g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

Good catch.

On Thu, Jun 24, 2021 at 4:15 PM Alexey Kodanev <aleksei.kodanev@bell-sw.com>
wrote:

> TCID can be NULL in tst_tmpdir() because it is set after do_setup():
>
>     tst_run_tcases()
>         do_setup()
>             ...
>             tid = get_tid();
>             ...
>             tst_tmpdir()  /* using TCID here */
>         TCID = tid;
>
> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210624/342af4b5/attachment-0001.htm>
