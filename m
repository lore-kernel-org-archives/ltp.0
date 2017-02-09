From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Feb 2017 10:31:52 +0100
Subject: [LTP] [PATCH 1/2] ltp-aiodio/dio_sparse: Fix write in
 dio_sparse()
In-Reply-To: <589C2EA5.6040707@cn.fujitsu.com>
References: <1484818349-30539-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20170124134057.GC29054@rei.lan> <58882AA5.90906@cn.fujitsu.com>
 <589C2EA5.6040707@cn.fujitsu.com>
Message-ID: <20170209093152.GA12673@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >>>  	memset(bufptr, 0, writesize);
> >>>  	lseek(fd, offset, SEEK_SET);
> >>> -	for (i = offset; i < filesize;) {
> >>> +	for (i = 0; i < filesize;) {
> >>>  		if ((w = write(fd, bufptr, writesize)) != writesize) {
> >>>  			tst_resm(TBROK | TERRNO, "write() returned %d", w);
> >>>  			close(fd);
> >>
> >> Hmm, it looks to me like the code actually does what it should have.
> >> Since we pass a filesize and offset so the test should actually write
> >> filesize - offset bytes. As far as I can tell the bug here is that the
> >> test is not checking that filesize > offset before it starts.
> > 
> > Sorry, but shouldn't we write the whole "writesize" from the "offset"?
> > ADSP080 ADSP081 ADSP082 ADSP083 did reproduce the BUG via above modification...
> 
> I think we pass an "offset" is to make sure writing from the file offset,
> but the actual write size should be just the "writesize" argument.
> 
> As the second case of kernel commit 9ecd10b says:
>     2. Direct writes starting from or beyong i_size (not inside i_size)
>        also could trigger block allocation and expose stale data.  For
>        example, consider a sparse file with i_size of 2k, and a write to
>        offset 2k or 3k into the file, with a filesystem block size of 4k.
>        (Thanks to Jeff Moyer for pointing this case out in his review.)

Ah, looking at the git log, the offset was just added recently, that's
why the code is confusing, previously the filesize was size of the
file...

So what about we rename the writesize to blocksize and filesize to
writesize so that it's clear what the function dio_sparse does.

int dio_sparse(char *filename, int align, int blocksize, int writesize, int offset)

Also shouldn't we truncate the file to offset + filesize rather than
just filesize? And then pass the size to the children as offset +
filesize as well?

-- 
Cyril Hrubis
chrubis@suse.cz
