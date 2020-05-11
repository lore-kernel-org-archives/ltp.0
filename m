From: Li Wang <liwang@redhat.com>
Date: Mon, 11 May 2020 14:33:57 +0800
Subject: [LTP] [PATCH] nm01: fix regex matching internal symbols
In-Reply-To: <20200510082151.GA13961@x230>
References: <797dd5eeadd81fae30635dd66d0a715cc213c51e.1588942651.git.jstancek@redhat.com>
 <20200510082151.GA13961@x230>
Message-ID: <CAEemH2dj0mGsxfWkVzLZDPftiQiiAMbJ03S_uhvL6VBduiRShA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun, May 10, 2020 at 4:22 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Current regex matches any word character followed by space
> > and one of letters "abdft". So it doesn't match only symbol type,
> > but can match for example value and size:
> >   $ grep "\w [a,b,d,f,t]" nm.out
> >   __libc_csu_init T 10000640 b4
> >                    matches ^ ^
>
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Good catch, Jan.
>

Tested and pushed.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200511/d55a97d0/attachment.htm>
