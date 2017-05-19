From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 May 2017 16:38:02 +0200
Subject: [LTP] [PATCH v4 1/2] syscalls/splice04: add test for splice()
 from pipe to pipe
In-Reply-To: <20170519142542.GD17258@rei.lan>
References: <1494580475-3522-1-git-send-email-bxue@redhat.com>
 <20170519142542.GD17258@rei.lan>
Message-ID: <20170519143801.GF17258@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +	SAFE_PIPE(pp1);
> > +	SAFE_PIPE(pp2);
> > +	SAFE_WRITE(1, pp1[1], arr_in, num_len_data);
> > +	for (i = 0; i < num_len_data; i++) {
> > +		ret = splice(pp1[0], NULL, pp2[1], NULL, 1, SPLICE_F_MOVE);
> > +		if (ret == -1) {
> > +			tst_res(TFAIL | TERRNO, "splice error");
> > +			goto exit;
> > +		}
> > +		SAFE_READ(1, pp2[0], arr_out + i, 1);
> > +	}
> 
> I do not understand why we are moving the data byte by byte here?
> 
> And also the SPLICE_F_MOVE flag, even if that was correctly implemented,
> would be useless here.

Looked at the previous version of the patch and the comment from Jan.

What he meant there was that we should decrease the number of requested
bytes by the number of bytes we spliced already.

-- 
Cyril Hrubis
chrubis@suse.cz
