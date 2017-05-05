From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Fri, 5 May 2017 03:11:06 +0000 (UTC)
Subject: [LTP] [PATCH] setpriority01: Fix failure on read-only machine
In-Reply-To: <e624587a-7440-0df2-2884-c30b045f37ca@oracle.com>
References: <1491727085-3873-1-git-send-email-the_hoang0709@yahoo.com>
 <1491727085-3873-2-git-send-email-the_hoang0709@yahoo.com>
 <e624587a-7440-0df2-2884-c30b045f37ca@oracle.com>
Message-ID: <1894056224.3391041.1493953866962@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Alexey
I've realized that tst_brk did not exist immediately and it makes the return value become 36, while we need 32. cleanup() does not need to run in this case.


root@mx6q:~# ./setpriority01

tst_test.c:847: INFO: Timeout per run is 0h 05m 00s

setpriority01.c:120: CONF: /etc/passwd is not accessible

userdel: user 'ltp_setpriority01' does not exist

setpriority01.c:133: WARN: 'userdel -r ltp_setpriority01' failed: ENOENT

 

Summary:

passed   0

failed   0

skipped  0

warnings 1

root@mx6q:~# echo $?

36

Could you please to check it again?
Thanks and regards,
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
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170505/739f273c/attachment.html>
