From: Daniel Mentz <danielmentz@google.com>
Date: Thu, 7 Feb 2019 16:12:41 -0800
Subject: [LTP] [PATCH] mprotect04: Support execute-only page access
	permissions
In-Reply-To: <444884877.101394412.1549523065054.JavaMail.zimbra@redhat.com>
References: <20190207014055.166152-1-danielmentz@google.com>
 <444884877.101394412.1549523065054.JavaMail.zimbra@redhat.com>
Message-ID: <CAE2F3rBSkosrHixJLVab2mMYmTf+OuG3HbCz_fb0drA3fvMRNQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Feb 6, 2019 at 11:04 PM Jan Stancek <jstancek@redhat.com> wrote:
> > +     /* Mark page readable on platforms that support execute-only page access
> > +      * permissions. */
> > +     if (exec_only_platform)
> > +             mprotect(page_to_copy, page_sz, PROT_READ | PROT_EXEC);
>
> Is there a chance 2nd page will be something else than code?
> E.g. some section that was previously also writeable.

Ok. I can see that concern. We could read /proc/$$/maps to determine
if the 2nd page is writable, but that'd be a lot of work to implement.
What about making the 2nd page writable (PROT_WRITE) just in case? Is
that a solution you would support? Can you think of another solution?
