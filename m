From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 9 May 2020 09:18:48 +0200
Subject: [LTP] [PATCH] travis: Enable fedora:lastest again
In-Reply-To: <1588999374-22808-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1588999374-22808-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200509071848.GA287540@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> fedora:lastest docker image has been updated, it doesn't have file
> conflicts problem with libtirpc rpm. So enable fedora:lastest again.

> url:
> https://travis-ci.org/github/xuyang0410/ltp/jobs/684940178

> -          env: DISTRO=fedora:rawhide MAKE_INSTALL=1
> +          env: DISTRO=fedora:latest MAKE_INSTALL=1
Thanks for testing and taking care. According to [1], latest is actually 31. The
point of using Fedora is to have very new system (newest glibc etc.). Thus I
prefer to use rawhide (previously referenced as 33). In case of problems with
rawhide I would be for temporary downgrading to 32.

Kind regards,
Petr

[1] https://hub.docker.com/_/fedora
