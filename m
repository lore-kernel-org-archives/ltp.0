From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Feb 2020 16:54:23 +0800
Subject: [LTP] [PATCH 4/7] syscalls/fsmount: New tests
In-Reply-To: <20200217082931.vbjkg2f53lek4uf3@vireshk-i7>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <1c61c673a02152c30edac0e25438257c23c3322e.1581680021.git.viresh.kumar@linaro.org>
 <CAEemH2f2pR1KhLAoKKphzh9fP++yyALbv4TiAh=4Vyv0M3SEdw@mail.gmail.com>
 <20200217082931.vbjkg2f53lek4uf3@vireshk-i7>
Message-ID: <CAEemH2c28zj-+pec+sgoLzCq6iV627YvyH2hRpQN98eYZ_8geg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Feb 17, 2020 at 4:29 PM Viresh Kumar <viresh.kumar@linaro.org>
wrote:

> ...
> > Adding #include "lapi/fcntl.h" in case of ?AT_FDCWD? undeclared. It seems
> > we have to do this for all the tests involves  ?AT_FDCWD?.
>
> my fsmount.h header includes <fcntl.h>, won't that be enough ?
>

I'm afraid it's not enough.

After having a closer look, the reason is that the AT_FDCWD is defined with
condition __USE_ATFILE,  the __USE_ATFILE depends on _ATFILE_SOURCE
defined, and _ATFILE_SOURCE needs enable _GNU_SOURCE.

So another effective way is to add '#define _GNU_SOURCE' in front of your
test then that <fcntl.h> will be work for you.

# rpm -qa glibc-headers
glibc-headers-2.5-123

# cat /usr/include/fcntl.h |grep AT_FDCWD -B 2 -A 2
#ifdef __USE_ATFILE
# define AT_FDCWD -100   /* Special value used to indicate
                                                the *at functions should
use the
                                                current working directory.
*/


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200217/cccc37ee/attachment.htm>
