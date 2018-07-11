From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 11 Jul 2018 03:28:41 -0400 (EDT)
Subject: [LTP] [PATCH] open08: calling tst_get_bad_addr from LTP API
In-Reply-To: <CAEemH2fOxm=CCNnfi_+POsFqapX_LY4siRA=+7OEiDJtVCSXxg@mail.gmail.com>
References: <20180711051645.5075-1-liwang@redhat.com>
 <CAEemH2fOxm=CCNnfi_+POsFqapX_LY4siRA=+7OEiDJtVCSXxg@mail.gmail.com>
Message-ID: <1988800005.31820575.1531294121616.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Maybe we misled by the code comments before, after thinking over, I
> guess the "outside your accessible address space" != "outside of
> process mapped space". So we don't need to do map/unmap to satisfy
> that.

That may be the case, I changed it on purpose to match that comment.
Though as you pointed out PROT_NONE might be enough too.

Is the motivation for your patch to re-use existing function
or have you hit some problem with map/unmap?

Regards,
Jan
