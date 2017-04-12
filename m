From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Wed, 12 Apr 2017 07:10:23 +0000 (UTC)
Subject: [LTP] [PATCH] setpriority01: Fix failure on read-only machine
In-Reply-To: <e624587a-7440-0df2-2884-c30b045f37ca@oracle.com>
References: <1491727085-3873-1-git-send-email-the_hoang0709@yahoo.com>
 <1491727085-3873-2-git-send-email-the_hoang0709@yahoo.com>
 <e624587a-7440-0df2-2884-c30b045f37ca@oracle.com>
Message-ID: <99352309.390587.1491981023119@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,
Thanks a lot for helping to merge patches.
Best regards,
Hoang


 
 
  On Tue, Apr 11, 2017 at 16:46, Alexey Kodanev<alexey.kodanev@oracle.com> wrote:   Hi,
On 09.04.2017 11:38, the_hoang0709@yahoo.com wrote:
> Return 32 if /etc/passwd is read-only.
> Fixes: #137
> See also: #88

Applied both patches, thanks! Modified the last one a little bit:
added __GNU_SOURCE foreaccess() and renamed tst_brkm() to
tst_brk() as the test converted to newer LTP API.

Thanks,
Alexey

  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170412/275cc14e/attachment-0001.html>
