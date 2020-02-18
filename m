From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Feb 2020 14:06:50 +0800
Subject: [LTP] [PATCH v4 1/2] lib: add .request_hugepages to reserve
 hugepage
In-Reply-To: <20200217160830.GA6482@dell5510>
References: <20200208092014.24824-1-liwang@redhat.com>
 <20200217160830.GA6482@dell5510>
Message-ID: <CAEemH2d6byWZ7_LxKqA0VUO93wiRTL0w5JMsq0-4Tb_RcHXgVw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Tue, Feb 18, 2020 at 12:08 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Code looks good.
>
Thanks!


> Minor issue: doc has broken formatting.
> ...
> > +'tst_hugepages' will be set to 0.
>
> I propose these changes (+ strip this formatting from comments in C source
> - include/tst_test.h).
>

Thanks for this advice, I have done modifications in my local commit.

Before pushing I would give a bit more time to Cyril for a review, in case
he has additional suggestions.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200218/7b4bfd7b/attachment.htm>
