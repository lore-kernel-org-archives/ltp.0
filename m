From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Jul 2021 18:34:20 +0200
Subject: [LTP] [PATCH] change mmap flags from PROT_EXEC to PROT_READ
In-Reply-To: <20210323133137.2280947-1-hubachelar@gmail.com>
References: <20210323133137.2280947-1-hubachelar@gmail.com>
Message-ID: <YPhMjMs+mL0OYyQx@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In some architecture(e.g., mips), PROT_EXEC doesn't guarantee PROT_READ,
> which will cause segment fault. In others architectures, PROT_READ is
> more accurate.

First of all sorry for the late response.

> Signed-off-by: xueshi hu <hubachelar@gmail.com>
> ---
>  testcases/kernel/syscalls/mmap/mmap03.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/mmap/mmap03.c b/testcases/kernel/syscalls/mmap/mmap03.c
> index b957a3218..2fcf1ef17 100644
> --- a/testcases/kernel/syscalls/mmap/mmap03.c
> +++ b/testcases/kernel/syscalls/mmap/mmap03.c
> @@ -85,7 +85,7 @@ int main(int ac, char **av)
>  		 * with execute access.
>  		 */
>  		errno = 0;
> -		addr = mmap(0, page_sz, PROT_EXEC,
> +		addr = mmap(0, page_sz, PROT_READ,
>  			    MAP_FILE | MAP_SHARED, fildes, 0);

This is not correct fix. The test actually expects that on certain
architectures PROT_EXEC does not imply PROT_READ but that check is
missing mips, so this should probably be fixed with:

diff --git a/testcases/kernel/syscalls/mmap/mmap03.c b/testcases/kernel/syscalls/mmap/mmap03.c
index b957a3218..9d94d2653 100644
--- a/testcases/kernel/syscalls/mmap/mmap03.c
+++ b/testcases/kernel/syscalls/mmap/mmap03.c
@@ -124,7 +124,7 @@ int main(int ac, char **av)
                                         "correct");
                        }
                }
-#if defined(__ia64__) || defined(__hppa__)
+#if defined(__ia64__) || defined(__hppa__) || defined(__mips__)
                if (pass) {
                        tst_resm(TPASS, "Got SIGSEGV as expected");
                } else {

Does this change fixes the test for you?

-- 
Cyril Hrubis
chrubis@suse.cz
