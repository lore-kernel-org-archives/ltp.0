From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Nov 2015 15:08:53 +0100
Subject: [LTP] [PATCH v2 1/2] kernel/io/disktest: cleanup upon failure
 occurs
In-Reply-To: <1448346118-24387-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1448345330-23620-2-git-send-email-weijg.fnst@cn.fujitsu.com>
 <1448346118-24387-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Message-ID: <20151124140853.GB4151@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  		pMsg(ERR, args, "%s: Error = %u\n", args->device,
>  		     GETLASTERROR());
> +		FREE(buff);
>  		return (-1);
>  	}
>  
>  	TargetLBA = Seek(fd, args->start_lba * BLK_SIZE);
>  	if (TargetLBA != (args->start_lba * (OFF_T) BLK_SIZE)) {
>  		pMsg(ERR, args, "Could not seek to start position.\n");
> +		FREE(buf);
                     ^
		     Should be buff

The code does not even compile after the change, can you please compile
test your change to avoid typos like this one?

-- 
Cyril Hrubis
chrubis@suse.cz
