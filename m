From: Li Wang <liwang@redhat.com>
Date: Wed, 18 Mar 2020 15:54:54 +0800
Subject: [LTP] [PATCH] syscalls/pidfd_send_signal: Use local pointer to
 verify signal data
In-Reply-To: <31b0bde3ac9d0e617c2878a9b4ae1e1dc1f39c10.1584515853.git.viresh.kumar@linaro.org>
References: <31b0bde3ac9d0e617c2878a9b4ae1e1dc1f39c10.1584515853.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2cENViHP=gXjuZKbhUDhVf=msLohnSjZYrPNJBTJOZ3jg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 18, 2020 at 3:18 PM Viresh Kumar <viresh.kumar@linaro.org>
wrote:

> The current check, uinfo->si_value.sival_int == DATA, will always
> evaluate to true as we are checking uinfo by mistake instead of the
> pointer passed to the callback. Fix it.
>

Pushed. Thanks for the fix.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200318/fc4c3f92/attachment.htm>
