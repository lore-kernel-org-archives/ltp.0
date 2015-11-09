From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Nov 2015 16:26:08 +0100
Subject: [LTP] [PATCH] containers/netns/netns_sysfs.sh:load dummy module
 before collecting sysfs interface
In-Reply-To: <5640B9B7.9080201@redhat.com>
References: <1446195470-7568-1-git-send-email-shuang.qiu@oracle.com>
 <563CE067.90803@redhat.com> <20151109141449.GA23375@rei>
 <5640B9B7.9080201@redhat.com>
Message-ID: <20151109152607.GA23947@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> So it boils down to either doing a preemptive modprobe 2>/dev/null or
> ignoring dummy[0-9]+, it's up to you. :)

I don't really care :), both are valid solutions. Maybe we should flip a
coin and decide.

Well since you attached a patch to this email allready I will spare us
from doubt and simply apply it, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
