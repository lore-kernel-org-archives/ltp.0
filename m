From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 1 Nov 2017 15:33:55 +0300
Subject: [LTP] [PATCH 3/3] network/tst_netload: dump background
 netstress output on failure
In-Reply-To: <20171031102725.7estopjtwatnjibs@dell5510>
References: <1507812041-2068-1-git-send-email-alexey.kodanev@oracle.com>
 <1507812041-2068-3-git-send-email-alexey.kodanev@oracle.com>
 <20171031102725.7estopjtwatnjibs@dell5510>
Message-ID: <52d65fc4-6858-ba95-3035-5733d586683b@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/31/2017 01:27 PM, Petr Vorel wrote:
>> Fix the tests that invoke tst_netload. Add TST_NEEDS_TMPDIR flag
>> and remove tst_tmpdir usage.
> I'd put replacing tst_tmpdir by TST_NEEDS_TMPDIR in tests into separate commit (it looks
> that temporary directory is needed for the test regardless of -B option). But thats a
> detail.

Agree, moved the tests changes to another patch and applied.

Thanks,
Alexey

