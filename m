From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Jul 2019 11:14:10 +0800
Subject: [LTP] [PATCH] ustat02: Fix EFAULT in 32bit compatibility mode
In-Reply-To: <CAEemH2fv0AXXVKDNWgATCdS2WKufV1YPDsKHhPBZbk1Dxv77LQ@mail.gmail.com>
References: <20190719124817.5140-1-steven.price@arm.com>
 <CAEemH2fv0AXXVKDNWgATCdS2WKufV1YPDsKHhPBZbk1Dxv77LQ@mail.gmail.com>
Message-ID: <CAEemH2d9Jx5G-fF469Ue=cyhpttAEw-u62R-4Nr7Lqva2Fpe3Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jul 22, 2019 at 5:55 PM Li Wang <liwang@redhat.com> wrote:
>
> On Fri, Jul 19, 2019 at 11:19 PM Steven Price <steven.price@arm.com> wrote:
> >
> > The size of dev_t is larger than 32 bits which causes the dev argument
> > to be passed incorrectly. On Arm this means that the EFAULT test case
> > actually returns EINVAL because the device number isn't recognised.
> >
> > Signed-off-by: Steven Price <steven.price@arm.com>
> Acked-by: Li Wang <liwang@redhat.com>

Pushed.

-- 
Regards,
Li Wang
