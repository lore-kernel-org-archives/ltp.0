From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Nov 2020 10:19:53 +0100
Subject: [LTP] [PATCH] lapi/name_to_handle_at.h: Fix compiler error on
 centos6
In-Reply-To: <CAEemH2c3U7DY70QiVKZoUhdtLdr0QBc+VqAkFt9GzoUp-kmbyA@mail.gmail.com>
References: <20201126012838.531070-1-yangx.jy@cn.fujitsu.com>
 <CAEemH2eQNTy9V+NSn+kwV8zZ0BTr+PEHuD_RPhx3Ns1v=+iPNw@mail.gmail.com>
 <5FBF3A16.6090101@cn.fujitsu.com>
 <CAEemH2c3U7DY70QiVKZoUhdtLdr0QBc+VqAkFt9GzoUp-kmbyA@mail.gmail.com>
Message-ID: <20201126091953.GA4646@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> As discussed in the previous mail, it should be accomplished in the current
> release 20200930.
> @Petr Vorel <pvorel@suse.cz>  @Cyril Hrubis <chrubis@suse.cz> what do you
> think?

Unless anybody objects I would go for it. I guess that first step would
be removign CentOS6 from travis.

-- 
Cyril Hrubis
chrubis@suse.cz
