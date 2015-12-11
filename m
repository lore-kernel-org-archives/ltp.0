From: Eryu Guan <eguan@redhat.com>
Date: Fri, 11 Dec 2015 21:19:04 +0800
Subject: [LTP] [PATCH] syscalls: avoid creating whiteout device in tests
In-Reply-To: <420858404.27107103.1449838855503.JavaMail.zimbra@redhat.com>
References: <1449747502-29612-1-git-send-email-eguan@redhat.com>
 <420858404.27107103.1449838855503.JavaMail.zimbra@redhat.com>
Message-ID: <20151211131904.GW2535@eguan.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Dec 11, 2015 at 08:00:55AM -0500, Jan Stancek wrote:
> 
> 
> 
> 
> ----- Original Message -----
> > From: "Eryu Guan" <eguan@redhat.com>
> > To: ltp@lists.linux.it
> > Sent: Thursday, 10 December, 2015 12:38:22 PM
> > Subject: [LTP] [PATCH] syscalls: avoid creating whiteout device in tests
> > 
> > A char device with major 0 and minor 0 is known as whiteout device, and
> > overlayfs refuses to create such device. mknod01 and mount02 fail on
> > overlayfs because of this restriction.
> > 
> > Fix it by creating null device instead.
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> 
> Hi,
> 
> > ---
> >  testcases/kernel/syscalls/mknod/mknod01.c | 17 +++++++++++++----
> >  testcases/kernel/syscalls/mount/mount02.c |  8 ++++++--
> >  2 files changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/mknod/mknod01.c
> > b/testcases/kernel/syscalls/mknod/mknod01.c
> > index 863d02d..a35adf9 100644
> > --- a/testcases/kernel/syscalls/mknod/mknod01.c
> > +++ b/testcases/kernel/syscalls/mknod/mknod01.c
> > @@ -66,6 +66,7 @@ int TST_TOTAL = ARRAY_SIZE(tcases);
> >  int main(int ac, char **av)
> >  {
> >  	int lc, i;
> > +	dev_t dev;
> >  
> >  	tst_parse_opts(ac, av, NULL, NULL);
> >  
> > @@ -75,17 +76,25 @@ int main(int ac, char **av)
> >  		tst_count = 0;
> >  
> >  		for (i = 0; i < TST_TOTAL; i++) {
> > +			/*
> > +			 * overlayfs doesn't support mknod char device with
> > +			 * major 0 and minor 0, which is known as whiteout_dev
> > +			 */
> > +			if (S_ISCHR(tcases[i]))
> > +				dev = makedev(1, 3);
> > +			else
> > +				dev = 0;
> >  			TEST(mknod(PATH, tcases[i], 0));
> 
> Did you mean to use "dev" variable here? ----------^^^

Thanks for the review! Yes, it should be "dev", will send v2 shortly. (I
should generate patch on my test machine, where I test the code, not on
my laptop..)

Thanks,
Eryu
