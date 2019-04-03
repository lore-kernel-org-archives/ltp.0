From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Apr 2019 14:02:20 +0200
Subject: [LTP] [PATCH 1/1] Remove break after return
In-Reply-To: <5C9D8B2E.1090608@cn.fujitsu.com>
References: <20190328105006.17337-1-pvorel@suse.cz>
 <5C9D8B2E.1090608@cn.fujitsu.com>
Message-ID: <20190403120220.GB13658@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks for your cleanup. :-)
> 
> Can we also remove break after calling tst_brk()?

AFAIK that would generate warnings, since compiler cannot deduce on it's
own that the call will not return.

-- 
Cyril Hrubis
chrubis@suse.cz
