From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Jul 2016 02:56:42 -0400 (EDT)
Subject: [LTP] [PATCH] madvise06: wait a bit after madvise() call
In-Reply-To: <20160719055844.GA31704@gmail.com>
References: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
 <20160719055844.GA31704@gmail.com>
Message-ID: <1822250385.6269456.1468911402613.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 19 July, 2016 7:58:44 AM
> Subject: Re: [PATCH] madvise06: wait a bit after madvise() call
> 
> Hi Jan,
> 
> On Mon, Jul 18, 2016 at 03:37:08PM +0200, Jan Stancek wrote:
> > 
> > Some other obsverations that are not addressed by this patch:
> >  Testcase assumes that swap is enabled.
> >  Testcase assumes that there is enough swap.
> >  Testcase doesn't check buf[0] is swapped before it calls madvise().
> 
> It's easy to check swap enabled, but hard to verify one page is swapped. :(

https://www.kernel.org/doc/Documentation/vm/pagemap.txt

> 
> > 
> > diff --git a/testcases/kernel/syscalls/madvise/madvise06.c
> > b/testcases/kernel/syscalls/madvise/madvise06.c
> > index 6b081fddf5eb..1b0f58cb319d 100644
> > --- a/testcases/kernel/syscalls/madvise/madvise06.c
> > +++ b/testcases/kernel/syscalls/madvise/madvise06.c
> > @@ -77,6 +77,7 @@ static void test_advice_willneed(void)
> >  	char *dst[100];
> >  	int page_fault_num_1;
> >  	int page_fault_num_2;
> > +	const int pages_to_check = 50;
> >  
> >  	/* allocate source memory (1gb only) */
> >  	src = safe_mmap(null, 1 * gb_sz, prot_read | prot_write,
> > @@ -97,18 +98,23 @@ static void test_advice_willneed(void)
> >  	tst_res(tinfo, "pagefault(no madvice): %d", get_page_fault_num());
> >  
> >  	/* Do madvice() to dst[0] */
> > -	TEST(madvise(dst[0], pg_sz, MADV_WILLNEED));
> > +	TEST(madvise(dst[0], pages_to_check * pg_sz, MADV_WILLNEED));
> >  	if (TEST_RETURN == -1)
> >  		tst_brk(TBROK | TERRNO, "madvise failed");
> >  
> > -	page_fault_num_1 = get_page_fault_num();
> > -	tst_res(TINFO, "PageFault(madvice / no mem access): %d",
> > -			page_fault_num_1);
> > -
> > -	*dst[0] = 'a';
> > -	page_fault_num_2 = get_page_fault_num();
> > -	tst_res(TINFO, "PageFault(madvice / mem access): %d",
> > -			page_fault_num_2);
> 
> 8<---------snip----------------
> > +	i = 0;
> > +	do {
> > +		i++;
> > +		usleep(100000);
> > +
> > +		page_fault_num_1 = get_page_fault_num();
> > +		tst_res(TINFO, "PageFault(madvice / no mem access): %d",
> > +				page_fault_num_1);
> > +		dst[0][i * pg_sz] = 'a';
> > +		page_fault_num_2 = get_page_fault_num();
> > +		tst_res(TINFO, "PageFault(madvice / mem access): %d",
> > +				page_fault_num_2);
> > +	} while (page_fault_num_1 != page_fault_num_2 && i < pages_to_check);
> 8<-------------------------------
> 
> Agree! this method could aviod a wrong diagnosis.
> 
> But one question is that why involved the 'pages_to_check' as a constant?
> why not changes like this:
> 
> int pages_to_check = 50;

Sure, we can do that and save one variable.

> ...
> 
> while (pages_to_check > 0 && pages_to_check--) {
> 	page_fault_num_1 = get_page_fault_num();
> 	tst_res(TINFO, "PageFault(madvice / no mem access): %d",
> 			page_fault_num_1);
> 	dst[0][pages_to_check * pg_sz]  =  'a';
> 	page_fault_num_2 = get_page_fault_num();
> 	tst_res(TINFO, "PageFault(madvice / mem access): %d",
> 			page_fault_num_2);
> 
> 	if(page_fault_num_1 == page_fault_num_2)
> 		break;
> 
> 	usleep(100000);
> }
> 
> 
> One more word, there(above two changes) still only one chance to verify
> page fault numbers equality, because if "page_fault_num_1 !=
> page_fault_num_2"

Why "one chance"? With above we should get 50 chances.

> it will keep looping until get the last page be checked. so that a bad
> situation, it will usleep(100000) * 50 at most.
> 
> In other words, the last page determines the test result though the bug
> has been detected by previous pages.

Problem is we don't know if it's a bug, pending I/O (after short delay)
or kernel ignoring request for any other reason, as mentioned in madvise(2):
"The kernel is free to ignore the advice.".

My impression was that kernel bug was consistently reproducible,
if not then let's replace the loop with one bigger sleep.

Regards,
Jan
