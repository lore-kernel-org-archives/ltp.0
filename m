From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Oct 2017 16:43:07 +0200
Subject: [LTP] [PATCH 2/2 v2] security/dirtyc0w: synchronize parent and
 child
In-Reply-To: <0d87a0f1b598e710e21ebbabf316c39610e5d47f.1507290372.git.jstancek@redhat.com>
References: <94518262a76edca533440acb73611eb93184dc90.1507290372.git.jstancek@redhat.com>
 <0d87a0f1b598e710e21ebbabf316c39610e5d47f.1507290372.git.jstancek@redhat.com>
Message-ID: <20171009144307.GC25633@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +		(void)execvpe(TEST_APP, av, tst_ipc_envp);
> +		tst_brk(TBROK|TERRNO, "exec failed");

Can we please add SAFE_EXECVPE() to the library?

Other than that it looks good to me, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
