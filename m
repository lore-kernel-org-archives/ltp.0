From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 29 Aug 2017 17:25:53 +0200
Subject: [LTP] [RFC] [PATCH] device-drivers/zram01: Fix failures on
 ppc64le
In-Reply-To: <1599039302.5555940.1504019263297.JavaMail.zimbra@redhat.com>
References: <20170821140746.15734-1-chrubis@suse.cz>
 <20170829112611.GD31839@rei.lan>
 <1599039302.5555940.1504019263297.JavaMail.zimbra@redhat.com>
Message-ID: <20170829152553.GB18897@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Hi!
> > Ping, any comments to this patch?
> 
> I don't see other options at the moment. We need to pick
> some sane size, since number from mkfs is not reliable.

Pushed with your ack.

-- 
Cyril Hrubis
chrubis@suse.cz
