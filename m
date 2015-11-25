From: Wei, Jiangang <weijg.fnst@cn.fujitsu.com>
Date: Wed, 25 Nov 2015 01:27:26 +0000
Subject: [LTP] [PATCH v2 1/2] kernel/io/disktest: cleanup upon failure
 occurs
In-Reply-To: <20151124140853.GB4151@rei.lan>
References: <1448345330-23620-2-git-send-email-weijg.fnst@cn.fujitsu.com>
 <1448346118-24387-1-git-send-email-weijg.fnst@cn.fujitsu.com>
 <20151124140853.GB4151@rei.lan>
Message-ID: <1448414844.1818.5.camel@localhost>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 2015-11-24 at 15:08 +0100, Cyril Hrubis wrote:
> Hi!
> >  		pMsg(ERR, args, "%s: Error = %u\n", args->device,
> >  		     GETLASTERROR());
> > +		FREE(buff);
> >  		return (-1);
> >  	}
> >  
> >  	TargetLBA = Seek(fd, args->start_lba * BLK_SIZE);
> >  	if (TargetLBA != (args->start_lba * (OFF_T) BLK_SIZE)) {
> >  		pMsg(ERR, args, "Could not seek to start position.\n");
> > +		FREE(buf);
>                      ^
> 		     Should be buff
> 
> The code does not even compile after the change, can you please compile
> test your change to avoid typos like this one?
Ok,  I will keep in mind your comment.
Thanks a lot.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 


-- 
This message has been scanned for viruses and
dangerous content by Fujitsu, and is believed to be clean.

