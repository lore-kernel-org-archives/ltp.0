From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 20 Apr 2021 18:57:18 +0200
Subject: [LTP] [PATCH v5 1/2] splice02: Generate input in C
In-Reply-To: <YH6c/cm9uY0QRrbu@yuki>
References: <20210420084410.16179-1-pvorel@suse.cz>
 <YH6c/cm9uY0QRrbu@yuki>
Message-ID: <YH8H7gnu9FYziyGG@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> >  	SAFE_CLOSE(fd);
> > +	fd = SAFE_OPEN(TEST_FILENAME, O_RDONLY);
> > +	to_check = st.st_size;
> > +
> > +	psize = sysconf(_SC_PAGESIZE);
> > +
> > +	tst_res(TINFO, "checking file content");
> > +	do {
> > +		i = 0;
> > +		size = to_check > psize ? psize : to_check;
> > +
> > +		map = SAFE_MMAP(NULL, size, PROT_READ, MAP_PRIVATE, fd,
> > +				st.st_size - to_check);

> Huh, why do we loop backward over the file?

> Maybe we can just do simple loop here that would be easier to
> understand:

> 	blocks = LTP_ALIGN(st.st_size, page_size) / page_size;

> 	for (block = 0; block < blocks; block++) {
> 		map = SAFE_MMAP(NULL, pagesize, PROT_READ, MAP_PRIVATE, fd, block * pagesize);

> 		to_check = (block+1) * page_size < st.st_size ? page_size : st.st_size % page_size;

> 		for (i = 0; i < to_check; i++) {
> 			if (map[i] != get_letter(block * page_size + i))
> 				fail++;
> 		}

> 		SAFE_MUNMAP(map, size);
> 	}

> [Beware I haven't tested the code :-)]
Yep. In your code you expect that written letter change each time.
But original code writes the same letter for whole buffer (using memset()).

I guess it does not matter whether I keep writing with memset() as is
and adapt the checking code (code you proposed) or if I use your code for
checking and adapt writing code: create buffer 494 (19x 26 letters), memset() it
only once. Or do you have any preference of these?

Also I have to replace 2x return with goto cleanup (to close fd and exit the child).

Kind regards,
Petr
