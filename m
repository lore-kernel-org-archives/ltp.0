From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 5 Apr 2017 20:25:20 +0300
Subject: [LTP] [PATCH] prot_hsymlinks: Fix failure on read-only machine
In-Reply-To: <1489107284-4313-1-git-send-email-the_hoang0709@yahoo.com>
References: <1489107284-4313-1-git-send-email-the_hoang0709@yahoo.com>
Message-ID: <c5bc7bac-4558-5fb8-8872-d827b182242d@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 10.03.2017 3:54, the_hoang0709@yahoo.com wrote:
> ...
>  	if (disable_protected_hlinks) {
>  		tst_resm(TINFO, "Disable protected hardlinks mode back");
> @@ -316,8 +317,13 @@ static void test_user_cmd(const char *user_cmd)
>  	char cmd[MAX_CMD_LEN];
>  	snprintf(cmd, MAX_CMD_LEN, "%s %s", user_cmd, users[TEST_USER].name);
>  	if (system(cmd) != 0) {
> -		tst_brkm(TBROK, cleanup, "Failed to run cmd: %s %s",
> +		if (eaccess("/etc/passwd", W_OK)) {
> +			tst_brkm(TCONF, cleanup,
> +			"/etc/passwd is not accessible");

It would be better to add this check to the top of setup(), right after
tst_kvercmp(), and exit without doing cleanup.

Thanks,
Alexey

