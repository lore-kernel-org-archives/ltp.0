From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 29 Oct 2020 11:39:49 +0100
Subject: [LTP] [PATCH v2 2/2] lib/tst_kconfig: Make use of boolean
 expression eval
In-Reply-To: <5F98E958.7070302@cn.fujitsu.com>
References: <20201027110446.20416-1-chrubis@suse.cz>
 <20201027110446.20416-3-chrubis@suse.cz>
 <5F98E958.7070302@cn.fujitsu.com>
Message-ID: <20201029103949.GA8378@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > -void tst_kconfig_read(const char *const *kconfigs,
> > -                      struct tst_kconfig_res results[], size_t cnt)
> Hi Cyril,
> 
> New tst_kconfig_read() breaks the compilation of acct02 so we also need 
> to update acct02. :-)

Good catch, will fix that.

-- 
Cyril Hrubis
chrubis@suse.cz
