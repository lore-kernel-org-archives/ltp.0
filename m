From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Jan 2017 11:26:33 +0100
Subject: [LTP] [PATCH ltp] su01: do pre-checking to avoid annoying
	warning
In-Reply-To: <1481849622-19704-1-git-send-email-ningx.han@intel.com>
References: <1481849622-19704-1-git-send-email-ningx.han@intel.com>
Message-ID: <20170118102632.GA29948@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> ---
>  testcases/commands/su/su01 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/commands/su/su01 b/testcases/commands/su/su01
> index dd1517f..41441de 100755
> --- a/testcases/commands/su/su01
> +++ b/testcases/commands/su/su01
> @@ -86,7 +86,7 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
>  #Create 1st test user
>      #erase user if he may exist , so we can have a clean en
>          rm -rf /home/$TEST_USER1
> -        userdel $TEST_USER1
> +        getent passwd $TEST_USER1 &> /dev/null && userdel $TEST_USER1
                                     ^
	                      This is a bashism, portable way to
			      redirect both streams is > /dev/null 2>&1

Upon closer look I've found and fixed two cases of bashism and pushed,
thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
