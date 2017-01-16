From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 16 Jan 2017 08:33:30 -0500 (EST)
Subject: [LTP] [PATCH] quotactl01: replace int comparison with memcmp
In-Reply-To: <20170116115056.GB23274@rei.lan>
References: <74ba2553e066b29871bd1e16f00755eb57747fc8.1484307598.git.jstancek@redhat.com>
 <20170116115056.GB23274@rei.lan>
Message-ID: <736460527.3439715.1484573610899.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it, "yangx jy" <yangx.jy@cn.fujitsu.com>
> Sent: Monday, 16 January, 2017 12:50:57 PM
> Subject: Re: [PATCH] quotactl01: replace int comparison with memcmp
> 
> Hi!
> > -	memset(fmt_buf, 0, sizeof(fmt_buf));
> > +	memset(&fmt_buf, 0, sizeof(fmt_buf));
> 
> Hmm, we can simply do fmt_buf = 0 here now, right?

Replaced with simple assignment and pushed.

Regards,
Jan

> 
> Otherwise this looks good, acked.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
