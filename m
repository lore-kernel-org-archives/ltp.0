From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Tue, 22 Oct 2019 14:44:53 -0300
Subject: [LTP] [PATCH] fs/binfmt_misc02.sh: Fix local variable
 assignment for dash
In-Reply-To: <20191022025456.15711-1-ice_yangxiao@163.com>
References: <20191022025456.15711-1-ice_yangxiao@163.com>
Message-ID: <20191022174452.GB4055@calabresa>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Oct 22, 2019 at 10:54:56AM +0800, Xiao Yang wrote:
> Only the first one can be accepted if more than one string are assigned
> to local valiable.  For example, only "This" is assigned to $string:
> ------------------------------------
> tstring="This is test for extension"
> ...
> local string=$tstring
> ------------------------------------
> 
> We add a pair of quotes to fix the issue now. Besides we can also fix
> the issue by splitting declaration and assignment(e.g. local string &
> string=$tstring).
> 
> See the explanation from:
> https://wiki.ubuntu.com/DashAsBinSh#local
> 
> Fixes: #601
> Reported-by: limingyu <limingyu@deepin.com>
> Suggested-by: limingyu <limingyu@deepin.com>
> Signed-off-by: Xiao Yang <ice_yangxiao@163.com>

This fixes a problem we have been seeing.

Tested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

> ---
>  testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
> index 8d0ecd895..9dbcd68cc 100755
> --- a/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
> +++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
> @@ -26,7 +26,7 @@ TST_NEEDS_CMDS="which cat head"
>  recognised_unrecognised()
>  {
>  	local file=$1
> -	local string=$2
> +	local string="$2"
>  
>  	eval $file >temp 2>&1
>  	if [ $? -ne 0 ] || ! grep -q "$string" temp; then
> @@ -52,7 +52,7 @@ recognised_unrecognised()
>  unrecognised()
>  {
>  	local file=$1
> -	local string=$2
> +	local string="$2"
>  
>  	eval $file >temp 2>&1
>  	if [ $? -eq 0 ] || grep -q "$string" temp; then
> -- 
> 2.21.0
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
