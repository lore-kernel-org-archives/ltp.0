From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Oct 2017 11:27:27 +0100
Subject: [LTP] [PATCH 3/3] network/tst_netload: dump background
 netstress output on failure
In-Reply-To: <1507812041-2068-3-git-send-email-alexey.kodanev@oracle.com>
References: <1507812041-2068-1-git-send-email-alexey.kodanev@oracle.com>
 <1507812041-2068-3-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20171031102725.7estopjtwatnjibs@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Fix the tests that invoke tst_netload. Add TST_NEEDS_TMPDIR flag
> and remove tst_tmpdir usage.
I'd put replacing tst_tmpdir by TST_NEEDS_TMPDIR in tests into separate commit (it looks
that temporary directory is needed for the test regardless of -B option). But thats a
detail.
Otherwise LGTM.


Kind regards,
Petr
