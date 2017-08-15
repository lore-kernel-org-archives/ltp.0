From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Aug 2017 11:23:26 +0200
Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
In-Reply-To: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
References: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
Message-ID: <20170815092326.GA20715@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looks like we went off-topic and the zram01.sh test wasn't fixed in the
end and it still fails on ppc64le.

I guess I can prepare a patch that checks if there is enough free RAM
for a minimal Btrfs fs but I would still like to obtain the minimal size
from mkfs.btrfs. Does that sound reasonable?

-- 
Cyril Hrubis
chrubis@suse.cz
