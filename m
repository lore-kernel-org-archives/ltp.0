From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Oct 2020 10:53:50 +0200
Subject: [LTP] [PATCH 1/3] lib/tst_kconfig: Rewrite the parser internals
In-Reply-To: <87mu0evfzv.fsf@suse.de>
References: <20201020100910.10828-1-chrubis@suse.cz>
 <20201020100910.10828-2-chrubis@suse.cz> <878sbzx66b.fsf@suse.de>
 <20201021100605.GA10861@yuki.lan> <874kmnwy6g.fsf@suse.de>
 <20201021141157.GC10861@yuki.lan> <87mu0evfzv.fsf@suse.de>
Message-ID: <20201022085350.GA2427@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I do not get what you are trying to say. Are you saying that we should
> > tokenize the input? I do not think that this is necessary since the file
> > format is pretty simple.
> 
> Yes or atleast test the assumption you won't find configs with spaces or
> other wierd stuff in by throwing an error if we find something
> unexpected. If someone has a broken config we can tell them that.

I guess I can make it a bit more robust in a follow up patch.

-- 
Cyril Hrubis
chrubis@suse.cz
