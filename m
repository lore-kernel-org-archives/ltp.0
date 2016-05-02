From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 May 2016 11:45:52 +0200
Subject: [LTP] LTP pre-release testing and freeze
In-Reply-To: <1274865023.2004095.1462180208523.JavaMail.zimbra@redhat.com>
References: <20160420143031.GB4004@rei>
 <1728203866.1199576.1461839113790.JavaMail.zimbra@redhat.com>
 <20160428122625.GA25587@rei>
 <1274865023.2004095.1462180208523.JavaMail.zimbra@redhat.com>
Message-ID: <20160502094552.GB11884@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > It seems that mapping PER_LINUX32 to PER_LINUX is a common practice on
> > 64 bit, maybe we should just skip that personality on anything than
> > x86_64.
> 
> Agreed. I can send a patch.

That would be just one ifdef, you can push that directly to the git
repo.

-- 
Cyril Hrubis
chrubis@suse.cz
