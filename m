From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 24 Feb 2020 17:34:02 +0100
Subject: [LTP] [PATCH v1 1/2] syscalls/socketcall02: Cleanup && rewrite
 to new API
In-Reply-To: <04f0e695-8301-98bb-2b7a-4e20dfb09d72@cn.fujitsu.com>
References: <1581249526-25295-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <04f0e695-8301-98bb-2b7a-4e20dfb09d72@cn.fujitsu.com>
Message-ID: <20200224163402.GA24673@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > -PF_INET, SOCK_STREAM, 0}, -1, EINVAL, "invalid call"};
> > +} TC[] = {
> > +	{0, args_valid, EINVAL, "invalid call(0)"},
> "invalid call(<1)" is more correc.
> > +	{21, args_valid, EINVAL, "invalid call(21)"},
> "invalid call(>20)" is more correct.
> > +	{SYS_SOCKET, NULL, EFAULT, "invalid args address"},
> > +};

I've fixed these two and pushed both patches, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
