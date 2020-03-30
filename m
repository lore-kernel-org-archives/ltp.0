From: Zouwei (Samuel) <zou_wei@huawei.com>
Date: Mon, 30 Mar 2020 02:29:53 +0000
Subject: [LTP] =?utf-8?b?562U5aSNOiAgW1BBVENIXSBzeXNjYWxscy9zdGF0eDogQWRk?=
 =?utf-8?q?_judgment_to_the_MODE_value?=
In-Reply-To: <7640be42-53a5-c97e-e4ed-042dc323025a@163.com>
References: <1585377584-9931-1-git-send-email-zou_wei@huawei.com>
 <7640be42-53a5-c97e-e4ed-042dc323025a@163.com>
Message-ID: <C3CD0DF8AD11A84CB25A1426DE537C61E5925F39@dggeml524-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

Thanks for your review and comments, I will send the v2 patch.

Best Regards
Zou Wei

-----????-----
???: Xiao Yang [mailto:ice_yangxiao@163.com] 
????: 2020?3?28? 19:38
???: Zouwei (Samuel) <zou_wei@huawei.com>; ltp@lists.linux.it
??: Re: [LTP] [PATCH] syscalls/statx: Add judgment to the MODE value

On 3/28/20 2:39 PM, Zou Wei wrote:
> 1. The default value of umask in most linux systems is 0022, but in some other systems is 0077,
>     which results in different MODE values when opening files.
>
> 2. Adding judgment to the MODE value can improve the versatility of this case.
>
> 3. 63 translates to 77 in octal, meaning the running process has a umask of 0022.
>     That means the process will open files with 0600 as permissions on the filesystem.
>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>   testcases/kernel/syscalls/statx/statx01.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/statx/statx01.c 
> b/testcases/kernel/syscalls/statx/statx01.c
> index 4f9d582..adca1d3 100644
> --- a/testcases/kernel/syscalls/statx/statx01.c
> +++ b/testcases/kernel/syscalls/statx/statx01.c
> @@ -47,7 +47,7 @@
>   #define TESTFILE "test_file"
>   #define MNTPOINT "mntpoint/"
>   #define DEVICEFILE MNTPOINT"blk_dev"
> -#define MODE 0644
> +#define MODE ((umask(0)==63)?0600:0644)

Hi Zou,

1) For the fix, I think you just need to clear current mask by umask(0) in setup().

2) Don't mix the fix and adding coverage(i.e. different permissions). Please use

 ??? other ways(create two files with different permissions or change the permission

 ??? during test, etc) if you want to run test with different permissions.

Thanks,

Xiao Yang

>
>   #define SIZE 256
>   #define MAJOR 8
> --
> 2.6.2
>
>

