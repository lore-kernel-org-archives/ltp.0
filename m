From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Jun 2019 13:49:52 +0200
Subject: [LTP] [PATCH v2] security: add missing
 PR_CAPBSET_READ/PR_CAPBSET_DROP check
In-Reply-To: <1557989579-3661-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190515143746.GA7507@dell5510>
 <1557989579-3661-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190620114952.GA31382@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> PR_CAPBSET_READ/PR_CAPNSET_DROP was added since linux2.6.25,
> current ltp detected them in ltp-prctl.m4, but three places
> missed this check. So add it, fix possible compiler error
> on some old dirtros without PR_CAPBSET_READ/PR_CAPNSET_DROP flag.

Thanks for your patch, merged.

BTW these cap files would deserve converting into new API.

Kind regards,
Petr
