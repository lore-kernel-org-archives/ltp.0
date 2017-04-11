From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 11 Apr 2017 12:46:13 +0300
Subject: [LTP] [PATCH] setpriority01: Fix failure on read-only machine
In-Reply-To: <1491727085-3873-2-git-send-email-the_hoang0709@yahoo.com>
References: <1491727085-3873-1-git-send-email-the_hoang0709@yahoo.com>
 <1491727085-3873-2-git-send-email-the_hoang0709@yahoo.com>
Message-ID: <e624587a-7440-0df2-2884-c30b045f37ca@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 09.04.2017 11:38, the_hoang0709@yahoo.com wrote:
> Return 32 if /etc/passwd is read-only.
> Fixes: #137
> See also: #88

Applied both patches, thanks! Modified the last one a little bit:
added __GNU_SOURCE foreaccess() and renamed tst_brkm() to
tst_brk() as the test converted to newer LTP API.

Thanks,
Alexey

