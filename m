From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Apr 2021 11:21:01 +0200
Subject: [LTP] [PATCH v5 1/2] splice02: Generate input in C
In-Reply-To: <20210420084410.16179-1-pvorel@suse.cz>
References: <20210420084410.16179-1-pvorel@suse.cz>
Message-ID: <YH6c/cm9uY0QRrbu@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	SAFE_CLOSE(fd);
> +	fd = SAFE_OPEN(TEST_FILENAME, O_RDONLY);
> +	to_check = st.st_size;
> +
> +	psize = sysconf(_SC_PAGESIZE);
> +
> +	tst_res(TINFO, "checking file content");
> +	do {
> +		i = 0;
> +		size = to_check > psize ? psize : to_check;
> +
> +		map = SAFE_MMAP(NULL, size, PROT_READ, MAP_PRIVATE, fd,
> +				st.st_size - to_check);

Huh, why do we loop backward over the file?

Maybe we can just do simple loop here that would be easier to
understand:

	blocks = LTP_ALIGN(st.st_size, page_size) / page_size;

	for (block = 0; block < blocks; block++) {
		map = SAFE_MMAP(NULL, pagesize, PROT_READ, MAP_PRIVATE, fd, block * pagesize);

		to_check = (block+1) * page_size < st.st_size ? page_size : st.st_size % page_size;

		for (i = 0; i < to_check; i++) {
			if (map[i] != get_letter(block * page_size + i))
				fail++;
		}

		SAFE_MUNMAP(map, size);
	}

[Beware I haven't tested the code :-)]

-- 
Cyril Hrubis
chrubis@suse.cz
