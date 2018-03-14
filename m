From: Xiuzhe Xiao <xiuzhe.xiao@nautel.com>
Date: Wed, 14 Mar 2018 16:37:56 +0000
Subject: [LTP] SIGSEGV in faccessat01 and fchmodat01
Message-ID: <BY2PR13MB070967D607D2E7F4F797189A90D10@BY2PR13MB0709.namprd13.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Have anyone had these problem?
Is there any requirement for these test? or is anyone can give me a direction, I'll be appreciated

<<<test_output>>>
faccessat01    1  TBROK  :  tst_sig.c:233: unexpected signal SIGSEGV(11) received (pid = 2134).
faccessat01    2  TBROK  :  tst_sig.c:233: Remaining cases broken

<<<test_output>>>
fchmodat01    1  TBROK  :  tst_sig.c:233: unexpected signal SIGSEGV(11) received (pid = 2289).
fchmodat01    2  TBROK  :  tst_sig.c:233: Remaining cases broken


Thanks

Shawnx.

This communication, including any attached documentation, is intended only for the person or entity to which it is addressed, and may contain confidential, personal, and/or privileged information. Any unauthorized disclosure, copying, or taking action on the contents is strictly prohibited. If you have received this message in error, please contact us immediately so we may correct our records. Please then delete or destroy the original transmission and any subsequent reply. Thank you.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180314/48e84e4a/attachment.html>
