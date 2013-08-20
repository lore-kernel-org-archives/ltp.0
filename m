Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1VBfWl-0005p0-LS
	for ltp-list@lists.sourceforge.net; Tue, 20 Aug 2013 06:34:51 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VBfWj-0000f5-Oa
	for ltp-list@lists.sourceforge.net; Tue, 20 Aug 2013 06:34:51 +0000
Date: Tue, 20 Aug 2013 02:34:39 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1004207590.1053823.1376980479030.JavaMail.root@redhat.com>
In-Reply-To: <5212DEC5.4050506@cn.fujitsu.com>
References: <b02ceb0270268de40055e69232d12c3a3422f7f4.1376919310.git.jstancek@redhat.com>
	<5212DEC5.4050506@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH/RFC] aiodio: make read_sparse use same mode as
 writers
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 20 August, 2013 5:13:09 AM
> Subject: Re: [LTP] [PATCH/RFC] aiodio: make read_sparse use same mode as writers
> 
> On 08/19/2013 09:38 PM, Jan Stancek wrote:
> > Starting with 3.10 dio_sparse sporadically fails, because
> > read() in read_sparse returns garbage and dio_sparse testcase
> > fails with:
> >   dio_sparse    0  TINFO  :  Dirtying free blocks
> >   dio_sparse    0  TINFO  :  Starting I/O tests
> >   non zero buffer at buf[0] => 0xffffffaa,ffffffaa,ffffffaa,ffffffaa
> >   non-zero read at offset 0
> >   dio_sparse    0  TINFO  :  Killing childrens(s)
> >   dio_sparse    1  TFAIL  :  1 children(s) exited abnormally
> 
> Why did I always meet the EINVAL error?
> Like:
> dio_sparse    1  TBROK  :  open(): errno=EINVAL(22): Invalid argument
> 
> Caused by the file system's O_DIRECT support?

It's possible, I know you'll get EINVAL if your tmp directory is tmpfs.
Can you try to run it with "env TMPDIR=/root" and see if
that makes difference?

Regards,
Jan

> 
> Thanks,
> Wanlong Gao
> 
> > 
> > Issue is that we have parent opening file as O_DIRECT and
> > children trying to read from it without O_DIRECT, which is
> > discouraged in man pages.
> > 
> > open(2) says:
> > "Applications should avoid mixing O_DIRECT and normal I/O to the same
> > file, and especially to overlapping byte regions in the same file."
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/kernel/io/ltp-aiodio/aiodio_sparse.c |    2 +-
> >  testcases/kernel/io/ltp-aiodio/common_sparse.h |    4 ++--
> >  testcases/kernel/io/ltp-aiodio/dio_sparse.c    |    2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
> > b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
> > index 944e12b..705bbc5 100644
> > --- a/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
> > +++ b/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
> > @@ -279,7 +279,7 @@ int main(int argc, char **argv)
> >  	for (i = 0; i < num_children; i++) {
> >  		switch (pid[i] = fork()) {
> >  		case 0:
> > -			read_sparse(filename, filesize);
> > +			read_sparse(filename, filesize, O_DIRECT);
> >  			break;
> >  		case -1:
> >  			while (i-- > 0)
> > diff --git a/testcases/kernel/io/ltp-aiodio/common_sparse.h
> > b/testcases/kernel/io/ltp-aiodio/common_sparse.h
> > index f7f4ef4..6a294cb 100644
> > --- a/testcases/kernel/io/ltp-aiodio/common_sparse.h
> > +++ b/testcases/kernel/io/ltp-aiodio/common_sparse.h
> > @@ -104,7 +104,7 @@ char *check_zero(char *buf, int size)
> >   * either there is a hole in the file,
> >   * or zeroes were actually written by parent.
> >   */
> > -static void read_sparse(char *filename, int filesize)
> > +static void read_sparse(char *filename, int filesize, int mode)
> >  {
> >  	int fd;
> >  	int  i, j, r;
> > @@ -114,7 +114,7 @@ static void read_sparse(char *filename, int filesize)
> >  	 * Wait for the file to appear.
> >  	 */
> >  	for (i = 0; i < 10000; i++) {
> > -		fd = open(filename, O_RDONLY);
> > +		fd = open(filename, O_RDONLY | mode);
> >  
> >  		if (fd != -1)
> >  			break;
> > diff --git a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> > b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> > index 7ad5f80..eaaea14 100644
> > --- a/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> > +++ b/testcases/kernel/io/ltp-aiodio/dio_sparse.c
> > @@ -153,7 +153,7 @@ int main(int argc, char **argv)
> >  	for (i = 0; i < num_children; i++) {
> >  		switch (pid[i] = fork()) {
> >  		case 0:
> > -			read_sparse(filename, filesize);
> > +			read_sparse(filename, filesize, O_DIRECT);
> >  			break;
> >  		case -1:
> >  			while (i-- > 0)
> > 
> 
> 

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
