From: Li Wang <liwang@redhat.com>
Date: Mon, 29 Jul 2019 17:47:37 +0800
Subject: [LTP] [PATCH v2] syscalls/timer_create: Add test for
 CVE-2017-18344
In-Reply-To: <20190726083701.9682-1-camann@suse.com>
References: <20190726083701.9682-1-camann@suse.com>
Message-ID: <CAEemH2caYaXAhHBR8UWHz7v-5kZdCO1mtK1pBrDOBBQHP-Zo4Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 26, 2019 at 4:37 PM Christian Amann <camann@suse.com> wrote:
>
> In kernels prior to 4.14.8 (missing commit cef31d9af908)
> the sigevent.sigev_notify field is not properly checked
> when creating a timer using timer_create(2).
> This can be used to read arbitrary kernel memory.
>
> Signed-off-by: Christian Amann <camann@suse.com>

Acked-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang
