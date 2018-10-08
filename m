From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Sun, 7 Oct 2018 21:11:50 -0300
Subject: [LTP] [PATCH v3] syscalls/membarrier: Add membarrier() initial
 test
In-Reply-To: <20181008000851.21418-1-rafael.tinoco@linaro.org>
References: <243767154.55279006.1538383679362.JavaMail.zimbra@redhat.com>
 <20181008000851.21418-1-rafael.tinoco@linaro.org>
Message-ID: <625b0d11-6299-80d8-a5dd-6c00b81c391b@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/7/18 9:08 PM, Rafael David Tinoco wrote:
> Fixes: #265
> 
> Initial test for membarrier() syscall. It tests all existing membarrier
> "commands" (or features), including the need (or not) for previous
> registration for the call to work.
> 
> Some features did not exist in older kernels and that is covered by
> skipping some calls, flagging test as skipped & okay, and forcing
> others, making sure that return codes and errno are set right in those
> cases.
> 
> Tests are done in a child process due to inexistent kernel interface to
> "unregister" the process from being affected by membarrier() call.
> 
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>

v3 is just a rebase fixing include/lapi/syscalls/i386.in position.

Thank you

-
Rafael
