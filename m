From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Aug 2016 14:32:20 +0200
Subject: [LTP] [PATCH] du01: create the temp file outside of the working
 directory
In-Reply-To: <1469451123-9296-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1469451123-9296-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160817123220.GD10343@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
FYI: I've reproduced this on ppc64le with Btrfs as well.

-- 
Cyril Hrubis
chrubis@suse.cz
