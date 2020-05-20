From: Li Wang <liwang@redhat.com>
Date: Wed, 20 May 2020 13:43:31 +0800
Subject: [LTP] [PATCH] ptrace01: Fix missing format string
In-Reply-To: <20200520052318.3261805-1-raj.khem@gmail.com>
References: <20200520052318.3261805-1-raj.khem@gmail.com>
Message-ID: <CAEemH2dt1NzeOmCogzw3YA2pT07tRN-VjRn1eaHJuYuyWudaKw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 20, 2020 at 1:23 PM Khem Raj <raj.khem@gmail.com> wrote:

> Fixes
> | ptrace01.c:89:2: error: format string is not a string literal
> (potentially insecure) [-Werror,-Wformat-security]
> |         tst_res(TINFO, tc->message);
> |         ^              ~~~~~~~~~~~
>
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
>

Pushed.


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200520/12284054/attachment.htm>
