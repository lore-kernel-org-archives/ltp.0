From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Apr 2018 12:13:09 +0200
Subject: [LTP] [RFC PATCH 1/9] testcases: su: Fix userdel use
In-Reply-To: <20180423094639.14612-2-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
 <20180423094639.14612-2-mylene.josserand@bootlin.com>
Message-ID: <20180423101309.GC24481@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In case "getent" command is not available in the system,
> the userdel command will never be executed and for the
> second use, the test will fail with:
>      useradd: user 'su_usr1' already exists
> 
> Fix that by moving "userdel" command in a new line.
> 
> Signed-off-by: Myl??ne Josserand <mylene.josserand@bootlin.com>
> ---
>  testcases/commands/su/su01 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/commands/su/su01 b/testcases/commands/su/su01
> index 34386d937..1eedcb636 100755
> --- a/testcases/commands/su/su01
> +++ b/testcases/commands/su/su01
> @@ -86,7 +86,8 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
>  #Create 1st test user
>      #erase user if he may exist , so we can have a clean en
>          rm -rf /home/$TEST_USER1
> -        getent passwd $TEST_USER1 > /dev/null 2>&1 && userdel $TEST_USER1
> +        getent passwd $TEST_USER1 > /dev/null 2>&1
> +	userdel $TEST_USER1

I'm pretty sure this was intended to be:

"delete user only if it exists already"

So the whole getent line is useless after this change.

Also I suppose we shouldn't delete users in the test setup anyways, but
the whole tests is a mess and should be cleaned up...

-- 
Cyril Hrubis
chrubis@suse.cz
