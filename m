From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Jul 2016 15:55:43 +0200
Subject: [LTP] [PATCH] safe_macros: match oldlib SAFE_CLOSE with docs
In-Reply-To: <c173ae5fd35390cdf47c0fed09577c0c0edab814.1468247097.git.jstancek@redhat.com>
References: <c173ae5fd35390cdf47c0fed09577c0c0edab814.1468247097.git.jstancek@redhat.com>
Message-ID: <20160712135542.GD2651@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Docs say that SAFE_CLOSE() sets the passed file descriptor to -1
> after it's successfully closed, but oldlib SAFE_CLOSE doesn't
> do that.

Have you tried to run at least syscalls testsuite after this change?

I do not expect that this will break anything, but there it's a possibility.

-- 
Cyril Hrubis
chrubis@suse.cz
