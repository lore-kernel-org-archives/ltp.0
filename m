From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Apr 2018 14:46:49 +0200
Subject: [LTP] [PATCH] cve-2017-16939: drop linux/xfrm.h include
In-Reply-To: <d54cb909eacb6c2fe6b11f7e187862ef3070499c.1524739878.git.jstancek@redhat.com>
References: <d54cb909eacb6c2fe6b11f7e187862ef3070499c.1524739878.git.jstancek@redhat.com>
Message-ID: <20180426124649.fk3a2ylcb76rgros@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Mixing libc and linux headers can cause conflicts on some
> distros. Drop linux/xfrm.h include and add needed defines
> to a new lapi header.

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
Tested-by: Petr Vorel <pvorel@suse.cz>

Tested on various distros (but not affected RHEL 7.2).

Kind regards,
Petr
