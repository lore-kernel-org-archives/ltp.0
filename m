From: Li Wang <liwan@redhat.com>
Date: Mon, 15 Jul 2019 11:01:06 +0800
Subject: [LTP] [PATCH v3.1] lib: add tst_no_corefile()
In-Reply-To: <02ade9af1634c4681156dceecfd51721284044e3.1562591065.git.jstancek@redhat.com>
References: <20190705051603.24599-1-liwang@redhat.com>
 <02ade9af1634c4681156dceecfd51721284044e3.1562591065.git.jstancek@redhat.com>
Message-ID: <CAEemH2dTzdxABL_W4Y-TuZEdUJ+Nag936+1P_kD6NGLQP0otPQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jul 8, 2019 at 9:08 PM Jan Stancek <jstancek@redhat.com> wrote:

> Li,
>
> I'd like to avoid generating TWARN when user has done nothing wrong.
> What would you tell on this version? Only tst_no_corefile()
> is changed compared to your v3.
>

Agree on this, TWARN seems unnecessary. Feel free to modify&push v3.1 as
Cyril suggested.

Thank you, Jan!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190715/f85b4a14/attachment.htm>
