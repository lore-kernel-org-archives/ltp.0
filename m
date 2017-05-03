From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 3 May 2017 08:51:55 -0400 (EDT)
Subject: [LTP] [PATCH] mtest01: fix max_pids formula
In-Reply-To: <20170503124456.GB794@rei.suse.de>
References: <6277f7e6653785a9e5aa89267377fa57df8e6d8f.1493812735.git.jstancek@redhat.com>
 <20170503124456.GB794@rei.suse.de>
Message-ID: <35025738.6528270.1493815915599.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > Values returned by sysinfo() are in multiple of mem_unit bytes.
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/kernel/mem/mtest01/mtest01.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/testcases/kernel/mem/mtest01/mtest01.c
> > b/testcases/kernel/mem/mtest01/mtest01.c
> > index f3fba044c529..6225d7d7b671 100644
> > --- a/testcases/kernel/mem/mtest01/mtest01.c
> > +++ b/testcases/kernel/mem/mtest01/mtest01.c
> > @@ -152,7 +152,8 @@ int main(int argc, char *argv[])
> >  	total_free = sstats.freeram + sstats.freeswap;
> >  	/* Total Free Pre-Test RAM */
> >  	pre_mem = sstats.mem_unit * total_free;
> > -	max_pids = total_ram / (unsigned long)FIVE_HUNDRED_MB + 10;
> > +	max_pids = total_ram * sstats.mem_unit
> > +		/ (unsigned long)FIVE_HUNDRED_MB + 10;
> 
> Looks OK.

Pushed.

Regards,
Jan
