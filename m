From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 31 Aug 2016 15:55:45 +0200
Subject: [LTP] [PATCH] lsmod01: parse a copy of /proc/modules
In-Reply-To: <1472468916-13152-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472468916-13152-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160831135545.GB7346@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Thinking of this again, why don't we just compare the first two fields
of the output?

-- 
Cyril Hrubis
chrubis@suse.cz
