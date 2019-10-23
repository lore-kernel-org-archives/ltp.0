From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Wed, 23 Oct 2019 11:04:09 -0300
Subject: [LTP] [PATCH] timer_create01: accept kernel ENOTSUPP
In-Reply-To: <1714198769.8739783.1571839133168.JavaMail.zimbra@redhat.com>
References: <cb6173ec393a23949ec40c9747fc7f75fed2591f.1571838908.git.jstancek@redhat.com>
 <1714198769.8739783.1571839133168.JavaMail.zimbra@redhat.com>
Message-ID: <20191023140408.GC4055@calabresa>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Oct 23, 2019 at 09:58:53AM -0400, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
> > ENOTSUP in userspace is alias for EOPNOTSUPP, so the test still fails.
> > Add definition of kernel's ENOTSUPP and use that.
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> 
> I think I misread the original commit. Seems we want this to fail for ENOTSUPP.
> 

You are right. We want this to succeed with EOPNOTSUPP, as it's a valid error
from kernel space.

However, we don't want to validate kernels that wrongly return ENOTSUPP, as
it's not a valid userspace errno. Any kernel code that exposes ENOTSUPP to
userspace is buggy and should be fixed. So, in fact, we would like to flag such
return values as failures/kernel bugs.

Cascardo.

> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
