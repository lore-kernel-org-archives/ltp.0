From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Jun 2019 09:47:03 +0200
Subject: [LTP] [PATCH v1] syscalls/acct02: Fix wrongfully failing
 sometimes
In-Reply-To: <20190607141622.20316-1-camann@suse.com>
References: <20190607141622.20316-1-camann@suse.com>
Message-ID: <20190620074703.GC13879@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

> On some systems the process calling acct() has to end before
> process accounting is started. This caused the original test
> to fail on those systems.
> This fix forks a child process to call acct() in order to
> activate process accounting before running the test program.

> Signed-off-by: Christian Amann <camann@suse.com>

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for you patch. Could you be please more specific?
(which kernel version / glibc)

I'm testing it on various distros, all have struct acct_v3 and all fail
(regardless this patch):
FAIL: acct() wrote incorrect file contents!

Kind regards,
Petr
