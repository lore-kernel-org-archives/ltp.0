From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Jul 2019 17:55:03 +0800
Subject: [LTP] [PATCH] ustat02: Fix EFAULT in 32bit compatibility mode
In-Reply-To: <20190719124817.5140-1-steven.price@arm.com>
References: <20190719124817.5140-1-steven.price@arm.com>
Message-ID: <CAEemH2fv0AXXVKDNWgATCdS2WKufV1YPDsKHhPBZbk1Dxv77LQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 19, 2019 at 11:19 PM Steven Price <steven.price@arm.com> wrote:
>
> The size of dev_t is larger than 32 bits which causes the dev argument
> to be passed incorrectly. On Arm this means that the EFAULT test case
> actually returns EINVAL because the device number isn't recognised.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
Acked-by: Li Wang <liwang@redhat.com>

Thanks for the fix, this patch works for me,

-- 
Regards,
Li Wang
