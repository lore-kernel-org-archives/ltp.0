From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Oct 2015 15:33:12 +0100
Subject: [LTP] [PATCH] Fix mlockall tests unprivileged execution
In-Reply-To: <20151025121618.GA15376@issan.sis.pasteur.fr>
References: <20151025121618.GA15376@issan.sis.pasteur.fr>
Message-ID: <20151026143311.GA6059@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Please find a small patch that fix mlockall(2) testcases when run as
> an unprivileged user ... It adds some missing tst_require_root()
> needed for later seteuid() calls.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
