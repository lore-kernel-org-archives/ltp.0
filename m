From: Li Wang <liwang@redhat.com>
Date: Mon, 12 Aug 2019 12:52:44 +0800
Subject: [LTP] [PATCH v2 2/2] clock_getres01: add test variants
In-Reply-To: <e4c5428276c9a85efc6bddaa2d82e2aed5806108.1565361031.git.jstancek@redhat.com>
References: <ee463189a82212a10c1ac06229dc0a418e18305b.1565361031.git.jstancek@redhat.com>
 <e4c5428276c9a85efc6bddaa2d82e2aed5806108.1565361031.git.jstancek@redhat.com>
Message-ID: <CAEemH2dhCdL5uUYxaf9_sYWqf=q+VqgmZofE0AfDm8DuXaO-ng@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Aug 9, 2019 at 10:32 PM Jan Stancek <jstancek@redhat.com> wrote:
>
> 0 - default, could be either VDSO or syscall
> 1 - syscall with valid res parameter
> 2 - syscall with NULL res parameter
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
