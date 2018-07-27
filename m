From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Jul 2018 11:31:50 +0200
Subject: [LTP] [PATCH v2] add new testcase for bind
In-Reply-To: <20180727073057.22798-1-mmoese@suse.de>
References: <20180727073057.22798-1-mmoese@suse.de>
Message-ID: <20180727093150.GA914@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <errno.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_net.h"
> +
> +#define SOCK_NAME "socket.1"
> +
> +static int sock1, sock2;
> +
> +static char dir_path[PATH_MAX];
> +static char sockpath[PATH_MAX];
> +
> +void run(void)
> +{
> +	struct sockaddr_un sun;
> +
> +	sock1 = SAFE_SOCKET(PF_UNIX, SOCK_STREAM, 0);
> +
> +	memset(&sun, 0, sizeof(sun));
> +	sun.sun_family = AF_UNIX;
> +	if (snprintf(sockpath, sizeof(sockpath), "%s/%s", dir_path, SOCK_NAME)
> +	    >= PATH_MAX) {
> +		tst_res(TBROK, "bind_test: snprintf(sockpath)");
> +		return;
> +	}
> +	if (snprintf(sun.sun_path, sizeof(sun.sun_path), "%s", sockpath)
> +	    >= (int) sizeof(sun.sun_path)) {
> +		tst_res(TBROK, "bind_test: snprintf(sun.sun_path)");
> +		return;
> +	}
> +
> +	SAFE_BIND(sock1, (struct sockaddr *)&sun, sizeof(sun));
> +
> +	/*
> +	 * Once a STREAM UNIX domain socket has been bound, it can't be
> +	 * rebound. Expected error is EINVAL.
> +	 */
> +	if (bind(sock1, (struct sockaddr *)&sun, sizeof(sun)) == 0) {
> +		tst_res(TFAIL, "re-binding of socket succeeded");
> +		return;
> +	}
> +
> +	if (errno != EINVAL) {
> +		tst_res(TFAIL | TERRNO, "expected EINVAL");
> +		return;
> +	}
> +
> +	sock2 = SAFE_SOCKET(PF_UNIX, SOCK_STREAM, 0);
> +
> +	/*
> +	 * Since a socket is already bound to the pathname, it can't be bound
> +	 * to a second socket. Expected error is EADDRINUSE.
> +	 */
> +	if (bind(sock2, (struct sockaddr *)&sun, sizeof(sun)) == 0) {
> +		tst_res(TFAIL, "bind() succeeded with already bound pathname!");
> +		return;
> +	}
> +
> +	if (errno != EADDRINUSE) {
> +		tst_res(TFAIL | TERRNO, "expected to fail with EADDRINUSE");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "bind() failed with EADDRINUSE as expected");
> +}
> +
> +
> +static void setup(void)
> +{
> +	strncpy(dir_path, "/tmp/unix_bind.XXXXXXX", PATH_MAX);
> +	if (mkdtemp(dir_path) == NULL)
> +		tst_res(TBROK, "cannot create temporary directory");

We should use the test temporary directory here instead. I.e. set the
needs_tmpdir flag in the tst_test structure and use a relative paths in
the testcase.

Other than that this is fine.

> +}
> +
> +static void cleanup(void)
> +{
> +	close(sock1);
> +	close(sock2);
> +	unlink(sockpath);
> +	rmdir(dir_path);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +};
> -- 
> 2.18.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
