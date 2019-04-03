From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 3 Apr 2019 14:06:55 +0200
Subject: [LTP] [PATCH 1/1] Remove break after return
In-Reply-To: <20190403120220.GB13658@rei>
References: <20190328105006.17337-1-pvorel@suse.cz>
 <5C9D8B2E.1090608@cn.fujitsu.com> <20190403120220.GB13658@rei>
Message-ID: <20190403120655.GA20621@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > Can we also remove break after calling tst_brk()?

> AFAIK that would generate warnings, since compiler cannot deduce on it's
> own that the call will not return.
Agree.


Kind regards,
Petr
