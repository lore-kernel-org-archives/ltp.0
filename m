From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 30 Aug 2017 16:46:59 +0800
Subject: [LTP] [PATCH COMMITTED] cve/cve-2016-7042: drop extra typedef
 for key_serial_t
In-Reply-To: <f57f3425b1ea061a6f49503da475f7031a553123.1504081283.git.jstancek@redhat.com>
References: <f57f3425b1ea061a6f49503da475f7031a553123.1504081283.git.jstancek@redhat.com>
Message-ID: <1dd71ff0-adf4-9b00-d9d5-f414d02fc02c@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi, Jan

在 08/30/2017 04:28 PM, Jan Stancek 写道:
> It now comes from lapi/keyctl.h:
>   cve-2016-7042.c:37: error: redefinition of typedef ‘key_serial_t’
>   ../../include/lapi/keyctl.h:31: note: previous declaration of ‘key_serial_t’ was here
>   make[2]: *** [cve-2016-7042] Error 1

Ah, I forgot to drop this line, thanks very much!

Best Regards,
Guangwen Feng

> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/cve/cve-2016-7042.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/testcases/cve/cve-2016-7042.c b/testcases/cve/cve-2016-7042.c
> index 228974f51c3f..ff9c0573f196 100644
> --- a/testcases/cve/cve-2016-7042.c
> +++ b/testcases/cve/cve-2016-7042.c
> @@ -34,8 +34,6 @@
>  #include "lapi/syscalls.h"
>  #include "lapi/keyctl.h"
>  
> -typedef int32_t key_serial_t;
> -
>  #define PATH_KEYS	"/proc/keys"
>  
>  static key_serial_t key;
> 


