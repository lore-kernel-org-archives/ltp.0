From: Eryu Guan <eguan@redhat.com>
Date: Wed, 4 May 2016 11:26:54 +0800
Subject: [LTP] [PATCH 1/2] ltp-aiodio: sleep less time when waiting for
 target file creation
In-Reply-To: <20160503130909.GA7571@rei.lan>
References: <1462268030-21958-1-git-send-email-eguan@redhat.com>
 <20160503130909.GA7571@rei.lan>
Message-ID: <20160504032654.GA5140@eguan.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 03, 2016 at 03:09:09PM +0200, Cyril Hrubis wrote:
> Hi!
> > dio_sparse calls read_sparse() to check the content of sparse file,
> > which is direct written by another process. It waits for the file to be
> > existent in a loop and sleeps 0.1s in each loop if the file isn't there
> > yet.
> > 
> > But the sleep time is too long, if the target file doesn't exist in the
> > first loop, the reading process might never read the file before it gets
> > killed. e.g. Running ADSP045 on extN I got:
> > 
> > dio_sparse    0  TINFO  :  Dirtying free blocks
> > dio_sparse    0  TINFO  :  Starting I/O tests
> > Child 4554 waits for 'dio_sparse' to appear
> > dio_sparse    0  TINFO  :  Killing childrens(s)
> > dio_sparse    1  TPASS  :  Test passed)
> > 
> > The child for reading got killed before it read anything.
> > 
> > So shorten the sleep time, give the child a chance to read the file and
> > really do the test.
> > 
> > dio_sparse    0  TINFO  :  Dirtying free blocks
> > dio_sparse    0  TINFO  :  Starting I/O tests
> > Child 4767 waits for 'dio_sparse' to appear
> > Child 4767 has opened 'dio_sparse' for reading
> > Child 4767 loop 0
> > Child 4767 loop 1
> > dio_sparse    0  TINFO  :  Killing childrens(s)
> > dio_sparse    1  TPASS  :  Test passed)
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> >  testcases/kernel/io/ltp-aiodio/common_sparse.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/testcases/kernel/io/ltp-aiodio/common_sparse.h b/testcases/kernel/io/ltp-aiodio/common_sparse.h
> > index f7f4ef4..a7f5035 100644
> > --- a/testcases/kernel/io/ltp-aiodio/common_sparse.h
> > +++ b/testcases/kernel/io/ltp-aiodio/common_sparse.h
> > @@ -123,7 +123,7 @@ static void read_sparse(char *filename, int filesize)
> >  			fprintf(stderr, "Child %i waits for '%s' to appear\n",
> >  			        getpid(), filename);
> >  
> > -		usleep(100000);
> > +		usleep(10);
> 
> This is just another band aid instead of fixing the real problem. Why
> don't we use real synchronization instead?

You're right, fixing the synchronization is the right way to go, I'll
think more and test more about it, thanks!

Eryu
> 
> What about we do:
> 
> * Remove the loops that kills children from the parent
> * Limit the number of iterations in read_sparse to something
>   more reasonable, i.e. 10 or so
> 
> That way the parent would actually wait for the children to read the
> file in the loop that does wait().
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
