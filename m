From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Apr 2021 14:32:40 +0200
Subject: [LTP] [PATCH v3 1/2] splice02: Generate input in C
In-Reply-To: <YHhNQSCotEieKcnx@pevik>
References: <20210413043844.5612-1-pvorel@suse.cz> <YHhDurTlljhXAKL9@yuki>
 <YHhJdwbeUCz5sDfK@pevik> <YHhNQSCotEieKcnx@pevik>
Message-ID: <YHmD6Efvn/f6Eh+G@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > LGTM, going to merge it with these changes (+ cleanup to_write)
> > and your Reviewed-by: tags.
> > Thanks a lot!
> 
> Maybe one more change: INT_MAX is a bit too much, it timeouts.
> I'll use 262144 as max allowed -n (the default on intel - 2x max pipe size).

I guess that the main problem here is that we write one character at a
time, which means that we spend most of the time in syscall handler code
rather than copying the data. It may work much better if we change the
code to write 512 bytes at a time. I.e. something as:

	#define BUFSIZE 512

	char buf[BUFSIZE];

	memset(buf, 'a', BUFSIZE);

	while (to_write > 0) {
		size_t size = to_write > BUFSIZE ? BUFSIZE : to_write;

		...

		to_write -= written;
	}

-- 
Cyril Hrubis
chrubis@suse.cz
