From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Oct 2020 15:49:36 +0200
Subject: [LTP] [PATCH 2/2] fanotify: Test with tst_variant both raw
 syscall and libc
In-Reply-To: <20200428113501.24711-2-pvorel@suse.cz>
References: <20200428113501.24711-1-pvorel@suse.cz>
 <20200428113501.24711-2-pvorel@suse.cz>
Message-ID: <20201014134936.GB13224@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> libc wrappers for fanotify_init() and fanotify_mark() are trivial, so it
> might not make sense to test both variants. WDYT?

Hmm, I guess that fanotify_init() and fanotify_mark() are included in
libc for quite some time, so it does not make much sense to go for the
raw syscall here. But I do not have a strong opinion here, if anyone
thinks that this would be useful, we can as well go for it.

-- 
Cyril Hrubis
chrubis@suse.cz
