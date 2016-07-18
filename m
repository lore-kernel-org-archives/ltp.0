From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Jul 2016 17:07:41 +0200
Subject: [LTP] [PATCH 6/8] waitpid12: use the new API
In-Reply-To: <1468593589-30545-7-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1468593589-30545-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1468593589-30545-7-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160718150740.GF18221@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
And I guess that this test can be simplified quite a lot, there is no
reason for checking that pids could be waited for by process group etc.
We only care about the WNOHANG here (since the rest of the code is
nearly identical to waitpid11.c).

All that needs to be done here is to fork some number of children in a
test setup and let them sleep (I would use pause() for simplicity). Then
the whole test would be just a call to waitpid() with WNOHANG and the
test cleanup would send a signal to the test childrens and then wait for
them.

-- 
Cyril Hrubis
chrubis@suse.cz
