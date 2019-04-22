From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 22 Apr 2019 17:46:43 +0800
Subject: [LTP] [PATCH v2] file01.sh: Fix in was not recognized
In-Reply-To: <1555922118-412699-1-git-send-email-zhe.he@windriver.com>
References: <1555922118-412699-1-git-send-email-zhe.he@windriver.com>
Message-ID: <5CBD8D83.4080901@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 2019/04/22 16:35, zhe.he@windriver.com wrote:
> From: He Zhe<zhe.he@windriver.com>
>
> Some file has "pie" appending after LSB or MSB, which causes mismatch and the
> following error.
>
> "file01 10 TFAIL: in: was not recognized"
> ..."ELF 64-bit LSB pie executable"...
>
> This patches tunes the regulation expression to include those cases.
>
> Signed-off-by: He Zhe<zhe.he@windriver.com>
> ---
> v1 to v2: split into two groups to just match the encountered case
>
>   testcases/commands/file/file01.sh | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/commands/file/file01.sh b/testcases/commands/file/file01.sh
> index 0a8119e..55c0433 100755
> --- a/testcases/commands/file/file01.sh
> +++ b/testcases/commands/file/file01.sh
> @@ -91,7 +91,9 @@ do_test()
>   	 9) file_test in.m4 "M4 macro processor script, ASCII text" \
>   			    "ASCII M4 macro language pre-processor text";;
>   	10) file_test in "ELF .*-bit $TEST_ARCH executable, .*" \
> -			 "ELF .*-bit $TEST_ARCH shared object, .*";;
> +			 "ELF .*-bit $TEST_ARCH shared object, .*" \
> +			 "ELF .*-bit $TEST_ARCH pie executable, .*" \
> +			 "ELF .*-bit $TEST_ARCH pie shared object, .*";;
Hi He,

Perhap, it's simpler to use the ‘.*’regexp directly as your first patch 
does:
-----------------------------------------------------------------------

-	10) file_test in "ELF .*-bit $TEST_ARCH executable, .*" \
-			 "ELF .*-bit $TEST_ARCH shared object, .*";;
+	10) file_test in "ELF .*-bit $TEST_ARCH .*executable, .*" \
+			 "ELF .*-bit $TEST_ARCH .*shared object, .*";;

-----------------------------------------------------------------------

Best Regards,
Xiao Yang
>   	11) file_test in.ar "current ar archive";;
>   	12) file_test in.tar "tar archive";;
>   	13) file_test in.tar.gz "gzip compressed data, .*";;



