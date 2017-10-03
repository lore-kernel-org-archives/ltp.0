From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Oct 2017 21:05:41 +0200
Subject: [LTP] [PATCH 1/1] syscalls, lib: Use SAFE_{BIND, LISTEN,
 SOCKET} macros
In-Reply-To: <778521072.25826642.1507054113445.JavaMail.zimbra@redhat.com>
References: <20170929231036.32262-1-pvorel@suse.cz>
 <878tgtwqk7.fsf@our.domain.is.not.set>
 <20171002150417.jodtfynklflxe5pl@dell5510>
 <20171002152109.GA3736@rei>
 <20171002153616.k6fkz7fpzh2shzdc@dell5510>
 <20171003114349.GA19124@rei>
 <20171003123114.4iylsq2c35hh4pmh@dell5510>
 <20171003125653.GA11692@rei>
 <778521072.25826642.1507054113445.JavaMail.zimbra@redhat.com>
Message-ID: <20171003190540.GA7210@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > Really nice solution :-).
> > > This script is really worth of adding into LTP (even it requires to check
> > > formatting).
> > 
> > I will strip the old library parts, then we can add it, maybe we can
> > even use it as a commit hook or something to automatically check if
> > we could have used a SAFE_MACRO() instead of custom error handling...
> > 
> 
> As I was looking at changes, I came across:
>   tst_brkm(TFAIL | TERRNO, ...);
> 
> I guess most of these tst_brk TFAILs should be TBROKs, but that would be
> likely difficult to script.

Yes, we would have to review which of these are real TFAILs manually,
which could be done, but would be quite time consuming. So I stuck with
changes I can formally prove are equal.

-- 
Cyril Hrubis
chrubis@suse.cz
