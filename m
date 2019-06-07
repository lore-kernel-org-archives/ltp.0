From: Christian Amann <camann@suse.com>
Date: Fri, 7 Jun 2019 08:32:38 +0200
Subject: [LTP] [PATCH v2] syscalls/acct02: add functional testcase
In-Reply-To: <20190606121436.GB27083@rei>
References: <20190604072228.17513-1-camann@suse.com>
 <20190606121436.GB27083@rei>
Message-ID: <7c7bf785-adbd-d69b-c17b-bc65c2228d11@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

yes, I have tested it on a system like you describe but I receive a
positive output:

tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1111: INFO: Timeout per run is 0h 05m 00s
tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
acct02.c:159: INFO: Verifying using 'struct acct'
acct02.c:137: INFO: Number of accounting file entries tested: 1
acct02.c:140: PASS: acct() wrote correct file contents!

There seems to be something else going wrong. I will investigate this.

Kind regards,

Christian


On 06/06/2019 14:14, Cyril Hrubis wrote:
> Hi!
> Have you tried the test on the !v3 case?
>
> I do have:
>
> CONFIG_BSD_PROCESS_ACCT=y
> # CONFIG_BSD_PROCESS_ACCT_V3 is not set
>
> And the test fails with:
>
> tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
> tst_test.c:1111: INFO: Timeout per run is 0h 05m 00s
> tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
> acct02.c:159: INFO: Verifying using 'struct acct'
> acct02.c:137: INFO: Number of accounting file entries tested: 0
> acct02.c:142: FAIL: acct() wrote incorrect file contents!
>
> Looks like the file is empty for me...
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190607/b890e306/attachment.html>
