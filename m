From: sunlianwen <sunlw.fnst@cn.fujitsu.com>
Date: Wed, 14 Mar 2018 08:42:22 +0800
Subject: [LTP] [PATCH v2 2/3] lib: TCONF on "not supported" errnos in
 SAFE_SOCKET()
In-Reply-To: <20180313150111.16501-2-pvorel@suse.cz>
References: <20180313150111.16501-1-pvorel@suse.cz>
 <20180313150111.16501-2-pvorel@suse.cz>
Message-ID: <50741a4d-d12e-f0b7-adf7-92fe0a8e0c1d@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi
    I am sorry I forget to report my debug info on RHEL7.5Beta about 
this question.
I write a testcase on RHEL7.5Beta. the test case is below.

#include <netinet/in.h>
#include <sys/socket.h>
#include <stdio.h>

int main (int argc, const char * argv[])
{
     //create a dccp socket
     int server_socket = socket(AF_INET6, SOCK_DCCP, IPPROTO_DCCP);
     if (server_socket == -1) {
         perror("socket error");
         return 1;
     }
    printf("test is ok \n");
}

And the  RHEL7.5Beta will report "Socket type not supported"  when run 
my testcase  on RHEL7.5Beta .
and the RHEL7.4GA will report "Permission denied " when run my testcase 
on RHEL7.4GA
it's ok when run my testcase on RHEL7.3GA.

That's all.

Thanks
Lianwen Sun

On 03/13/2018 11:01 PM, Petr Vorel wrote:
> *NOSUPPORT errnos likely mean there is configuration issue rather than
> test failure.
>
> e.g. missing dccp module in netstress.c which was so far set as TBROK:
> safe_net.c:117: BROK: netstress.c:654: socket(10, 6, 33) failed: ESOCKTNOSUPPORT
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>   lib/safe_net.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/lib/safe_net.c b/lib/safe_net.c
> index 9ea9d2b42..9ed52dcd1 100644
> --- a/lib/safe_net.c
> +++ b/lib/safe_net.c
> @@ -107,12 +107,24 @@ int tst_getsockport(const char *file, const int lineno, int sockfd)
>   int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
>   		int domain, int type, int protocol)
>   {
> -	int rval;
> +	int rval, ttype;
>   
>   	rval = socket(domain, type, protocol);
>   
>   	if (rval < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +		switch (errno) {
> +		case EPROTONOSUPPORT:
> +		case ESOCKTNOSUPPORT:
> +		case EOPNOTSUPP:
> +		case EPFNOSUPPORT:
> +		case EAFNOSUPPORT:
> +			ttype = TCONF;
> +			break;
> +		default:
> +			ttype = TBROK;
> +		}
> +
> +		tst_brkm(ttype | TERRNO, cleanup_fn,
>   			 "%s:%d: socket(%d, %d, %d) failed", file, lineno,
>   			 domain, type, protocol);
>   	}



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180314/e9a14bbf/attachment.html>
