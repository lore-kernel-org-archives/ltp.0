From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 2 Sep 2021 10:23:16 +0200
Subject: [LTP] [PATCH] syscalls/creat09: Add another linux tag
In-Reply-To: <61307148.1050605@fujitsu.com>
References: <1630564446-3393-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <61307148.1050605@fujitsu.com>
Message-ID: <YTCJ9KrZTMDg+Wsp@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> >   	.tags = (const struct tst_tag[]) {
> >   		{"linux-git", "0fa3ecd87848"},
> >   		{"CVE", "2018-13405"},
> > +		{"linux-git", "01ea173e103e"}
> Sorry, I miss comma here.
Fixed and merged. Thanks!

Kind regards,
Petr
