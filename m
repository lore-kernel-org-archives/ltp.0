Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V9G3r-0005tK-LH
	for ltp-list@lists.sourceforge.net; Tue, 13 Aug 2013 14:59:03 +0000
Date: Tue, 13 Aug 2013 16:59:02 +0200
From: chrubis@suse.cz
Message-ID: <20130813145902.GC29233@rei>
References: <20130717130502.GD25145@rei>
	<1376311771-30968-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1376311771-30968-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V4 1/2] Implemented tst_fill_file function
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount)
> +{
> +	int fd, counter;
> +	char *buf;
> +
> +	fd = open(path, O_CREAT|O_WRONLY|O_TRUNC, S_IRUSR|S_IWUSR);
> +	if (fd < 0)
> +		return -1;
> +
> +	/* Filling a memory buffer with provided pattern */
> +	buf = malloc(bs);
> +	if (buf == NULL) {
> +		close(fd);
> +
> +		return -1;
> +	}
> +
> +	for (counter = 0; counter < bs; counter++)
> +		buf[counter] = pattern;
> +
> +	/* Filling the file */
> +	for (counter = 0; counter < bcount; counter++)
> +		if (write(fd, buf, bs) != bs) {
> +			free(buf);
> +			close(fd);
> +			unlink(path);
> +
> +			return -1;
> +		}

This is minor but I've told you allready that it's preffered to add the
curly brackets ({}) around large blocks. Such as:

	for (counter = 0; counter < bcount; counter++) {
		if (...) {
			...
			...
		}
	}

> +	free(buf);
> +	if (close(fd) < 0)

Add unlink here too, just to be consistent.

> +		return -1;
> +
> +	return 0;
> +}

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
