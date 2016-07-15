From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Jul 2016 07:22:00 -0400 (EDT)
Subject: [LTP] [PATCH v3 1/3] ltp-aiodio: report posix_memalign
	errors	properly
In-Reply-To: <1468414742-29413-1-git-send-email-eguan@redhat.com>
References: <1468414742-29413-1-git-send-email-eguan@redhat.com>
Message-ID: <547690085.5234079.1468581720944.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Eryu Guan" <eguan@redhat.com>
> To: ltp@lists.linux.it
> Sent: Wednesday, 13 July, 2016 2:59:00 PM
> Subject: [LTP] [PATCH v3 1/3] ltp-aiodio: report posix_memalign errors	properly
> 
> From posix_memalign(3) the value of errno is indeterminate after a call
> to posix_memalign(). So TERRNO doesn't work in this case.
> dio_sparse    1  TBROK  :  dio_sparse.c:75: posix_memalign():
> errno=SUCCESS(0): Success
> 
> Report posix_memalign() errors by calling strerror on the return value.
> dio_sparse    1  TBROK  :  dio_sparse.c:74: posix_memalign(): EINVAL
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Series pushed. I tested it on 4.7.0-rc7 (which contains your patch),
it completed OK. New cases are very fast, it added just couple ms on
my KVM guest.

Regards,
Jan
