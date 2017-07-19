From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Jul 2017 16:50:54 +0200
Subject: [LTP] [PATCH v3 7/9] Test for CVE-2017-5669 in shmat
In-Reply-To: <871spcr0cg.fsf@our.domain.is.not.set>
References: <20170623122211.29575-1-rpalethorpe@suse.com>
 <20170623122211.29575-8-rpalethorpe@suse.com>
 <20170719131953.GI1015@rei.lan>
 <871spcr0cg.fsf@our.domain.is.not.set>
Message-ID: <20170719145054.GK1015@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Why do we try to write to the addres at all?
> >
> > We do PASS/FAIL decision based only on the addres returned from
> > shmat().
> 
> To see if anything interesting happens, like a segfault. I don't think
> anything is likely to happen, but it seemed worth leaving in at the
> time.

Maybe we should also add a TINFO message then, that we are about
dereference the address then.

-- 
Cyril Hrubis
chrubis@suse.cz
