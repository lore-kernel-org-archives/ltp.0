From: Li Wang <liwang@redhat.com>
Date: Thu, 12 Nov 2015 18:21:30 +0800
Subject: [LTP] [PATCH v3] signal: add new testcase signal06.c
In-Reply-To: <992794806.7293527.1447318323591.JavaMail.zimbra@redhat.com>
References: <1447247625-4941-1-git-send-email-liwang@redhat.com>
 <992794806.7293527.1447318323591.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2fYGnT1M=eLNq=hJBq3ayfSw-zstpkUaPB=M1RCEeu+Vw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Thu, Nov 12, 2015 at 4:52 PM, Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > From: "Li Wang" <liwang@redhat.com>
> > To: jstancek@redhat.com
> > Cc: ltp@lists.linux.it
> > Sent: Wednesday, 11 November, 2015 2:13:45 PM
> > Subject: [PATCH v3] signal: add new testcase signal06.c
> >
> > v2 --> v3
> >       1. add filename to .gitignore
> >  6 files changed, 175 insertions(+)
> >  create mode 100644 testcases/kernel/syscalls/signal/signal06.c
>
> Pushed with changes described below.
>
> Regards,
> Jan
>
> > +
> > +void *tfunc(void *arg LTP_ATTRIBUTE_UNUSED)
> > +{
> > +     FLAGE = 0;
>
> ^^ I moved this below to main loop, because you can get into situation,
> where test()
> completes before tfunc() and then test just hangs (spins in tfunc()
> forever)
>

yes, I was not aware of that.  it is necessary to move it.


>
> > +
> > +     for (; ;) {
> > +             TEST(mprotect(altstack, sizeof(altstack), PROT_READ));
> > +             if (TEST_RETURN == -1)
> > +                     tst_brkm(TBROK | TRERRNO, NULL, "mprotect failed");
>
> TRERRNO makes sense only for APIs like pthread_, which don't store
> error code to errno, but return it directly.
>
> #define TERRNO  0x100   /* Append errno information to output */
> #define TTERRNO 0x200   /* Append TEST_ERRNO information to output */
> #define TRERRNO 0x400   /* Capture errno information from TEST_RETURN to
>                            output;
>
>
Aha, got it.  thanks very much!


-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151112/873779dc/attachment.html>
