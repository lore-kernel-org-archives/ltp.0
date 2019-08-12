From: Li Wang <liwang@redhat.com>
Date: Mon, 12 Aug 2019 12:52:29 +0800
Subject: [LTP] [PATCH v2 1/2] clock_getres01: drop case which is passing
 NULL res parameter
In-Reply-To: <ee463189a82212a10c1ac06229dc0a418e18305b.1565361031.git.jstancek@redhat.com>
References: <ee463189a82212a10c1ac06229dc0a418e18305b.1565361031.git.jstancek@redhat.com>
Message-ID: <CAEemH2edRKv02Hu=LzBe06Op=NCnYpweJKQNxJ4pxoN4cp8iPw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Aug 9, 2019 at 10:32 PM Jan Stancek <jstancek@redhat.com> wrote:
>
> Since commit a9446a906f52 ("lib/vdso/32: Remove inconsistent NULL pointer checks")
> VDSO treats NULL parameter differently than in syscall.
>
> Drop NULL parameter, subsequent patch will add test variants that test NULL
> res parameter using syscall.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
