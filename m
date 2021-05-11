From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 May 2021 15:54:21 +0200
Subject: [LTP] [PATCH 1/2] libclone: Move test.h include to C file
In-Reply-To: <YJo+ZFMqcOZ0KXvD@yuki>
References: <20210219144704.20433-1-pvorel@suse.cz>
 <20210219144704.20433-2-pvorel@suse.cz> <YJo+ZFMqcOZ0KXvD@yuki>
Message-ID: <YJqMjdXEbbuD0t5e@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> This looks obviously OK.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

FYI libclone.h is no longer needed for netns_netlink.c, thus no need to merge it
now. I suppose libclone will not be migrated to new API (mqns_helper.h will use
SAFE_CLONE() or something else else if needed to be kept), thus not merging.

Kind regards,
Petr
