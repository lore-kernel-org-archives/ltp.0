From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Fri, 11 Dec 2020 12:22:52 +0200
Subject: [LTP] [PATCH v1] openposix/fork/7-1.c: A bug fix
In-Reply-To: <750CB65B-8F87-484D-9373-5CE4E1003413@getmailspring.com>
References: <750CB65B-8F87-484D-9373-5CE4E1003413@getmailspring.com>
Message-ID: <88B56050-4D68-4B88-B20D-CA7A0711A398@getmailspring.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

As follow up after chat with Petr Vorel.
A bug in the test was caused by the line "now = localtime(&nw);" in "output" function, as it sets "errno" variable somewhere.
-Bogdan
On Dec 11 2020, at 12:04 pm, Bogdan Lezhepekov <bogdan.lezhepekov@suse.com> wrote:
> Hi,
>
> By adding this comment I wanted to stress that the place of "errno = 0" is not randomly chosen, to prevent somebody from moving it back to the beginning of the file :)
> But if you find it not necessary, then please go ahead.
> Thank you,
> Bogdan
>
> On Dec 11 2020, at 11:54 am, Cyril Hrubis <chrubis@suse.cz> wrote:
> > Hi!
> > > The function output interferes with the variable errno, that leads to
> > > the false positive result on limited test setups. The issue fixed.
> > >
> > > Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
> > > ---
> > > .../open_posix_testsuite/conformance/interfaces/fork/7-1.c | 4 +++-
> > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
> > > index c3db90c00..4249d713d 100644
> > > --- a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
> > > +++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
> > > @@ -53,12 +53,14 @@ static void read_catalog(nl_catd cat, char *who)
> > > {
> > > char *msg = NULL;
> > > int i, j;
> > > - errno = 0;
> > >
> > > #if VERBOSE > 0
> > > output("Reading the message catalog from %s...\n", who);
> > > #endif
> > >
> > > + /* the output function interferes with errno */
> > > + errno = 0;
> > > +
> > > for (i = 1; i <= 2; i++) {
> > > for (j = 1; j <= 2; j++) {
> >
> > This is obviously correct, but I would avoid adding the comment, it's
> > kind of obvious that anything that calls to libc may and will interfere
> > with errno.
> >
> > Also the first line of the commit description could be a bit more
> > description, half of the commits pushed to LTP are bugfixes. So maybe
> > something as:
> >
> > openposix/fork/7-1.c: Clear errno correctly
> > ...
> > I can push the patch with these changes if it's okay with you.
> >
> > --
> > Cyril Hrubis
> > chrubis@suse.cz
> >
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201211/a140569e/attachment.htm>
