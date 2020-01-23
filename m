From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jan 2020 13:47:11 +0100
Subject: [LTP] [PATCH v2] syscalls/pipe12: add new test for pipe when
 write bytes > PIPE_BUF
In-Reply-To: <90d369da-1340-d919-e9e5-f819d028daf9@cn.fujitsu.com>
References: <1577269768-30118-1-git-send-mail-xuyang2018.jy@cn.fujitsu.com>
 <1578365634-19825-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200110133746.GB14140@rei.lan>
 <90d369da-1340-d919-e9e5-f819d028daf9@cn.fujitsu.com>
Message-ID: <20200123124711.GF27845@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > 		Here as well, write is supposed to return the number of
> > 		bytes written so in this case the TST_RET must be
> > 		max_size - tcase->offset which is all we have to check
> > 		for, anything else than that means failure.
> I have seen pipe_write kernel code[1], it only merged small size write 
> but not large size write(large size write will still page-align size, in 
> other word, it uses new page). So, I think it is why man-pages said 
> "from 1 to n bytes may be written". It may exist a hole when we use a 
> unalign offset and the sequent align-page write. I think it is normal 
> and don't need to mean failure.  "TST_RET is max_size - tcase->offset" 
> is ok when we use [0,N*page_size-1] [page_size,page_buf-1] write or 
> [0,a-1] [a, page_buf-1] write.
> 
> The other reason for it I guess beacause looking for a hole  may drop 
> peformance when pipe buf is large.
> 
> Also, we can print write btyes by ioctl(fd, FIONREAD, &nbytes) command
> (cover this ioctl test point).

Okay, I see that we merge only if the write fits into the free space in
the current head in the right buffer. Which means that we may write less
than max pipe size if we do not write in page aligned chunks.

-- 
Cyril Hrubis
chrubis@suse.cz
