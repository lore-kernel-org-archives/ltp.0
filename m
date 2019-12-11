From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Dec 2019 13:38:11 +0800
Subject: [LTP] [PATCH] syscalls/ioctl01: Cleanup & convert to new library
In-Reply-To: <20191210140146.GA1124@dell5510>
References: <20191206145517.3415-1-chrubis@suse.cz>
 <20191210140146.GA1124@dell5510>
Message-ID: <CAEemH2d2RLfE0Ki=WOqdAhPNVhJX1h2ZGkr1BhtquV+WdLo8ZA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Dec 10, 2019 at 10:02 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Cyril,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
>
Reviewed-by: Li Wang <liwang@redhat.com>


> BTW (not related to ioctl01.c), is it possible to get rid of (false
> positive) this warning?
>

With -Wno-missing-field-initializers flag in GCC option can disable the
warning. But not sure if we really need to do that.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191211/15369079/attachment.htm>
