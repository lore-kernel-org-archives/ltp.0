From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Nov 2019 17:10:57 +0100
Subject: [LTP] [PATCH] read_all_sys: skip debugfs
In-Reply-To: <533980280.10363747.1572883583198.JavaMail.zimbra@redhat.com>
References: <4e93b0d943960d957b71bdb998b33ad30424b07c.1572881777.git.jstancek@redhat.com>
 <20191104155900.GA5683@rei.lan>
 <533980280.10363747.1572883583198.JavaMail.zimbra@redhat.com>
Message-ID: <20191104161057.GC5683@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Do we even support multiple parameters for the same option?
> > 
> > I looked that the library code and I would say that we will replace the
> > value with each iteration which means that we will effectively use the
> > last one.
> 
> That is good point. Do we actually need to store blacklist as cmdline parameters?

I guess that we can put the well known ones to the source as well.

-- 
Cyril Hrubis
chrubis@suse.cz
