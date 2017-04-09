From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Sun, 9 Apr 2017 08:29:32 +0000 (UTC)
Subject: [LTP] [PATCH] prot_hsymlinks: Fix failure on read-only machine
In-Reply-To: <c5bc7bac-4558-5fb8-8872-d827b182242d@oracle.com>
References: <1489107284-4313-1-git-send-email-the_hoang0709@yahoo.com>
 <c5bc7bac-4558-5fb8-8872-d827b182242d@oracle.com>
Message-ID: <1016101328.2486923.1491726572781@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
Thanks Alexey, this would be much simpler. I'll send new patch. (also setpriority01 fails on my read-only system, I'll update it similiarly)

Thanks a lot for your help,
Best regards,
Hoang

      From: Alexey Kodanev <alexey.kodanev@oracle.com>
 To: the_hoang0709@yahoo.com; ltp@lists.linux.it 
 Sent: Thursday, 6 April 2017, 0:25
 Subject: Re: [LTP] [PATCH] prot_hsymlinks: Fix failure on read-only machine
   
Hi,
On 10.03.2017 3:54, the_hoang0709@yahoo.com wrote:
> ...
>      if (disable_protected_hlinks) {
>          tst_resm(TINFO, "Disable protected hardlinks mode back");
> @@ -316,8 +317,13 @@ static void test_user_cmd(const char *user_cmd)
>      char cmd[MAX_CMD_LEN];
>      snprintf(cmd, MAX_CMD_LEN, "%s %s", user_cmd, users[TEST_USER].name);
>      if (system(cmd) != 0) {
> -        tst_brkm(TBROK, cleanup, "Failed to run cmd: %s %s",
> +        if (eaccess("/etc/passwd", W_OK)) {
> +            tst_brkm(TCONF, cleanup,
> +            "/etc/passwd is not accessible");

It would be better to add this check to the top of setup(), right after
tst_kvercmp(), and exit without doing cleanup.

Thanks,
Alexey



   
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170409/d764cf7c/attachment-0001.html>
