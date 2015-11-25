From: Wei, Jiangang <weijg.fnst@cn.fujitsu.com>
Date: Wed, 25 Nov 2015 01:25:07 +0000
Subject: [LTP] [PATCH v2 2/2] Fix the order between 2>&1 and >/dev/null
In-Reply-To: <20151124141024.GC4151@rei.lan>
References: <1448345330-23620-2-git-send-email-weijg.fnst@cn.fujitsu.com>
 <1448346118-24387-1-git-send-email-weijg.fnst@cn.fujitsu.com>
 <1448346118-24387-2-git-send-email-weijg.fnst@cn.fujitsu.com>
 <20151124141024.GC4151@rei.lan>
Message-ID: <1448414705.1818.3.camel@localhost>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 2015-11-24 at 15:10 +0100, Cyril Hrubis wrote:
> Hi!
> > --- a/tools/pounder21/libpounder.sh
> > +++ b/tools/pounder21/libpounder.sh
> > @@ -1,3 +1,4 @@
> > +#!/bin/sh
> >  # Common shell functions and variables that all pounder scripts can use.
> >  
> >  # Copyright (C) 2003-2006 IBM
> 
> Is there a reason to add the shebang here? And if there is, the change
> should be described in the git commit message.
I will remove the shebang.

> The rest looks good.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 


-- 
This message has been scanned for viruses and
dangerous content by Fujitsu, and is believed to be clean.

