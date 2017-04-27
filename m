From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 27 Apr 2017 07:21:01 -0400 (EDT)
Subject: [LTP] [PATCH] mmapstress04: rewrite to fix heap overwrite
In-Reply-To: <20170426185549.GC6165@rei.suse.de>
References: <ed1531bad36a25628f7737b9975ed5b4a92922f1.1493201294.git.jstancek@redhat.com>
 <20170426185549.GC6165@rei.suse.de>
Message-ID: <2093543954.3542946.1493292061476.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > +
> > +static void write_fully(int fd, void *buf, int len)
> > +{
> > +	do {
> > +		len -= SAFE_WRITE(0, fd, buf, len);
> 
> Not that this matters here, since the buf is filled with 'a' bytes
> anyway, but we should probably add a offset to the buffer on subsequent
> writes or at least add a comment that we do not care. As it is the code
> looks buggy.

Will fix that.

> 
> > +	} while (len > 0);
> > +}
> > +
> > +static void mmapstress04(void)
> > +{
> > +	int i, j, rofd, rwfd, ret = 0;
> > +	char *buf;
> > +
> > +	if (tst_fill_file(TEST_FILE, 'b', page_size, 1))
> > +		tst_brk(TBROK | TERRNO, "fill_file");
> > +
> > +	rofd = SAFE_OPEN(TEST_FILE, O_RDONLY | O_CREAT, 0777);
> > +	/*
> > +	 * Assuming disk blocks are 8k, and logical pages are 4k, there are
> > +	 * two maps per page. In order to test mapping at the beginning and
>                         ^
> 			block
> > +	 * ends of the block, mapping the whole block, or none of the block
> > +	 * with different mappings on preceding and following blocks, each
> > +	 * 3 blocks with 6 pages can be thought of as a binary number from 0 to
> > +	 * 64 with a bit set for mapped or cleared for unmapped. This number
> > +	 * is represented by i. The value j is used to look at the bits of i
> > +	 * and decided to map the page or not.
> > +	 * NOTE: None of the above assumptions are critical.
> > +	 */
> > +	for (i = 0; i < 64; i++) {
> > +		for (j = 0; j < 6; j++) {
> > +			off_t mapoff;
> > +
> > +			if (!(i & (1 << j)))
> > +				continue;
> > +
> > +			mapoff = page_size * (off_t)(6 + i + j);
>                                                        ^
> 						   Should be '*'?

I took this as-is from original. Will need to have a closed look.

> > +			SAFE_MMAP(mmap_area + page_size * (6 * i + j),
> > +				 page_size, PROT_READ,
> > +				 MAP_FILE | MAP_PRIVATE | MAP_FIXED,
> > +				 rofd, mapoff);
> 
> I wonder if we can just keep a counter for the offset in the mmaped area
> here, something as:
> 
> 			mmapped_pages = 0;
> 
> 			SAFE_MMAP(mmap_area + page_size * mapped_pages++, ...

We can, mmap_area isn't used for anything.

> 
> 
> Then the loop that checks the data could be just a simple for() loop.
> 
> > +		}
> > +	}
> > +	SAFE_CLOSE(rofd);
> > +
> > +	/* write out 6 pages of stuff into each of the 64 six page sections */
> > +	rwfd = SAFE_OPEN(TEST_FILE, O_RDWR);
> > +	buf = SAFE_MALLOC(page_size);
> > +	memset(buf, 'a', page_size);
> > +	for (i = 0; i < 6 * 64; i++)
> > +		write_fully(rwfd, buf, page_size);
> > +	free(buf);
> > +	SAFE_CLOSE(rwfd);
> > +
> > +	/*
> > +	 * Just finished scribbling all over interwoven mmapped and unmapped
> > +	 * regions. Check the data.
> > +	 */
> > +	for (i = 0; i < 64; i++) {
> > +		for (j = 0; j < 6; j++) {
> > +			unsigned char val;
> > +
> > +			if (!(i & (1 << j)))
> > +				continue;
> > +
> > +			val = *(mmap_area + page_size * (6 * i + j));
> > +			if (val != 'a') {
> > +				tst_res(TFAIL, "unexpected value in map, "
> > +					"i=%d,j=%d,val=0x%x", i, j, val);
> > +				ret = 1;
> > +				goto done;
> > +			}
> 
> Maybe we should check whole page, not just first byte.

Yes.

> 
> > +		}
> > +	}
> > +done:
> > +	tst_res(ret ? TFAIL : TPASS, "blocks have expected data");
> 
> This would produce failing message with 'block have expected data' text
> if we get to the goto above. Why isn't the done: label pointing just
> before the SAFE_UNLIK()? It does to make any sense to print the failure
> message twice here.

OK, I'll move label.

Regards,
Jan

> 
> > +	SAFE_UNLINK(TEST_FILE);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.tid = "mmapstress04",
> > +	.needs_tmpdir = 1,
> > +	.test_all = mmapstress04,
> > +	.setup = setup,
> > +};
> > --
> > 1.8.3.1
> > 
> > 
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
