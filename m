From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Nov 2020 14:47:22 +0800
Subject: [LTP] [PATCH] lapi/name_to_handle_at.h: Fix compiler error on
 centos6
In-Reply-To: <5FBF3A16.6090101@cn.fujitsu.com>
References: <20201126012838.531070-1-yangx.jy@cn.fujitsu.com>
 <CAEemH2eQNTy9V+NSn+kwV8zZ0BTr+PEHuD_RPhx3Ns1v=+iPNw@mail.gmail.com>
 <5FBF3A16.6090101@cn.fujitsu.com>
Message-ID: <CAEemH2c3U7DY70QiVKZoUhdtLdr0QBc+VqAkFt9GzoUp-kmbyA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 26, 2020 at 1:16 PM Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> On 2020/11/26 12:33, Li Wang wrote:
>
> Hi Xiao,
>
> The patch itself looks good, but I remember we were planning to
> drop support for the old distro e.g CentOS6.
>
> The previous discussion here:
> http://lists.linux.it/pipermail/ltp/2020-March/016164.html
>
> Hi Li,
>
> Thanks for sharing the infomation.
> When do you plan to remove old distro? next release?
>

As discussed in the previous mail, it should be accomplished in the current
release 20200930.
@Petr Vorel <pvorel@suse.cz>  @Cyril Hrubis <chrubis@suse.cz> what do you
think?


> BTW:
> It may also resolve the compiler error on uclibc as Fabrice Fontaine
> reported before:
>
> https://github.com/linux-test-project/ltp/commit/cb11e718ce04261cb6ff4c09442b949da33b8797
>

Thanks, I helped merge this one since CentOS6 is still supported in
Travis-CI now.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201126/73de7ef7/attachment.htm>
