From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 29 Aug 2017 11:07:43 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] device-drivers/zram01: Fix failures on
 ppc64le
In-Reply-To: <20170829112611.GD31839@rei.lan>
References: <20170821140746.15734-1-chrubis@suse.cz>
 <20170829112611.GD31839@rei.lan>
Message-ID: <1599039302.5555940.1504019263297.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> Ping, any comments to this patch?

I don't see other options at the moment. We need to pick
some sane size, since number from mkfs is not reliable.

Regards,
Jan
