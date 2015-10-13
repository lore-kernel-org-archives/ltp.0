From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 13 Oct 2015 13:45:04 +0300
Subject: [LTP] [PATCH v8 2/7] SAFE_MACROS: Add socket(), bind(), listen(),
 connect() and getsockname()
In-Reply-To: <1444303781-18441-2-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <20151007132856.GD2608@rei.suse.cz>
 <1444303781-18441-1-git-send-email-zenglg.jy@cn.fujitsu.com>
 <1444303781-18441-2-git-send-email-zenglg.jy@cn.fujitsu.com>
Message-ID: <561CE0B0.2000801@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 10/08/2015 02:29 PM, Zeng Linggang wrote:
> +#include <errno.h>
> +#include "test.h"
> +#include "safe_net.h"
> +
> +char *tst_sock_addr(const struct sockaddr *sa, socklen_t salen, char *res,
> +		    size_t len)
> +{
> +	char portstr[8];
> +
> +	switch (sa->sa_family) {
> +
> +	case AF_INET: {
> +		struct sockaddr_in *sin = (struct sockaddr_in *)sa;
> +
> +		if (!inet_ntop(AF_INET, &sin->sin_addr, res, len))
> +			return NULL;
> +
> +		if (ntohs(sin->sin_port) != 0) {
> +			snprintf(portstr, sizeof(portstr), ":%d",
> +				 ntohs(sin->sin_port));
> +			strcat(res, portstr);
> +		}
> +
> +		return res;
> +	}
> +
> +	case AF_INET6: {
> +		struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sa;
> +
> +		res[0] = '[';
> +		if (!inet_ntop(AF_INET6, &sin6->sin6_addr, res + 1, len - 1))
> +			return NULL;
> +
> +		if (ntohs(sin6->sin6_port) != 0) {
> +			snprintf(portstr, sizeof(portstr), "]:%d",
> +				 ntohs(sin6->sin6_port));
> +			strcat(res, portstr);
> +			return res;
> +		}
> +
> +		return res + 1;
> +	}
> +
> +	case AF_UNIX: {
> +		struct sockaddr_un *unp = (struct sockaddr_un *)sa;
> +
> +		if (unp->sun_path[0] == '\0')
> +			strcpy(res, "(no pathname bound)");
> +		else
> +			snprintf(res, len, "%s", unp->sun_path);
> +
> +		return res;
> +	}
> +
> +	default: {
> +		snprintf(res, len,
> +			 "sock_ntop: unknown AF_xxx: %d, len: %d",
> +			 sa->sa_family, salen);
> +
> +		return res;
> +	}
> +
> +	}
> +
> +	return NULL;

The last return is redundant here.

> +}
> +
> +int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
> +		int domain, int type, int protocol)
> +{
> +	int rval;
> +
> +	rval = socket(domain, type, protocol);
> +
> +	if (rval < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			 "%s:%d: socket(%d, %d, %d) failed", file, lineno,
> +			 domain, type, protocol);
> +	}
> +
> +	return rval;
> +}
> +
> +int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
> +	      int socket, const struct sockaddr *address,
> +	      socklen_t address_len)
> +{
> +	int i;
> +	char buf[128];
> +
> +	for (i = 0; i < 120; i++) {
> +		if (!bind(socket, address, address_len)) {
> +			tst_resm(TINFO, "bind is OK now");

I doubt that we need to print "bind is OK now"... the other library 
functions don't print anything on success.

Otherwise it looks good.

Also, could you please send a patch that renames asapi_04/05/06 to 
asapi_01/02/03?

Best regards,
Alexey

