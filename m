From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Jan 2018 15:59:27 +0100
Subject: [LTP] [PATCH] safe_mount: Do not try mount() syscall for FUSE fs
In-Reply-To: <1990718613.918376.1516179258863.JavaMail.zimbra@redhat.com>
References: <20180116092318.20521-1-chrubis@suse.cz>
 <1990718613.918376.1516179258863.JavaMail.zimbra@redhat.com>
Message-ID: <20180117145927.GA15159@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed along with two obvious fixed for two build failures.

Now last patch that I would like to get included in the release is:

[PATCH] tst_test: Fix exit value on tst_brk(TCONF, ...)

Can you have a quick look?

-- 
Cyril Hrubis
chrubis@suse.cz
