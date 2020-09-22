From: Li Wang <liwang@redhat.com>
Date: Tue, 22 Sep 2020 14:36:43 +0800
Subject: [LTP] [PATCH v6] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <20200921094714.GA2311@yuki.lan>
References: <20200918171710.19227-1-chrubis@suse.cz>
 <CAEemH2d_m16MhGrjxWHCeQ0BU9Fa562TVjaa+C_ecnPYhCfthw@mail.gmail.com>
 <20200921094714.GA2311@yuki.lan>
Message-ID: <CAEemH2f+yqe2rtNh34fkWiLtVrp=hP70qzNX1HbVt13oyoNzXQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Sep 21, 2020 at 5:46 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> ...
> > As the stack grows down, shouldn't grow from stack_bottom to stack_top?
> > which
> > means stack_bottom = start + reserved_size.
>
> That depends on the definition of top and bottom. For me it makes sense
> that the the stack grows from top to the bottom because it grows down,
> which is consistent with the MAP_GROWSDOWN flag.
>

Ok, it sounds we have different comprehension of the MAP_GROWSDOWN flag.
As I thought the flag takes effect on an area of memory and then we regard
the
region as a stack, so I said it grows from the bottom. But if we think a
stack grows
down, then the definition is reverted here.

As this is a gray zone as you said, so I don't want to stick to my own
opinion.

Reviewed-by: Li Wang <liwang@redhat.com>


>
> Also this is really the reason why I added the ASCII art to the top
> level comment of the test in order to make clear how these terms are
> used in the code.


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200922/affc4958/attachment.htm>
